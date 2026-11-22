package wvdl.reasoner;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import wvdl.reasoner.analysis.Analyzer;
import wvdl.reasoner.analysis.Finding;
import wvdl.reasoner.analysis.GuardSolver;
import wvdl.reasoner.model.Expr;
import wvdl.reasoner.model.Type;
import wvdl.reasoner.model.WfModel;
import wvdl.reasoner.model.WfModel.StateKind;
import wvdl.reasoner.report.JsonReport;

/** Pruebas del razonador sin MPS (java -cp ... wvdl.reasoner.ReasonerSelfTest). */
public final class ReasonerSelfTest {

  private static int failures = 0, checks = 0;

  // ---------------------------------------------------------------- builder
  static final class B {
    final WfModel m;
    B(String name) { m = new WfModel(name, null); }
    B st(String n, StateKind k) { m.states.add(new WfModel.State(n, k, null)); return this; }
    B init(String n) { return st(n, StateKind.INITIAL); }
    B ord(String n) { return st(n, StateKind.ORDINARY); }
    B fin(String n) { return st(n, StateKind.FINAL); }
    B human(String n) { m.roles.add(new WfModel.Role(n, WfModel.RoleKind.HUMAN, null)); return this; }
    B system(String n) { m.roles.add(new WfModel.Role(n, WfModel.RoleKind.SYSTEM, null)); return this; }
    B actor(String n) { m.actors.add(new WfModel.Actor(n, null)); return this; }
    B assign(String a, String r) { m.assignments.add(new WfModel.Assignment(m.actor(a), m.role(r), null)); return this; }
    B manual(String n, String role) { m.activities.add(new WfModel.Activity(n, WfModel.ActivityKind.MANUAL, m.role(role), null)); return this; }
    B auto(String n, String role) { m.activities.add(new WfModel.Activity(n, WfModel.ActivityKind.AUTOMATED, m.role(role), null)); return this; }
    B var(String n, Type t) { m.variables.add(new WfModel.Variable(n, t, null, null)); return this; }
    B var(String n, Type t, Expr init) { m.variables.add(new WfModel.Variable(n, t, init, null)); return this; }
    B tr(String n, String from, String to) { return tr(n, from, to, null, null); }
    B tr(String n, String from, String to, String act, Expr guard) {
      m.transitions.add(new WfModel.Transition(n, m.state(from), m.state(to), act == null ? null : m.activity(act), guard, guard, null));
      return this;
    }
    Expr v(String n) { return new Expr.VarRef(m.variable(n), null); }
  }
  static Expr i(long v) { return new Expr.IntLit(v, null); }
  static Expr b(boolean v) { return new Expr.BoolLit(v, null); }
  static Expr s(String v) { return new Expr.StrLit(v, null); }
  static Expr eq(Expr a, Expr c) { return new Expr.Binary(Expr.Op.EQ, a, c, null); }
  static Expr lt(Expr a, Expr c) { return new Expr.Binary(Expr.Op.LT, a, c, null); }
  static Expr and(Expr a, Expr c) { return new Expr.Binary(Expr.Op.AND, a, c, null); }
  static Expr or(Expr a, Expr c) { return new Expr.Binary(Expr.Op.OR, a, c, null); }
  static Expr not(Expr a) { return new Expr.Not(a, null); }

  static Set<String> codes(Analyzer.Result r) { Set<String> s = new TreeSet<>(); for (Finding f : r.findings) s.add(f.code); return s; }

  static void check(String name, boolean ok, Object detail) {
    checks++;
    if (!ok) { failures++; System.out.println("FAIL " + name + " -> " + detail); }
    else System.out.println("ok   " + name);
  }
  static void expectCodes(String name, Analyzer.Result r, String... expected) {
    Set<String> exp = new TreeSet<>(List.of(expected));
    check(name, codes(r).equals(exp), "esperado " + exp + " obtenido " + r.findings);
  }

  public static void main(String[] args) {
    // V-01 lineal
    B v1 = new B("V01").init("Inicio").ord("Revision").fin("Aprobado").tr("T1", "Inicio", "Revision").tr("T2", "Revision", "Aprobado");
    Analyzer.Result r1 = Analyzer.analyze(v1.m);
    expectCodes("V-01 lineal válido", r1);
    check("V-01 status VALID", r1.status().equals("VALID"), r1.status());
    check("V-01 ruta T1,T2", r1.pathsToFinals.values().iterator().next().size() == 2, r1.pathsToFinals);
    check("V-01 simulación llega a final", r1.simulation.outcome.name().equals("FINAL_REACHED"), r1.simulation.outcome);

    // V-02 ramificación con guardas complementarias
    B v2 = new B("V02").var("monto", Type.INTEGER, i(500)).init("Inicio").ord("Validacion").fin("Aprobado").fin("Rechazado");
    v2.tr("T1", "Inicio", "Validacion").tr("T2", "Validacion", "Aprobado", null, lt(v2.v("monto"), i(1000)))
      .tr("T3", "Validacion", "Rechazado", null, not(lt(v2.v("monto"), i(1000))));
    Analyzer.Result r2 = Analyzer.analyze(v2.m);
    expectCodes("V-02 ramificación válida", r2);
    check("V-02 simulación con monto=500 termina en Aprobado", r2.simulation.last.name.equals("Aprobado"), r2.simulation.last);

    // V-03 actividad automática con rol de sistema + auto-bucle
    B v3 = new B("V03").system("Motor").human("Revisor").actor("Bot").actor("Ana").assign("Bot", "Motor").assign("Ana", "Revisor")
        .auto("Calcular", "Motor").manual("Revisar", "Revisor").init("Inicio").ord("Revision").fin("Fin");
    v3.tr("T1", "Inicio", "Revision", "Calcular", null).tr("T2", "Revision", "Revision", "Revisar", null).tr("T3", "Revision", "Fin", "Revisar", null);
    Analyzer.Result r3 = Analyzer.analyze(v3.m);
    expectCodes("V-03 auto-bucle y roles compatibles", r3);

    // I-S2 guarda no booleana
    B is2 = new B("IS2").var("monto", Type.INTEGER).init("A").fin("B");
    is2.tr("T1", "A", "B", null, is2.v("monto"));
    expectCodes("I-S2 T-GUARD", Analyzer.analyze(is2.m), "T-GUARD");

    // I-S3 rol incompatible + dos iniciales
    B is3 = new B("IS3").human("Revisor").auto("Calcular", "Revisor").init("A").init("A2").fin("B").tr("T1", "A", "B").tr("T2", "A2", "B");
    expectCodes("I-S3 T-ROLE + I1", Analyzer.analyze(is3.m), "T-ROLE", "WF-MULTIPLE-INITIAL");

    // tipos en expresiones
    B ty = new B("TY").var("x", Type.INTEGER).var("ok", Type.BOOLEAN).var("s", Type.STRING, i(3)).init("A").fin("B");
    ty.tr("T1", "A", "B", null, and(ty.v("ok"), eq(ty.v("x"), b(true))));
    ty.tr("T2", "A", "B", null, lt(ty.v("s"), i(1)));
    expectCodes("tipos T-EQ, T-LT, T-INIT", Analyzer.analyze(ty.m), "T-EQ", "T-LT", "T-INIT");

    // integridad: sin finales, nombres duplicados, salida desde final
    B ig = new B("IG").init("A").ord("A").tr("T1", "A", "A");
    expectCodes("I2 + I3", Analyzer.analyze(ig.m), "WF-NO-FINAL", "WF-DUPLICATE-NAME");
    B fs = new B("FS").init("A").fin("B").tr("T1", "A", "B").tr("T2", "B", "A");
    expectCodes("final absorbente", Analyzer.analyze(fs.m), "WF-FINAL-SOURCE");

    // I-R1 inalcanzable
    B ir1 = new B("IR1").init("Inicio").fin("Fin").ord("Archivado").tr("T1", "Inicio", "Fin").tr("T2", "Archivado", "Fin");
    Analyzer.Result rr1 = Analyzer.analyze(ir1.m);
    expectCodes("I-R1 WF-UNREACHABLE", rr1, "WF-UNREACHABLE");
    check("I-R1 status WARNING", rr1.status().equals("WARNING"), rr1.status());

    // I-R2 deadlock (y, por ende, sin terminación)
    B ir2 = new B("IR2").init("Inicio").ord("Espera").fin("Fin").tr("T1", "Inicio", "Espera");
    expectCodes("I-R2 WF-DEADLOCK", Analyzer.analyze(ir2.m), "WF-DEADLOCK", "WF-TRAPPED", "WF-UNREACHABLE", "WF-NO-TERMINATION");

    // I-R3 livelock: Revision <-> Correccion sin salida, pero otro camino sí termina
    B ir3 = new B("IR3").init("Inicio").ord("Revision").ord("Correccion").fin("Fin");
    ir3.tr("T0", "Inicio", "Fin").tr("T1", "Inicio", "Revision").tr("T2", "Revision", "Correccion").tr("T3", "Correccion", "Revision");
    Analyzer.Result rr3 = Analyzer.analyze(ir3.m);
    expectCodes("I-R3 WF-LIVELOCK", rr3, "WF-LIVELOCK");
    check("I-R3 SCC = {Revision, Correccion}", rr3.livelocks.size() == 1 && rr3.livelocks.get(0).size() == 2, rr3.livelocks);

    // trapped que desemboca en un livelock
    B tp = new B("TP").init("Inicio").ord("Puente").ord("L").fin("Fin").tr("T0", "Inicio", "Fin").tr("T1", "Inicio", "Puente").tr("T2", "Puente", "L").tr("T3", "L", "L");
    expectCodes("WF-TRAPPED + livelock por auto-bucle", Analyzer.analyze(tp.m), "WF-TRAPPED", "WF-LIVELOCK");

    // I-R4 guarda muerta + rol sin actor
    B ir4 = new B("IR4").var("x", Type.INTEGER).human("Auditor").manual("Auditar", "Auditor").init("Inicio").fin("Fin").fin("Raro");
    ir4.tr("T1", "Inicio", "Fin", "Auditar", null).tr("T2", "Inicio", "Raro", null, and(lt(ir4.v("x"), i(1)), eq(ir4.v("x"), i(5))));
    Analyzer.Result rr4 = Analyzer.analyze(ir4.m);
    expectCodes("I-R4 WF-DEAD-GUARD + WF-UNASSIGNED-ROLE (+ Raro inalcanzable)", rr4, "WF-DEAD-GUARD", "WF-UNASSIGNED-ROLE", "WF-UNREACHABLE");

    // deadlock por guardas muertas
    B dg = new B("DG").var("ok", Type.BOOLEAN).init("A").fin("B");
    dg.tr("T1", "A", "B", null, and(dg.v("ok"), not(dg.v("ok"))));
    expectCodes("deadlock por guardas insatisfacibles", Analyzer.analyze(dg.m), "WF-DEAD-GUARD", "WF-DEADLOCK", "WF-UNREACHABLE", "WF-NO-TERMINATION");

    // GuardSolver
    B gs = new B("GS").var("x", Type.INTEGER).var("y", Type.INTEGER).var("s", Type.STRING);
    check("SAT x<y and y<x es UNSAT", GuardSolver.satisfiable(and(lt(gs.v("x"), gs.v("y")), lt(gs.v("y"), gs.v("x")))) == GuardSolver.Result.UNSAT, "");
    check("SAT x<y and y<3 and 1<x es UNSAT (no hay entero entre 1 y 3 para dos variables)",
        GuardSolver.satisfiable(and(and(lt(gs.v("x"), gs.v("y")), lt(gs.v("y"), i(3))), lt(i(1), gs.v("x")))) == GuardSolver.Result.UNSAT, "");
    check("SAT x<y and y<4 and 1<x es SAT (x=2,y=3)",
        GuardSolver.satisfiable(and(and(lt(gs.v("x"), gs.v("y")), lt(gs.v("y"), i(4))), lt(i(1), gs.v("x")))) == GuardSolver.Result.SAT, "");
    check("SAT s==\"a\" and not(s==\"b\") es SAT", GuardSolver.satisfiable(and(eq(gs.v("s"), s("a")), not(eq(gs.v("s"), s("b"))))) == GuardSolver.Result.SAT, "");
    check("SAT not(s==\"a\") or s==\"a\" es SAT", GuardSolver.satisfiable(or(not(eq(gs.v("s"), s("a"))), eq(gs.v("s"), s("a")))) == GuardSolver.Result.SAT, "");

    // Verificaciones declaradas
    B ck = new B("CK").human("Revisor").actor("Ana").assign("Ana", "Revisor").manual("Revisar", "Revisor")
        .init("Inicio").ord("Revision").fin("Fin").ord("Huerfano").tr("T1", "Inicio", "Revision").tr("T2", "Revision", "Fin", "Revisar", null);
    WfModel.Check ok1 = new WfModel.Check(WfModel.Check.Kind.REACHABLE, ck.m.state("Fin"), null, null);
    WfModel.Check ok2 = new WfModel.Check(WfModel.Check.Kind.PATH, ck.m.state("Fin"), null, null);
    ok2.steps.add(ck.m.transitions.get(0)); ok2.steps.add(ck.m.transitions.get(1));
    WfModel.Check ok3 = new WfModel.Check(WfModel.Check.Kind.ACTORS, null, ck.m.activity("Revisar"), null);
    ok3.actors.add(ck.m.actor("Ana"));
    WfModel.Check ok4 = new WfModel.Check(WfModel.Check.Kind.SIMULATION, ck.m.state("Fin"), null, null);
    WfModel.Check bad1 = new WfModel.Check(WfModel.Check.Kind.REACHABLE, ck.m.state("Huerfano"), null, null);
    ck.m.checks.addAll(List.of(ok1, ok2, ok3, ok4, bad1));
    Analyzer.Result rck = Analyzer.analyze(ck.m);
    check("verificaciones: 4 PASS y 1 FAIL", rck.checkResults.stream().filter(c -> c.pass).count() == 4 && codes(rck).contains("WF-CHECK-FAILED"), rck.findings);
    B ck2 = new B("CK2").init("A").ord("B").fin("C").tr("T1", "A", "B").tr("T2", "B", "B").tr("T3", "B", "C");
    ck2.m.checks.add(new WfModel.Check(WfModel.Check.Kind.SOUND, null, null, null));
    expectCodes("verificar sound con auto-bucle que sí termina", Analyzer.analyze(ck2.m));

    // JSON determinista
    String j1 = JsonReport.render(Analyzer.analyze(v3.m)), j2 = JsonReport.render(Analyzer.analyze(v3.m));
    check("JSON determinista", j1.equals(j2), "");
    check("JSON contiene status", j1.contains("\"status\": \"VALID\""), j1);
    if (args.length > 0) System.out.println(JsonReport.render(rr4));

    System.out.println(checks - failures + "/" + checks + " pruebas OK");
    if (failures > 0) System.exit(1);
  }
}
