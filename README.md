# WVDL — Workflow Verification DSL (JetBrains MPS 2026.2)

DSL para modelar flujos de aprobación y **verificarlos formalmente**. Cada `workflow` se interpreta como un autómata finito M = (S, Σ, δ, s₀, F). El razonador detecta:

- estados inalcanzables,
- bloqueos (*deadlocks*),
- ciclos sin salida (*livelocks*, mediante SCC de Tarjan),
- guardas insatisfacibles,
- roles sin actor asignado.

También comprueba las **verificaciones** que declara el usuario (`verificar sound`, `verificar ruta hacia X = T1, T2`, …) y genera un reporte JSON por workflow.

## Estructura del repositorio

| Ruta | Contenido |
| --- | --- |
| `languages/wvdl/` | Lenguaje MPS: `structure`, `editor`, `behavior` (scoping), `typesystem` y `textGen` |
| `solutions/wvdl.reasoner/` | Módulo MPS que envuelve `lib/wvdl-reasoner.jar` (razonador compilado) |
| `solutions/wvdl.sandbox/` | Modelos de ejemplo: válidos, inválidos, caso de estudio y contraejemplo |
| `solutions/wvdl.tests/` | Pruebas `jetbrains.mps.lang.test` (27 casos) |
| `reasoner/src/` | Código Java del razonador: `model`, `analysis`, `report` y el adaptador `mps` |
| `reasoner/test/` | Pruebas unitarias del razonador en Java puro (29 casos, sin MPS) |
| `reportes/` | Reportes JSON generados para cada workflow de la sandbox |
| `tools/` | Scripts: compilar el razonador, generar y probar con MPS headless, generador de modelos |

## Uso en MPS (IDE)

1. **File → Open** y elegir esta carpeta.
2. **Build → Rebuild Project**.
3. Abrir `wvdl.sandbox` → `wvdl.sandbox.caso_estudio` → `SolicitudCompra`. Los errores y advertencias del razonador aparecen subrayados sobre cada nodo; pasa el mouse sobre ellos para ver el mensaje.
4. **Preview Generated Text** (o *Make*) sobre un modelo produce `<workflow>.json`.
5. Las pruebas se ejecutan con clic derecho sobre `wvdl.tests` → **Run tests**.

Notación del editor:

- **Secciones:** estados, roles, actores, variables, actividades y verificaciones.
- **Tablas** (`jetbrains.mps.lang.editor.table`): la matriz *actor × rol* y la tabla de transiciones (nombre | origen | destino | actividad | guarda).
- **Agregar elementos:** se escriben por su alias, con completado: `inicial`, `estado`, `final`, `rol humano`, `rol sistema`, `manual`, `automatica`, `==`, `<`, `and`, `or`, `not`, `entero`, `booleano`, `texto`, `verificar sound`…
- **Tabla de transiciones:** Enter inserta una fila nueva.

## Uso sin IDE (línea de comandos)

Requiere MPS 2026.2 instalado en `C:/Program Files/JetBrains/MPS 2026.2`; si está en otro lugar, define `MPS_HOME`. También requiere Node.js.

```powershell
node tools/build-reasoner.js    # compila el razonador, corre sus 29 pruebas y crea el JAR
node tools/mps-generate.js      # make headless: lenguaje + sandbox + tests; copia los JSON a reportes/
node tools/mps-test.js          # ejecuta las 27 pruebas lang.test
```

> **Importante:** los modelos `.mps` se crearon con `node tools/mpsgen/build.js`, a partir de la descripción en `tools/mpsgen/wvdl/*.js`. **Ese script sobrescribe los modelos.** Cuando el equipo empiece a editar el lenguaje en el IDE de MPS, no lo vuelvan a ejecutar; o bien hagan los cambios en los `.js`, pero no en los dos lados.

## Correspondencia con la Teoría de la Computación

| Aspecto MPS | Implementación | Fundamento |
| --- | --- | --- |
| Structure | 44 conceptos (42 conceptos, de ellos 7 abstractos, y 2 interfaces): herencia (`InitialState`/`FinalState`, `HumanRole`/`SystemRole`, `ManualActivity`/`AutomatedActivity`, operadores…), interfaces `IWorkflowElement` e `IBinaryOperation`, composición y referencias | AST, gramática regular de árboles |
| Editor | Proyecciones por secciones, tabla de transiciones y matriz actor × rol | Sintaxis concreta; la edición proyectiva no necesita parser, así que no hay ambigüedad |
| Scoping (`Workflow` es `ScopeProvider`) | Toda referencia solo ve elementos del mismo workflow; si apunta a otro → `WF-OUT-OF-SCOPE` | Restricciones sensibles al contexto (declarar antes de usar) |
| Typesystem (*checking rules*) | Integridad I1–I3, T-ROLE, T-GUARD, T-EQ, T-LT, T-AND/OR, T-NOT, T-INIT | Sistemas de tipos y reglas de inferencia |
| Razonador | Reach = μX.{s₀}∪post(X) (BFS); CoReach = μX.F∪pre(X) (BFS inversa); *deadlock*; *livelock* (Tarjan); L(M)=∅; satisfacibilidad de guardas; inferencia de actores | Autómatas, puntos fijos (Knaster–Tarski), decidibilidad sobre S finito |
| Simulador | (s,σ) → (s′,σ) si σ ⊨ guarda; determinista, con límite de pasos | Semántica operacional |
| TextGen | `Workflow` → `<nombre>.json`: hallazgos, propiedades, inferencias, verificaciones y traza | Semántica como traducción a un artefacto |

**Complejidad:** O(|S| + |T|) para el análisis de grafos. Las guardas no tienen aritmética: su satisfacibilidad se decide evaluándolas sobre representantes finitos, en O(k^v · |g|), donde *v* son las variables y *k* las constantes de la guarda.

**Por qué es decidible:** S es finito y las guardas solo comparan variables con constantes. Con expresiones Turing-completas, el problema «¿esta transición puede habilitarse?» sería indecidible (teorema de Rice).

## Catálogo de casos (sandbox y pruebas)

| Caso | Modelo | Resultado esperado y verificado |
| --- | --- | --- |
| V01–V03 | `validos` | VALID, sin errores; sus verificaciones (sound, ruta, actores, simulación) pasan |
| IS1 | `invalidos_estaticos` | `WF-OUT-OF-SCOPE`: la transición apunta a un estado de otro workflow |
| IS2 | `invalidos_estaticos` | `T-GUARD`: guarda de tipo Integer |
| IS3 | `invalidos_estaticos` | `T-ROLE` (actividad automática con rol humano) + `WF-MULTIPLE-INITIAL` |
| IR1 | `invalidos_razonador` | `WF-UNREACHABLE` |
| IR2 | `invalidos_razonador` | `WF-DEADLOCK` |
| IR3 | `invalidos_razonador` | `WF-LIVELOCK` sobre {Revision, Correccion} |
| IR4 | `invalidos_razonador` | `WF-DEAD-GUARD` (x < 1 ∧ x == 5) + `WF-UNASSIGNED-ROLE` |
| SolicitudCompra | `caso_estudio` | WARNING (Archivada inalcanzable); 5/5 verificaciones PASS |
| CE | `contraejemplo` | 5 verificaciones falsas, cada una refutada (`WF-CHECK-FAILED`) |

## Limitaciones conocidas

- El análisis es estructural: ve una transición como posible si su guarda es satisfacible para *alguna* valuación, sin seguir la evolución de los datos (las variables no cambian durante el flujo).
- No hay concurrencia ni tiempo: un workflow es un sistema de transición secuencial.
- La lógica del razonador está en Java (`reasoner/src`) y MPS la invoca desde typesystem, behavior, editor y textGen. Así los algoritmos quedan aislados y se prueban por separado.
