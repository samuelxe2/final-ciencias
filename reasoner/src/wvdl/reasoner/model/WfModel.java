package wvdl.reasoner.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Plain (MPS-independent) representation of a WVDL workflow.
 * The MPS adapter fills it from the AST; every element keeps its origin
 * (the SNode) so that findings can be reported on the right editor node.
 */
public final class WfModel {

  public enum StateKind { INITIAL, ORDINARY, FINAL }
  public enum RoleKind { HUMAN, SYSTEM }
  public enum ActivityKind { MANUAL, AUTOMATED }

  /** Common base: a name and the node it comes from. */
  public abstract static class Element {
    public final String name;
    public final Object origin;
    protected Element(String name, Object origin) {
      this.name = name == null ? "" : name;
      this.origin = origin;
    }
    public abstract String kindLabel();
    @Override public String toString() { return kindLabel() + " " + name; }
  }

  public static final class State extends Element {
    public final StateKind kind;
    public State(String name, StateKind kind, Object origin) { super(name, origin); this.kind = kind; }
    public boolean isFinal() { return kind == StateKind.FINAL; }
    public String kindLabel() { return "estado"; }
  }

  public static final class Role extends Element {
    public final RoleKind kind;
    public Role(String name, RoleKind kind, Object origin) { super(name, origin); this.kind = kind; }
    public String kindLabel() { return "rol"; }
  }

  public static final class Actor extends Element {
    public Actor(String name, Object origin) { super(name, origin); }
    public String kindLabel() { return "actor"; }
  }

  public static final class Assignment extends Element {
    public final Actor actor; // may be null when unresolved
    public final Role role;
    public Assignment(Actor actor, Role role, Object origin) {
      super((actor == null ? "?" : actor.name) + "->" + (role == null ? "?" : role.name), origin);
      this.actor = actor; this.role = role;
    }
    public String kindLabel() { return "asignacion"; }
  }

  public static final class Activity extends Element {
    public final ActivityKind kind;
    public final Role role; // may be null when unresolved
    public Activity(String name, ActivityKind kind, Role role, Object origin) { super(name, origin); this.kind = kind; this.role = role; }
    public String kindLabel() { return "actividad"; }
  }

  public static final class Variable extends Element {
    public final Type type; // may be null when missing
    public final Expr init; // optional initial value (used by the simulator)
    public Variable(String name, Type type, Expr init, Object origin) { super(name, origin); this.type = type; this.init = init; }
    public String kindLabel() { return "variable"; }
  }

  public static final class Transition extends Element {
    public final State source; // may be null when unresolved
    public final State target;
    public final Activity activity; // optional
    public final Expr guard;        // optional
    public final Object guardOrigin;
    public Transition(String name, State source, State target, Activity activity, Expr guard, Object guardOrigin, Object origin) {
      super(name, origin);
      this.source = source; this.target = target; this.activity = activity; this.guard = guard; this.guardOrigin = guardOrigin;
    }
    public String kindLabel() { return "transicion"; }
  }

  /** Propiedad declarada por el usuario que el razonador debe confirmar. */
  public static final class Check extends Element {
    public enum Kind { REACHABLE, SOUND, PATH, ACTORS, SIMULATION }
    public final Kind kind;
    public final State state;          // REACHABLE, PATH, SIMULATION
    public final Activity activity;    // ACTORS
    public final List<Transition> steps = new ArrayList<>(); // PATH
    public final List<Actor> actors = new ArrayList<>();     // ACTORS
    public Check(Kind kind, State state, Activity activity, Object origin) {
      super(kind.name().toLowerCase(), origin);
      this.kind = kind; this.state = state; this.activity = activity;
    }
    public String kindLabel() { return "verificacion"; }
    public String describe() {
      switch (kind) {
        case REACHABLE: return "alcanzable " + (state == null ? "?" : state.name);
        case SOUND: return "sound";
        case PATH: { StringBuilder b = new StringBuilder(); for (Transition t : steps) b.append(b.length() == 0 ? "" : ",").append(t == null ? "?" : t.name); return "ruta hacia " + (state == null ? "?" : state.name) + " = " + b; }
        case ACTORS: { StringBuilder b = new StringBuilder(); for (Actor a : actors) b.append(b.length() == 0 ? "" : ",").append(a == null ? "?" : a.name); return "actores de " + (activity == null ? "?" : activity.name) + " = " + b; }
        default: return "simulacion termina en " + (state == null ? "?" : state.name);
      }
    }
  }

  public final String name;
  public final Object origin;
  public final List<Check> checks = new ArrayList<>();
  public final List<State> states = new ArrayList<>();
  public final List<Role> roles = new ArrayList<>();
  public final List<Actor> actors = new ArrayList<>();
  public final List<Assignment> assignments = new ArrayList<>();
  public final List<Activity> activities = new ArrayList<>();
  public final List<Variable> variables = new ArrayList<>();
  public final List<Transition> transitions = new ArrayList<>();
  /** Referencias a elementos de OTRO workflow (fuera de alcance): {origen, elemento, destino}. */
  public final List<String[]> foreignRefs = new ArrayList<>();
  public final List<Object> foreignRefOrigins = new ArrayList<>();

  public void addForeignRef(Object origin, String element, String target) {
    foreignRefs.add(new String[]{element, target});
    foreignRefOrigins.add(origin);
  }

  public WfModel(String name, Object origin) { this.name = name == null ? "" : name; this.origin = origin; }

  public State state(String n) { for (State s : states) if (s.name.equals(n)) return s; return null; }
  public Role role(String n) { for (Role r : roles) if (r.name.equals(n)) return r; return null; }
  public Actor actor(String n) { for (Actor a : actors) if (a.name.equals(n)) return a; return null; }
  public Activity activity(String n) { for (Activity a : activities) if (a.name.equals(n)) return a; return null; }
  public Variable variable(String n) { for (Variable v : variables) if (v.name.equals(n)) return v; return null; }
}
