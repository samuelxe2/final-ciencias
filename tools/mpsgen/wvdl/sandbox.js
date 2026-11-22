// Sandbox models: valid workflows, invalid ones (static semantics) and invalid
// ones caught by the reasoner, plus the case study of the proposal (Anexo A).
'use strict';
const path = require('path');

function dsl(G, S) {
  const { N } = G;
  // Workflow builder; returns the root node and its element nodes.
  return function wf(name, fill) {
    const st = {}, roles = {}, actors = {}, vars = {}, acts = {}, trs = {}, guards = {}, checks = [];
    const c = { states: [], roles: [], actors: [], assignments: [], variables: [], activities: [], transitions: [], checks };
    const api = {
      init: n => { st[n] = N('wvdl:InitialState', { name: n }); c.states.push(st[n]); return api; },
      state: n => { st[n] = N('wvdl:OrdinaryState', { name: n }); c.states.push(st[n]); return api; },
      fin: n => { st[n] = N('wvdl:FinalState', { name: n }); c.states.push(st[n]); return api; },
      human: n => { roles[n] = N('wvdl:HumanRole', { name: n }); c.roles.push(roles[n]); return api; },
      system: n => { roles[n] = N('wvdl:SystemRole', { name: n }); c.roles.push(roles[n]); return api; },
      actor: n => { actors[n] = N('wvdl:Actor', { name: n }); c.actors.push(actors[n]); return api; },
      assign: (a, r) => { c.assignments.push(N('wvdl:Assignment', { actor: actors[a], role: roles[r] })); return api; },
      variable: (n, type, init) => {
        vars[n] = N('wvdl:Variable', { name: n, type: N(`wvdl:${type}Type`), init });
        c.variables.push(vars[n]); return api;
      },
      manual: (n, r) => { acts[n] = N('wvdl:ManualActivity', { name: n, role: roles[r] }); c.activities.push(acts[n]); return api; },
      auto: (n, r) => { acts[n] = N('wvdl:AutomatedActivity', { name: n, role: roles[r] }); c.activities.push(acts[n]); return api; },
      // tr(name, from, to, {via, guard}) — from/to may be a node (to reference foreign states)
      tr: (n, from, to, opt = {}) => {
        const s = typeof from === 'string' ? st[from] : from, t = typeof to === 'string' ? st[to] : to;
        const guard = opt.guard ? N('wvdl:Guard', { condition: opt.guard }) : undefined;
        trs[n] = N('wvdl:Transition', {
          name: n,
          from: N('wvdl:SourceRef', { state: s }),
          to: N('wvdl:TargetRef', { state: t }),
          via: opt.via ? N('wvdl:ActivityRef', { activity: acts[opt.via] }) : undefined,
          guard,
        });
        if (guard) guards[n] = guard;
        c.transitions.push(trs[n]);
        return api;
      },
      // verificaciones declarativas (el razonador debe confirmarlas)
      reachable: n => { checks.push(N('wvdl:ReachableCheck', { state: st[n] })); return api; },
      sound: () => { checks.push(N('wvdl:SoundCheck')); return api; },
      path: (n, ts) => { checks.push(N('wvdl:PathCheck', { state: st[n], steps: ts.map(t => N('wvdl:TransitionRef', { transition: trs[t] })) })); return api; },
      actorsOf: (a, as) => { checks.push(N('wvdl:ActorsCheck', { activity: acts[a], actors: as.map(x => N('wvdl:ActorRef', { actor: actors[x] })) })); return api; },
      endsIn: n => { checks.push(N('wvdl:SimulationCheck', { state: st[n] })); return api; },
      // expression helpers
      v: n => N('wvdl:VarRef', { variable: vars[n] }),
      int: x => N('wvdl:IntLiteral', { value: String(x) }),
      bool: x => N('wvdl:BoolLiteral', { value: String(x) }),
      str: x => N('wvdl:StringLiteral', { value: x }),
      eq: (a, b) => N('wvdl:EqExpr', { left: a, right: b }),
      lt: (a, b) => N('wvdl:LtExpr', { left: a, right: b }),
      and: (a, b) => N('wvdl:AndExpr', { left: a, right: b }),
      or: (a, b) => N('wvdl:OrExpr', { left: a, right: b }),
      not: a => N('wvdl:NotExpr', { operand: a }),
      st,
    };
    fill(api);
    const root = N('wvdl:Workflow', { name, ...c });
    Object.assign(root, { states: st, acts, trs, guards, roles, vars, checkNodes: checks });
    return root;
  };
}

module.exports.dsl = dsl;

module.exports.cases = (G, S) => {
  const wf = dsl(G, S);
  // ---------------------------------------------------------------- válidos
  const V01 = wf('V01_Lineal', w => w
    .human('Revisor').actor('Ana').assign('Ana', 'Revisor').manual('Revisar', 'Revisor')
    .init('Inicio').state('Revision').fin('Aprobado')
    .tr('T1', 'Inicio', 'Revision').tr('T2', 'Revision', 'Aprobado', { via: 'Revisar' })
    .sound().reachable('Aprobado').path('Aprobado', ['T1', 'T2']).actorsOf('Revisar', ['Ana']).endsIn('Aprobado'));

  const V02 = wf('V02_Ramificacion', w => {
    w.variable('monto', 'Integer', w.int(500)).human('Validador').actor('Luis').assign('Luis', 'Validador').manual('Validar', 'Validador')
      .init('Inicio').state('Validacion').fin('Aprobado').fin('Rechazado')
      .tr('T1', 'Inicio', 'Validacion')
      .tr('T2', 'Validacion', 'Aprobado', { via: 'Validar', guard: w.lt(w.v('monto'), w.int(1000)) })
      .tr('T3', 'Validacion', 'Rechazado', { via: 'Validar', guard: w.not(w.lt(w.v('monto'), w.int(1000))) })
      .sound().path('Rechazado', ['T1', 'T3']).endsIn('Aprobado');
  });

  const V03 = wf('V03_Automatizado', w => w
    .system('MotorReglas').human('Revisor').actor('Bot').actor('Ana').assign('Bot', 'MotorReglas').assign('Ana', 'Revisor')
    .auto('CalcularRiesgo', 'MotorReglas').manual('Revisar', 'Revisor')
    .variable('aprobado', 'Boolean', w.bool(true))
    .init('Inicio').state('Revision').fin('Fin')
    .tr('T1', 'Inicio', 'Revision', { via: 'CalcularRiesgo' })
    .tr('T2', 'Revision', 'Revision', { via: 'Revisar', guard: w.not(w.v('aprobado')) })
    .tr('T3', 'Revision', 'Fin', { via: 'Revisar', guard: w.v('aprobado') })
    .sound().actorsOf('CalcularRiesgo', ['Bot']).endsIn('Fin'));


  // ---------------------------------------------------------------- inválidos (semántica estática)
  const otro = wf('Otro_Workflow', w => w.init('Inicio').fin('Externo').tr('T1', 'Inicio', 'Externo'));
  const IS1 = wf('IS1_ReferenciaAjena', w => w
    .init('Inicio').fin('Fin')
    .tr('T1', 'Inicio', 'Fin')
    .tr('T2', 'Inicio', otro.states.Externo)); // destino de OTRO workflow: fuera de alcance
  const IS2 = wf('IS2_GuardaNoBooleana', w => {
    w.variable('monto', 'Integer').init('Inicio').fin('Fin')
      .tr('T1', 'Inicio', 'Fin', { guard: w.v('monto') }); // T-GUARD: Integer no es Boolean
  });
  const IS3 = wf('IS3_RolIncompatible', w => w
    .human('Revisor').actor('Ana').assign('Ana', 'Revisor')
    .auto('Calcular', 'Revisor') // T-ROLE: automática con rol humano
    .init('Inicio').init('Inicio2').fin('Fin') // I1: dos estados iniciales
    .tr('T1', 'Inicio', 'Fin', { via: 'Calcular' }).tr('T2', 'Inicio2', 'Fin'));

  // ---------------------------------------------------------------- inválidos (razonador)
  const IR1 = wf('IR1_Inalcanzable', w => w
    .init('Inicio').fin('Fin').state('Archivado')
    .tr('T1', 'Inicio', 'Fin').tr('T2', 'Archivado', 'Fin'));
  const IR2 = wf('IR2_Deadlock', w => w
    .init('Inicio').state('Espera').state('Revision').fin('Fin')
    .tr('T1', 'Inicio', 'Revision').tr('T2', 'Revision', 'Fin').tr('T3', 'Revision', 'Espera'));
  const IR3 = wf('IR3_Livelock', w => w
    .init('Inicio').state('Revision').state('Correccion').fin('Fin')
    .tr('T1', 'Inicio', 'Fin').tr('T2', 'Inicio', 'Revision').tr('T3', 'Revision', 'Correccion').tr('T4', 'Correccion', 'Revision'));
  const IR4 = wf('IR4_GuardaMuertaYRol', w => {
    w.variable('x', 'Integer').human('Auditor').manual('Auditar', 'Auditor')
      .init('Inicio').fin('Fin').fin('Excepcion')
      .tr('T1', 'Inicio', 'Fin', { via: 'Auditar' })
      .tr('T2', 'Inicio', 'Excepcion', { guard: w.and(w.lt(w.v('x'), w.int(1)), w.eq(w.v('x'), w.int(5))) });
  });

  // ---------------------------------------------------------------- caso de estudio (Anexo A ampliado)
  const caso = wf('SolicitudCompra', w => {
    w.variable('monto', 'Integer', w.int(2500)).variable('urgente', 'Boolean', w.bool(false)).variable('area', 'String', w.str('TI'))
      .human('Solicitante').human('Aprobador').human('Director').system('ERP')
      .actor('Carla').actor('Mario').actor('Sofia').actor('SAP')
      .assign('Carla', 'Solicitante').assign('Mario', 'Aprobador').assign('Sofia', 'Director').assign('SAP', 'ERP')
      .manual('RegistrarSolicitud', 'Solicitante').manual('RevisarSolicitud', 'Aprobador').manual('AutorizarGasto', 'Director')
      .auto('EmitirOrden', 'ERP')
      .init('Inicio').state('EnRevision').state('RevisionDirector').state('OrdenEmitida').fin('Aprobada').fin('Rechazada').state('Archivada')
      .tr('T1', 'Inicio', 'EnRevision', { via: 'RegistrarSolicitud' })
      .tr('T2', 'EnRevision', 'OrdenEmitida', { via: 'RevisarSolicitud', guard: w.lt(w.v('monto'), w.int(1000)) })
      .tr('T3', 'EnRevision', 'RevisionDirector', { via: 'RevisarSolicitud', guard: w.not(w.lt(w.v('monto'), w.int(1000))) })
      .tr('T4', 'RevisionDirector', 'OrdenEmitida', { via: 'AutorizarGasto', guard: w.or(w.v('urgente'), w.eq(w.v('area'), w.str('TI'))) })
      .tr('T5', 'RevisionDirector', 'Rechazada', { via: 'AutorizarGasto', guard: w.not(w.or(w.v('urgente'), w.eq(w.v('area'), w.str('TI')))) })
      .tr('T6', 'OrdenEmitida', 'Aprobada', { via: 'EmitirOrden' })
      .sound().reachable('Rechazada').path('Aprobada', ['T1', 'T2', 'T6']).actorsOf('AutorizarGasto', ['Sofia']).endsIn('Aprobada');
  });
  // contraejemplo: afirmaciones FALSAS que el razonador debe refutar
  const CE = wf('CE_VerificacionesFalsas', w => w
    .human('Revisor').actor('Ana').actor('Luis').assign('Ana', 'Revisor').manual('Revisar', 'Revisor')
    .init('Inicio').state('Revision').state('Bucle').fin('Fin').state('Olvidado')
    .tr('T1', 'Inicio', 'Revision').tr('T2', 'Revision', 'Fin', { via: 'Revisar' }).tr('T3', 'Revision', 'Bucle').tr('T4', 'Bucle', 'Bucle')
    .reachable('Olvidado')                 // falso: Olvidado es inalcanzable
    .sound()                               // falso: Bucle es un livelock
    .path('Fin', ['T1', 'T3'])             // falso: la ruta es T1,T2
    .actorsOf('Revisar', ['Ana', 'Luis'])  // falso: solo Ana tiene el rol
    .endsIn('Bucle'));                     // falso: la simulación termina en Fin
  return { V01, V02, V03, otro, IS1, IS2, IS3, IR1, IR2, IR3, IR4, caso, CE };
};

module.exports.build = ({ G, S, models, fileOf, ROOT }) => {
  const c = module.exports.cases(G, S);
  const use = [{ id: S.LANG_ID, name: 'wvdl', version: 0 }];
  const dir = path.join(ROOT, 'solutions', 'wvdl.sandbox', 'models');
  const model = (name, ...roots) => {
    const m = new G.Model(name, { uses: use });
    m.add(...roots);
    models.push(m);
    fileOf.set(m, path.join(dir, name + '.mps'));
  };
  model('wvdl.sandbox.validos', c.V01, c.V02, c.V03);
  model('wvdl.sandbox.invalidos_estaticos', c.otro, c.IS1, c.IS2, c.IS3);
  model('wvdl.sandbox.invalidos_razonador', c.IR1, c.IR2, c.IR3, c.IR4);
  model('wvdl.sandbox.caso_estudio', c.caso);
  model('wvdl.sandbox.contraejemplo', c.CE);
};
