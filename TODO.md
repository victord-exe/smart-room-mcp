# TODO - Smart Room Control System (SRCS)
## Sistema Integral de Control Inteligente para Smart Rooms mediante MCP

**Proyecto:** Trabajo de Graduación - UTP 2025
**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC

**Última actualización:** Enero 2025

---

## Estado del Proyecto

### Fase Actual: Ingeniería de Software - Documentación

**Progreso General:** 77% (10/13 documentos principales completados)

### 🎯 **DECISIÓN ARQUITECTÓNICA IMPORTANTE**

El proyecto utiliza **[mcp-client-cli](https://github.com/adhikasp/mcp-client-cli)** como **base tecnológica** (ver `docs/00-ADR-Base-Tecnologica.md`).

**Componentes Ya Implementados en mcp-client (~40% de requisitos):**
- ✅ Cliente Coordinador MCP (RF-007, RF-008, RF-011)
- ✅ Agente LLM con LangChain/LangGraph (RF-001, RF-002, RF-004, RF-006)
- ✅ Sistema de Memoria Persistente (RF-032)
- ✅ Interfaz STT con Whisper (RF-019)
- ✅ Interfaz CLI con Rich (RF-020, RF-022)
- ✅ Configuración de Servidores MCP (RF-028 parcial)
- ✅ Cache de Herramientas (RF-011)
- ✅ Historial de Conversaciones

**Componentes a Crear (~60% restante):**
- ❌ Servidores MCP IoT (RF-012 a RF-015) - CRÍTICO
- ❌ Conectores IoT (RF-016 a RF-018) - CRÍTICO
- ❌ TTS para voz (RF-021)
- ❌ Gestión de Escenas (RF-024 a RF-026)
- ❌ Administración Sistema (RF-027, RF-029, RF-030)
- ❌ Aprendizaje de Preferencias (RF-031, RF-033)

**Ahorro Estimado:** ~90 horas de desarrollo (37.5%)

---

## 📋 Checklist de Documentación

### ✅ Documentos Completados

- [x] **Estructura de Directorios** - Organización completa del proyecto
  - [x] `/docs/` - Documentación del proyecto
  - [x] `/docs/diagrams/` - Diagramas (arquitectura, casos-uso, secuencia, ER)
  - [x] `/src/` - Código fuente
  - [x] `/tests/` - Pruebas (unit, integration, system, acceptance)
  - [x] `/config/` - Archivos de configuración
  - [x] `/database/` - Scripts de base de datos

- [x] **docs/10-Glosario.md** ✅ COMPLETADO
  - [x] Términos generales (Smart Room, Computación Ubicua, etc.)
  - [x] Términos de IA (LLM, Agente AI, NLP, Inferencia Local, etc.)
  - [x] Términos de MCP (Servidor MCP, Cliente MCP, Tool, Resource, etc.)
  - [x] Términos de IoT (Dispositivos IoT, Conector, Actuador, Sensor, etc.)
  - [x] Términos de HCI (Interfaz de voz, STT, TTS, etc.)
  - [x] Términos de evaluación (Latencia, SUS, Métricas, etc.)
  - [x] 40+ acrónimos definidos
  - [x] Convenciones de nomenclatura
  - [x] Referencias bibliográficas

- [x] **docs/01-SRS-Especificacion-Requisitos.md** ✅ COMPLETADO
  - [x] 1. Introducción (propósito, alcance, definiciones, referencias)
  - [x] 2. Descripción General (perspectiva, funciones, usuarios, restricciones)
  - [x] 3. Requisitos Específicos:
    - [x] 3.1 Requisitos Funcionales (RF-001 a RF-033)
      - [x] RF-001 a RF-006: Agente AI Central (LLM)
      - [x] RF-007 a RF-011: Cliente Coordinador MCP
      - [x] RF-012 a RF-015: Servidores MCP Especializados
      - [x] RF-016 a RF-018: Conectores IoT
      - [x] RF-019 a RF-023: Interfaz de Usuario
      - [x] RF-024 a RF-026: Gestión de Escenas y Rutinas
      - [x] RF-027 a RF-030: Administración del Sistema
      - [x] RF-031 a RF-033: Aprendizaje y Personalización
    - [x] 3.2 Requisitos No Funcionales (RNF-001 a RNF-030)
      - [x] RNF-001 a RNF-005: Rendimiento
      - [x] RNF-006 a RNF-010: Seguridad y Privacidad
      - [x] RNF-011 a RNF-015: Usabilidad
      - [x] RNF-016 a RNF-020: Confiabilidad
      - [x] RNF-021 a RNF-025: Mantenibilidad
      - [x] RNF-026 a RNF-028: Portabilidad
      - [x] RNF-029 a RNF-030: Escalabilidad
    - [x] 3.3 Requisitos del Sistema (Hardware y Software)
  - [x] 4. Apéndices (mapeo, priorización MoSCoW, supuestos)

- [x] **docs/04-Arquitectura-Sistema.md** ✅ COMPLETADO
  - [x] 1. Introducción (objetivos, principios de diseño)
  - [x] 2. Diagrama de Contexto (C4 Level 1) - PlantUML
  - [x] 3. Diagrama de Contenedores (C4 Level 2) - PlantUML
  - [x] 4. Diagrama de Componentes (C4 Level 3) - PlantUML
  - [x] 5. Diagrama de Despliegue - PlantUML
  - [x] 6. Patrones Arquitectónicos (6 patrones documentados)
  - [x] 7. Decisiones Arquitectónicas (5 ADRs)
  - [x] 8. Flujo de Datos (2 flujos detallados)
  - [ ] 🔄 **PENDIENTE**: Actualizar para reflejar componentes de mcp-client

- [x] **docs/00-ADR-Base-Tecnologica.md** ✅ COMPLETADO
  - [x] ADR-001: Uso de mcp-client-cli como base del proyecto
  - [x] ADR-002: Stack tecnológico Python + LangChain
  - [x] ADR-003: SQLite como base de datos
  - [x] Mapeo de componentes mcp-client → SRCS
  - [x] Estrategia de implementación (Fases 0-6)
  - [x] Análisis de ahorro de tiempo (~90h)

- [x] **docs/02-Historias-Usuario.md** ✅ COMPLETADO
  - [x] HU-001 a HU-015: Como Usuario del Smart Room (15 historias)
  - [x] HU-016 a HU-025: Como Administrador (10 historias)
  - [x] HU-026 a HU-035: Como Desarrollador (10 historias)
  - [x] HU-036 a HU-040: Como Sistema (5 historias)
  - [x] Priorización MoSCoW y puntos de historia
  - [x] Criterios de aceptación para cada historia
  - [ ] 🔄 **PENDIENTE**: Agregar columna indicando estado en mcp-client

- [x] **docs/03-Casos-Uso.md** ✅ COMPLETADO
  - [x] Diagrama general de casos de uso (PlantUML)
  - [x] CU-001 a CU-015: Casos de uso detallados (15 casos)
  - [x] Formato completo: precondiciones, flujo principal, alternos, postcondiciones
  - [ ] 🔄 **PENDIENTE**: Marcar flujos parcialmente implementados por mcp-client

- [x] **docs/05-Modelo-Datos.md** ✅ COMPLETADO
  - [x] Diagrama Entidad-Relación (Mermaid)
  - [x] Esquema completo de base de datos SQLite (8 tablas)
  - [x] JSON Schemas de configuración
  - [x] Script SQL de creación (`database/schema.sql`)
  - [x] Estrategia de migrations con Alembic
  - [ ] 🔄 **PENDIENTE**: Documentar schema existente de mcp-client y extensiones

- [x] **docs/06-APIs-Interfaces.md** ✅ COMPLETADO
  - [x] API del Cliente Coordinador MCP
  - [x] Especificación de 4 Servidores MCP (Lighting, Climate, Security, Entertainment)
  - [x] Tools de cada servidor (20+ herramientas documentadas)
  - [x] Interfaces de Conectores IoT (Philips Hue, Nest, Cameras, Sonos)
  - [x] Interfaz de Voz (Whisper STT, Bark/Piper TTS)
  - [ ] 🔄 **PENDIENTE**: Documentar APIs existentes de mcp-client

- [x] **docs/07-Diagramas-Secuencia.md** ✅ COMPLETADO
  - [x] DS-001 a DS-010: 10 diagramas de secuencia (PlantUML)
  - [x] Flujos completos desde usuario hasta dispositivo
  - [x] Manejo de errores y casos alternativos
  - [x] Notas de timing y rendimiento

- [x] **docs/08-Plan-Pruebas.md** ✅ COMPLETADO
  - [x] Estrategia de pruebas (niveles, herramientas, criterios)
  - [x] 50 casos de prueba funcionales (CP-001 a CP-050)
  - [x] Casos de prueba no funcionales (rendimiento, seguridad, usabilidad)
  - [x] 5 escenarios de evaluación con usuarios
  - [x] Métricas cuantitativas y cualitativas (SUS, latencia, tasa de éxito)
  - [x] Plantillas y criterios de entrada/salida

---

### 📝 Documentos Pendientes

#### Alta Prioridad (Actualizaciones Necesarias)

- [ ] **Actualizar Documentación Existente** 🟡 EN PROGRESO
  - [ ] **docs/04-Arquitectura-Sistema.md**: Agregar sección sobre componentes de mcp-client
  - [ ] **docs/05-Modelo-Datos.md**: Documentar schema existente de mcp-client y extensiones necesarias
  - [ ] **docs/02-Historias-Usuario.md**: Agregar columna de estado indicando qué está en mcp-client
  - [ ] **docs/03-Casos-Uso.md**: Marcar flujos parcialmente implementados
  - [ ] **docs/06-APIs-Interfaces.md**: Documentar APIs ya existentes en mcp-client
  - [ ] **docs/01-SRS-Especificacion-Requisitos.md**: Ampliar sección 2.1.1 sobre mcp-client

#### Media Prioridad (Nuevos Documentos)

- [ ] **docs/09-Matriz-Trazabilidad.md** 🟡 PENDIENTE
  - [ ] Tabla: Objetivos Anteproyecto → Requisitos Funcionales
  - [ ] Tabla: Requisitos Funcionales → Historias de Usuario
  - [ ] Tabla: Historias de Usuario → Casos de Uso
  - [ ] Tabla: Casos de Uso → Casos de Prueba
  - [ ] Tabla: Requisitos No Funcionales → Casos de Prueba
  - [ ] Análisis de cobertura (todos los objetivos cubiertos)
  - [ ] Indicar qué está cubierto por mcp-client

- [ ] **docs/11-Planificacion-Detallada.md** 🟡 PENDIENTE
  - [ ] Descomposición de tareas ajustada para uso de mcp-client como base
  - [ ] Sprint 0 (NUEVO): Fork y setup de mcp-client (1 semana)
  - [ ] Sprint 1-2: Servidores MCP IoT y Conectores
  - [ ] Sprint 3-4: Gestión de Escenas y TTS
  - [ ] Sprint 5: Administración y Aprendizaje
  - [ ] Sprint 6: Pruebas, Validación y Documentación
  - [ ] Estimación ACTUALIZADA: ~150 horas (vs ~240h original)
  - [ ] Asignación de tareas a integrantes
  - [ ] Dependencias entre tareas
  - [ ] Hitos (milestones)

- [ ] **docs/12-Manual-Usuario.md** 🟡 PENDIENTE
  - [ ] 1. Introducción al SRCS
  - [ ] 2. Instalación desde fork de mcp-client
    - [ ] Clonar repositorio
    - [ ] Configurar Python environment
    - [ ] Instalar dependencias
    - [ ] Configurar Ollama y descargar Llama
  - [ ] 3. Configuración Inicial
    - [ ] Archivo ~/.llm/config.json
    - [ ] Configuración de servidores MCP IoT
    - [ ] Registro de dispositivos
  - [ ] 4. Uso Básico
    - [ ] Comandos de voz
    - [ ] Comandos de texto
    - [ ] Ejemplos de interacciones
  - [ ] 5. Gestión de Escenas
  - [ ] 6. Configuración Avanzada
  - [ ] 7. Solución de Problemas

#### Baja Prioridad (Opcional - Especificaciones Técnicas Detalladas)

- [ ] **docs/tech-specs/MCP-Lighting-Server-Spec.md**
- [ ] **docs/tech-specs/MCP-Climate-Server-Spec.md**
- [ ] **docs/tech-specs/MCP-Security-Server-Spec.md**
- [ ] **docs/tech-specs/MCP-Entertainment-Server-Spec.md**
- [ ] **docs/tech-specs/IoT-Connectors-Spec.md**
- [ ] **docs/tech-specs/Scene-Manager-Spec.md**

---

## 🛠️ Tareas de Implementación (Código)

**NOTA IMPORTANTE:** El proyecto se basa en un fork de **mcp-client-cli**. Muchos componentes core ya están implementados.

### Fase 0: Fork y Setup de mcp-client (NUEVO - 4-6 horas)

- [ ] **Fork del Proyecto Base**
  - [ ] Fork de https://github.com/adhikasp/mcp-client-cli
  - [ ] Clonar fork localmente
  - [ ] Renombrar proyecto a `smart-room-mcp`
  - [ ] Actualizar README.md con contexto SRCS
  - [ ] Actualizar pyproject.toml (nombre, autores, descripción)
  - [ ] Crear branch `srcs-development`

- [ ] **Análisis de Componentes Existentes**
  - [ ] Estudiar `cli.py` (agente principal y CLI)
  - [ ] Estudiar `tool.py` (McpToolkit - Cliente MCP)
  - [ ] Estudiar `config.py` (sistema de configuración)
  - [ ] Estudiar `memory.py` (SqliteStore)
  - [ ] Estudiar `storage.py` (cache de herramientas)
  - [ ] Estudiar `input.py` y `output.py` (UI)
  - [ ] Documentar en memoria qué se reutiliza y qué se crea

- [ ] **Setup del Entorno**
  - [ ] Crear virtual environment con Python 3.12+
  - [ ] Instalar dependencias existentes de mcp-client
  - [ ] Configurar Ollama y descargar Llama 3.1
  - [ ] Probar CLI básico de mcp-client
  - [ ] Configurar pre-commit hooks (black, flake8, mypy)

### Fase 1: Extensión de Base de Datos (8 horas)

- [ ] **Migrations con Alembic**
  - [ ] Inicializar Alembic en el proyecto
  - [ ] Crear migration que extiende schema de mcp-client:
    - [ ] Nueva tabla `devices` (dispositivos IoT)
    - [ ] Nueva tabla `scenes` (escenas y rutinas)
    - [ ] Nueva tabla `action_logs` (historial de acciones)
    - [ ] Nueva tabla `system_metrics` (métricas de rendimiento)
    - [ ] Extender tabla existente de memoria para preferencias Smart Room
  - [ ] Aplicar migrations y verificar schema
  - [ ] Crear fixtures de datos de prueba

- [ ] **SQLAlchemy Models**
  - [ ] Crear `src/models/device.py`
  - [ ] Crear `src/models/scene.py`
  - [ ] Crear `src/models/action_log.py`
  - [ ] Crear `src/models/metric.py`

### Fase 2: Servidores MCP IoT (40 horas) - CRÍTICO

**NOTA:** Estos son componentes NUEVOS que NO existen en mcp-client

- [ ] **Módulo: src/mcp-servers/lighting/**
  - [ ] Implementar `server.py` (RF-012) - 10h
  - [ ] Tool: `lighting_turn_on(device_id, brightness?, color?)`
  - [ ] Tool: `lighting_turn_off(device_id)`
  - [ ] Tool: `lighting_set_brightness(device_id, level)`
  - [ ] Tool: `lighting_set_color(device_id, color)`
  - [ ] Tool: `lighting_get_status(device_id?)`
  - [ ] Tests unitarios para cada tool

- [ ] **Módulo: src/mcp-servers/climate/**
  - [ ] Implementar `server.py` (RF-013) - 10h
  - [ ] Tool: `climate_set_temperature(zone, temperature)`
  - [ ] Tool: `climate_set_mode(zone, mode)`
  - [ ] Tool: `climate_get_current_temperature(zone?)`
  - [ ] Tool: `climate_get_humidity(zone?)`
  - [ ] Tool: `climate_get_status(zone?)`
  - [ ] Tests unitarios

- [ ] **Módulo: src/mcp-servers/security/**
  - [ ] Implementar `server.py` (RF-014) - 10h
  - [ ] Tool: `security_arm(mode)`
  - [ ] Tool: `security_disarm()`
  - [ ] Tool: `security_get_status()`
  - [ ] Tool: `security_get_camera_feed(camera_id)`
  - [ ] Tool: `security_get_motion_events(since?)`
  - [ ] Tests unitarios

- [ ] **Módulo: src/mcp-servers/entertainment/**
  - [ ] Implementar `server.py` (RF-015) - 10h
  - [ ] Tool: `entertainment_play(device_id)`
  - [ ] Tool: `entertainment_pause(device_id)`
  - [ ] Tool: `entertainment_set_volume(device_id, level)`
  - [ ] Tool: `entertainment_select_source(device_id, source)`
  - [ ] Tool: `entertainment_get_status(device_id?)`
  - [ ] Tests unitarios

### Fase 3: Conectores IoT (30 horas) - CRÍTICO

- [ ] **Módulo: src/mcp-servers/**
  - [ ] **lighting/**
    - [ ] Implementar `server.py` (RF-012)
    - [ ] Implementar tools: turn_on, turn_off, set_brightness, set_color, get_status
  - [ ] **climate/**
    - [ ] Implementar `server.py` (RF-013)
    - [ ] Implementar tools: set_temperature, set_mode, get_current_temp, get_status
  - [ ] **security/**
    - [ ] Implementar `server.py` (RF-014)
    - [ ] Implementar tools: arm, disarm, get_status, get_camera_feed
  - [ ] **entertainment/**
    - [ ] Implementar `server.py` (RF-015)
    - [ ] Implementar tools: play, pause, set_volume, select_source

- [ ] **Módulo: src/iot-connectors/**
  - [ ] Implementar `base_connector.py` (abstract base class)
  - [ ] Implementar `philips_hue_connector.py`
  - [ ] Implementar `nest_connector.py` o `ecobee_connector.py`
  - [ ] Implementar `generic_camera_connector.py` (ONVIF)
  - [ ] Implementar `sonos_connector.py` (opcional)
  - [ ] Implementar error handling común (RF-018)

- [ ] **Módulo: src/ui/**
  - [ ] Implementar `voice_interface.py` (STT con Whisper) (RF-019)
  - [ ] Implementar `text_interface.py` (CLI con Rich) (RF-020)
  - [ ] Implementar `speech_output.py` (TTS con Bark/Piper) (RF-021)
  - [ ] Implementar `text_output.py` (RF-022)
  - [ ] Implementar `web_admin.py` (FastAPI, opcional) (RF-023)

- [ ] **Módulo: src/shared/**
  - [ ] Implementar `models.py` (Pydantic models compartidos)
  - [ ] Implementar `database.py` (SQLAlchemy session management)
  - [ ] Implementar `logging_config.py` (RNF-025)
  - [ ] Implementar `utils.py` (funciones utilitarias)
  - [ ] Implementar `exceptions.py` (custom exceptions)

### Fase 3: Funcionalidades Avanzadas

- [ ] **Gestión de Escenas**
  - [ ] Implementar `scene_manager.py` (RF-024, RF-025, RF-026)
  - [ ] CRUD de escenas en base de datos
  - [ ] Ejecución coordinada de escenas

- [ ] **Administración**
  - [ ] Implementar `device_registry.py` (RF-027)
  - [ ] Implementar `server_manager.py` (RF-028)
  - [ ] Implementar `user_manager.py` (RF-029)
  - [ ] Implementar `metrics_collector.py` (RF-030)

- [ ] **Aprendizaje de Preferencias**
  - [ ] Implementar análisis de patrones (RF-031)
  - [ ] Implementar almacenamiento de preferencias (RF-032)
  - [ ] Implementar sugerencias proactivas (RF-033)

### Fase 4: Testing

- [ ] **Unit Tests**
  - [ ] Tests para llm-agent (>70% coverage)
  - [ ] Tests para mcp-coordinator (>70% coverage)
  - [ ] Tests para mcp-servers (>70% coverage)
  - [ ] Tests para iot-connectors (>70% coverage)
  - [ ] Tests para ui (>70% coverage)

- [ ] **Integration Tests**
  - [ ] Tests LLM Agent ↔ MCP Coordinator
  - [ ] Tests MCP Coordinator ↔ MCP Servers
  - [ ] Tests MCP Servers ↔ IoT Connectors
  - [ ] Tests end-to-end con mocks de dispositivos

- [ ] **System Tests**
  - [ ] Tests con dispositivos IoT reales (mínimo 3)
  - [ ] Tests de latencia y rendimiento (RNF-001, RNF-002)
  - [ ] Tests de seguridad (RNF-006 a RNF-010)
  - [ ] Tests de escalabilidad (RNF-029, RNF-030)

- [ ] **Acceptance Tests**
  - [ ] Escenarios de usuario según doc 08 (Plan de Pruebas)
  - [ ] Evaluación con usuarios reales (máximo 10)
  - [ ] Recopilación de métricas cualitativas (SUS)

### Fase 5: Optimización y Pulido

- [ ] **Optimizaciones de Rendimiento**
  - [ ] Profiling de código con cProfile
  - [ ] Optimización de queries de DB
  - [ ] Implementación de caché para respuestas comunes
  - [ ] Optimización de carga del LLM

- [ ] **Mejoras de UX**
  - [ ] Refinamiento de respuestas del LLM
  - [ ] Mejora de manejo de errores comprensibles
  - [ ] Implementación de feedback visual/auditivo

- [ ] **Documentación de Código**
  - [ ] Docstrings en todas las funciones públicas (>90%)
  - [ ] Type hints completos
  - [ ] README.md en cada módulo
  - [ ] Comentarios en código complejo

---

## 📊 Diagramas Pendientes

- [ ] **Diagrama de Casos de Uso** (doc 03)
- [ ] **Diagrama Entidad-Relación** (doc 05)
- [ ] **10 Diagramas de Secuencia** (doc 07)
- [ ] **Diagramas de arquitectura en PlantUML** (ya creados en doc 04, pero revisar si se generan correctamente)

---

## 📚 Referencias y Recursos

### Documentos Creados
- `docs/10-Glosario.md` - Términos y definiciones
- `docs/01-SRS-Especificacion-Requisitos.md` - Requisitos completos
- `docs/04-Arquitectura-Sistema.md` - Arquitectura C4 y decisiones

### Documentos del Anteproyecto
- `tesis/AlejandroMosquera_VictorRodríguez_Anteproyecto V.3.pdf` - Documento fuente

### Enlaces Útiles
- Model Context Protocol: https://modelcontextprotocol.io/
- LangChain Docs: https://python.langchain.com/
- LangGraph Docs: https://langchain-ai.github.io/langgraph/
- Ollama: https://ollama.ai/
- Llama Models: https://ai.meta.com/llama/

---

## 🎯 Próximos Pasos Inmediatos

### Para Continuar la Documentación:

1. **Alta Prioridad (hacer primero):**
   - [ ] Completar `docs/02-Historias-Usuario.md` (35-40 historias)
   - [ ] Completar `docs/03-Casos-Uso.md` (15-20 casos detallados)
   - [ ] Completar `docs/05-Modelo-Datos.md` (esquema DB + scripts SQL)

2. **Media Prioridad (hacer después):**
   - [ ] Completar `docs/06-APIs-Interfaces.md` (especificación OpenAPI)
   - [ ] Completar `docs/07-Diagramas-Secuencia.md` (10 diagramas)
   - [ ] Completar `docs/08-Plan-Pruebas.md` (estrategia + casos de prueba)

3. **Baja Prioridad (hacer al final):**
   - [ ] Completar `docs/09-Matriz-Trazabilidad.md`
   - [ ] Completar `docs/11-Planificacion-Detallada.md`
   - [ ] Completar `docs/12-Manual-Usuario.md`

### Para Iniciar Implementación:

1. Configurar entorno de desarrollo
2. Implementar estructura base de módulos
3. Crear base de datos con schema
4. Implementar LLM Agent básico
5. Implementar primer servidor MCP (Lighting)
6. Crear tests unitarios

---

## 📈 Métricas de Progreso

**Documentación:**
- **Completados: 10/13 (77%)** ✅
  - Base completa: 01-SRS, 02-HU, 03-CU, 04-Arq, 05-Datos, 06-APIs, 07-Secuencia, 08-Pruebas, 10-Glosario
  - ADR nuevo: 00-ADR-Base-Tecnologica ✅
- **Actualizaciones Pendientes:** 6 documentos (agregar secciones sobre mcp-client)
- **Nuevos Documentos Pendientes:** 3 (09-Matriz, 11-Plan, 12-Manual)
- **Opcionales:** 6 especificaciones técnicas detalladas

**Implementación (Ajustado con mcp-client):**
- **Fase 0: 0%** - Fork y setup de mcp-client (4-6h)
- **Fase 1: 0%** - Extensión de BD (8h)
- **Fase 2: 0%** - Servidores MCP IoT (40h) - CRÍTICO
- **Fase 3: 0%** - Conectores IoT (30h) - CRÍTICO
- **Fase 4: 0%** - Gestión de Escenas (15h)
- **Fase 5: 0%** - Features adicionales (25h)
- **Fase 6: 0%** - Testing e integración (28h)

**Estimación de Tiempo ACTUALIZADA (con mcp-client como base):**
- **Documentación:** ~8-12 horas (solo actualizaciones y nuevos docs)
- **Implementación:** ~150 horas (vs ~240h desde cero) ⚡ **AHORRO: 90h**
  - Fase 0: 6h
  - Fase 1: 8h
  - Fase 2: 40h
  - Fase 3: 30h
  - Fase 4: 15h
  - Fase 5: 25h
  - Fase 6: 28h
- **Testing:** ~30 horas (reducido por código ya probado de mcp-client)
- **TOTAL: ~188-192 horas** (dentro de cronograma de 6 meses)

**Componentes Reutilizados de mcp-client (~40% del sistema):**
- ✅ Cliente MCP (tool.py)
- ✅ Agente LLM (cli.py + LangGraph)
- ✅ Configuración (config.py)
- ✅ Memoria (memory.py)
- ✅ Cache (storage.py)
- ✅ UI - STT/CLI (input.py, output.py, whisperVoiceInterface.py)
- ✅ Historial (AsyncSqliteSaver)

---

## 💡 Notas Importantes

1. **Priorizar según MoSCoW** (ver Apéndice B en doc 01):
   - Must Have: RF-001, RF-002, RF-004, RF-006, RF-007, RF-008, RF-012, RF-016, RF-019, RF-020, RF-022, RF-027
   - Should Have: Resto de RF principales
   - Could Have: Funcionalidades opcionales (RF-017, RF-021, RF-026)

2. **Validar con asesor** antes de continuar con implementación

3. **Mantener documentación sincronizada** con código

4. **Iterar**: No esperar a documentación perfecta antes de implementar

5. **Testing desde el inicio**: TDD cuando sea posible

---

**Última actualización:** Enero 2025
**Responsables:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC
