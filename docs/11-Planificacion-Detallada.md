# Planificación Detallada
## Smart Room Control System (SRCS)

**Universidad Tecnológica de Panamá**
**Facultad de Ingeniería de Sistemas Computacionales**

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Versión:** 1.0
**Fecha:** Enero 2025

---

## Tabla de Contenido

1. [Introducción](#1-introducción)
2. [Contexto y Base Tecnológica](#2-contexto-y-base-tecnológica)
3. [Cronograma General](#3-cronograma-general)
4. [Planificación por Sprints](#4-planificación-por-sprints)
5. [Asignación de Recursos](#5-asignación-de-recursos)
6. [Dependencias y Ruta Crítica](#6-dependencias-y-ruta-crítica)
7. [Gestión de Riesgos](#7-gestión-de-riesgos)
8. [Criterios de Aceptación y Hitos](#8-criterios-de-aceptación-y-hitos)

---

## 1. Introducción

### 1.1 Propósito

Este documento establece la planificación detallada para el desarrollo del Smart Room Control System (SRCS), definiendo la descomposición de tareas, asignación de recursos, cronograma y gestión de riesgos.

### 1.2 Alcance del Plan

El plan cubre el desarrollo completo del SRCS desde el fork de mcp-client hasta la entrega final, incluyendo:

- 7 sprints de desarrollo (Sprint 0 a Sprint 6)
- ~150 horas de trabajo estimadas
- 6 meses de duración total (Enero - Junio 2025)
- Documentación técnica completa
- Pruebas y validación con usuarios reales

### 1.3 Metodología

**Metodología Ágil - Scrum Adaptado:**
- Sprints de 2 semanas (excepto Sprint 0: 1 semana)
- Daily standups asincrónicos (por chat)
- Revisión semanal con asesor
- Retrospectivas al final de cada sprint
- Desarrollo iterativo e incremental

**Priorización MoSCoW:**
- **Must Have**: Funcionalidades críticas para MVP (Sprints 0-2)
- **Should Have**: Funcionalidades importantes (Sprints 3-4)
- **Could Have**: Funcionalidades opcionales (Sprint 5)
- **Won't Have**: Fuera del alcance inicial

---

## 2. Contexto y Base Tecnológica

### 2.1 Decisión Arquitectónica: Uso de mcp-client-cli

El proyecto se basa en un **fork de [mcp-client-cli](https://github.com/adhikasp/mcp-client-cli)**, lo que proporciona:

**Componentes Ya Implementados (~40% del sistema):**
- ✅ Cliente Coordinador MCP (McpToolkit)
- ✅ Agente LLM con LangChain/LangGraph
- ✅ Sistema de Memoria Persistente (SqliteStore)
- ✅ Interfaz STT con Whisper
- ✅ Interfaz CLI con Rich
- ✅ Sistema de Configuración (AppConfig)
- ✅ Cache de Herramientas MCP
- ✅ Historial de Conversaciones (AsyncSqliteSaver)

**Componentes Nuevos a Desarrollar (~60% del sistema):**
- ❌ 4 Servidores MCP IoT (lighting, climate, security, entertainment)
- ❌ 4 Conectores IoT (Philips Hue, Nest, Cameras, Sonos)
- ❌ Scene Manager (gestión de escenas)
- ❌ TTS (Text-to-Speech)
- ❌ Módulos de Administración
- ❌ Extensión de Base de Datos (4 tablas nuevas)

### 2.2 Impacto en Planificación

**Ahorro Estimado:**
- ~90 horas de desarrollo (37.5% del tiempo original)
- Reducción de riesgo técnico en componentes core
- Código base probado y documentado

**Nueva Estimación:**
- **Original (desde cero):** ~240 horas
- **Con mcp-client:** ~150 horas
- **Documentación adicional:** ~10 horas
- **TOTAL:** ~160 horas

---

## 3. Cronograma General

### 3.1 Línea de Tiempo del Proyecto

| Fase | Período | Duración | Horas Est. | % Avance |
|------|---------|----------|------------|----------|
| **Documentación** | Enero 2025 (Semanas 1-2) | 2 semanas | 10h | 85% completado |
| **Sprint 0** | Enero 2025 (Semana 3) | 1 semana | 6h | 0% |
| **Sprint 1** | Enero-Febrero (Semanas 4-5) | 2 semanas | 24h | 0% |
| **Sprint 2** | Febrero (Semanas 6-7) | 2 semanas | 24h | 0% |
| **Sprint 3** | Febrero-Marzo (Semanas 8-9) | 2 semanas | 20h | 0% |
| **Sprint 4** | Marzo (Semanas 10-11) | 2 semanas | 20h | 0% |
| **Sprint 5** | Marzo-Abril (Semanas 12-13) | 2 semanas | 28h | 0% |
| **Sprint 6** | Abril-Mayo (Semanas 14-17) | 4 semanas | 28h | 0% |
| **Entrega Final** | Junio 2025 | 2 semanas | - | - |

**Duración Total:** ~19 semanas (~4.5 meses de desarrollo + 1.5 meses buffer)

### 3.2 Distribución de Esfuerzo por Sprint

```
Sprint 0:   6h  [====]
Sprint 1:  24h  [================]
Sprint 2:  24h  [================]
Sprint 3:  20h  [==============]
Sprint 4:  20h  [==============]
Sprint 5:  28h  [==================]
Sprint 6:  28h  [==================]
Total:    150h
```

### 3.3 Hitos Principales

| Hito | Fecha Objetivo | Entregable |
|------|---------------|------------|
| **M0** | Semana 2 | Documentación completa aprobada |
| **M1** | Semana 3 | Fork de mcp-client configurado y funcional |
| **M2** | Semana 7 | Primer servidor MCP IoT funcionando |
| **M3** | Semana 11 | Sistema completo integrado (sin admin) |
| **M4** | Semana 13 | Funcionalidades avanzadas implementadas |
| **M5** | Semana 17 | Sistema probado y validado |
| **M6** | Semana 22 | Entrega final y defensa |

---

## 4. Planificación por Sprints

### Sprint 0: Fork y Setup de mcp-client (1 semana)

**Objetivo:** Configurar el entorno de desarrollo basado en mcp-client como fundación del SRCS.

**Duración:** 1 semana (Enero, Semana 3)
**Esfuerzo Estimado:** 6 horas

#### Tareas Detalladas

| ID | Tarea | Responsable | Horas | Prioridad |
|----|-------|-------------|-------|-----------|
| S0.1 | Fork de repositorio mcp-client-cli | Alejandro | 0.5h | Must |
| S0.2 | Clonar y renombrar a `smart-room-mcp` | Alejandro | 0.5h | Must |
| S0.3 | Actualizar pyproject.toml (nombre, autores, descripción) | Alejandro | 0.5h | Must |
| S0.4 | Actualizar README.md con contexto SRCS | Victor | 1h | Must |
| S0.5 | Análisis de código mcp-client (cli.py, tool.py, config.py, memory.py) | Ambos | 2h | Must |
| S0.6 | Configurar entorno Python 3.12+ | Victor | 0.5h | Must |
| S0.7 | Instalar dependencias y probar CLI básico | Victor | 0.5h | Must |
| S0.8 | Configurar Ollama y descargar Llama 3.1 | Alejandro | 0.5h | Must |

#### Entregables

- ✅ Repositorio `smart-room-mcp` funcional en GitHub
- ✅ Entorno de desarrollo configurado y probado
- ✅ Documentación de componentes heredados
- ✅ CLI básico de mcp-client funcionando

#### Criterios de Aceptación

- [ ] El fork está en GitHub con nombre `smart-room-mcp`
- [ ] pyproject.toml refleja autores y descripción del SRCS
- [ ] CLI básico responde a comandos simples
- [ ] Llama 3.1 está configurado en Ollama y accesible

---

### Sprint 1: Servidores MCP IoT - Parte 1 (2 semanas)

**Objetivo:** Implementar los primeros 2 servidores MCP (Lighting y Climate) y probar integración con agente.

**Duración:** 2 semanas (Enero-Febrero, Semanas 4-5)
**Esfuerzo Estimado:** 24 horas

#### Tareas Detalladas

| ID | Tarea | Responsable | Horas | Prioridad |
|----|-------|-------------|-------|-----------|
| S1.1 | Extender schema BD: tablas `devices` y `action_logs` | Alejandro | 2h | Must |
| S1.2 | Configurar Alembic para migrations | Alejandro | 2h | Must |
| S1.3 | Crear modelos SQLAlchemy (Device, ActionLog) | Alejandro | 2h | Must |
| S1.4 | Implementar `mcp-servers/lighting/server.py` | Victor | 5h | Must |
| S1.4.1 | Tool: `lighting_turn_on` | Victor | 1h | Must |
| S1.4.2 | Tool: `lighting_turn_off` | Victor | 0.5h | Must |
| S1.4.3 | Tool: `lighting_set_brightness` | Victor | 1h | Must |
| S1.4.4 | Tool: `lighting_set_color` | Victor | 1h | Must |
| S1.4.5 | Tool: `lighting_get_status` | Victor | 1.5h | Must |
| S1.5 | Implementar `mcp-servers/climate/server.py` | Alejandro | 5h | Must |
| S1.5.1 | Tool: `climate_set_temperature` | Alejandro | 1.5h | Must |
| S1.5.2 | Tool: `climate_set_mode` | Alejandro | 1h | Must |
| S1.5.3 | Tool: `climate_get_current_temperature` | Alejandro | 1h | Must |
| S1.5.4 | Tool: `climate_get_status` | Alejandro | 1.5h | Must |
| S1.6 | Configurar servidores en `~/.llm/config.json` | Ambos | 1h | Must |
| S1.7 | Pruebas de integración con McpToolkit | Ambos | 3h | Must |
| S1.8 | Tests unitarios (lighting + climate) | Ambos | 4h | Must |

#### Entregables

- ✅ 2 servidores MCP implementados y funcionando
- ✅ Base de datos extendida con migraciones
- ✅ Configuración de servidores en formato MCP
- ✅ Tests unitarios con >70% coverage

#### Criterios de Aceptación

- [ ] El agente LLM puede descubrir y usar tools de lighting y climate
- [ ] Las acciones se registran en `action_logs`
- [ ] Los dispositivos se persisten en tabla `devices`
- [ ] Todos los tests unitarios pasan
- [ ] Comando de voz "enciende la luz" funciona end-to-end

---

### Sprint 2: Servidores MCP IoT - Parte 2 + Conectores (2 semanas)

**Objetivo:** Completar servidores MCP (Security y Entertainment) e implementar conectores IoT reales.

**Duración:** 2 semanas (Febrero, Semanas 6-7)
**Esfuerzo Estimado:** 24 horas

#### Tareas Detalladas

| ID | Tarea | Responsable | Horas | Prioridad |
|----|-------|-------------|-------|-----------|
| S2.1 | Implementar `mcp-servers/security/server.py` | Victor | 5h | Must |
| S2.1.1 | Tool: `security_arm` | Victor | 1.5h | Must |
| S2.1.2 | Tool: `security_disarm` | Victor | 1h | Must |
| S2.1.3 | Tool: `security_get_status` | Victor | 1.5h | Must |
| S2.1.4 | Tool: `security_get_camera_feed` | Victor | 1h | Should |
| S2.2 | Implementar `mcp-servers/entertainment/server.py` | Alejandro | 5h | Must |
| S2.2.1 | Tool: `entertainment_play/pause` | Alejandro | 1.5h | Must |
| S2.2.2 | Tool: `entertainment_set_volume` | Alejandro | 1h | Must |
| S2.2.3 | Tool: `entertainment_select_source` | Alejandro | 1.5h | Should |
| S2.2.4 | Tool: `entertainment_get_status` | Alejandro | 1h | Must |
| S2.3 | Implementar `BaseConnector` (clase abstracta) | Victor | 2h | Must |
| S2.4 | Implementar `PhilipsHueConnector` | Victor | 4h | Must |
| S2.5 | Implementar `NestConnector` o `GenericThermostatConnector` | Alejandro | 4h | Should |
| S2.6 | Integrar conectores con servidores MCP | Ambos | 2h | Must |
| S2.7 | Tests unitarios (security + entertainment + connectors) | Ambos | 4h | Must |

#### Entregables

- ✅ 4 servidores MCP completos
- ✅ 2+ conectores IoT funcionando
- ✅ Sistema puede controlar dispositivos reales (mínimo Philips Hue)
- ✅ Tests de integración entre servidores y conectores

#### Criterios de Aceptación

- [ ] Los 4 servidores MCP están configurados y accesibles
- [ ] Al menos 1 dispositivo IoT real (ej: bombillo Philips Hue) puede ser controlado
- [ ] El sistema maneja errores de conectividad IoT gracefully
- [ ] Comando "pon seguridad en modo noche" ejecuta múltiples acciones coordinadas
- [ ] Tests de integración pasan

---

### Sprint 3: Gestión de Escenas + TTS - Parte 1 (2 semanas)

**Objetivo:** Implementar Scene Manager y comenzar integración de TTS.

**Duración:** 2 semanas (Febrero-Marzo, Semanas 8-9)
**Esfuerzo Estimado:** 20 horas

#### Tareas Detalladas

| ID | Tarea | Responsable | Horas | Prioridad |
|----|-------|-------------|-------|-----------|
| S3.1 | Extender schema BD: tabla `scenes` | Alejandro | 1h | Should |
| S3.2 | Crear modelo SQLAlchemy (Scene) | Alejandro | 1h | Should |
| S3.3 | Implementar `scene_manager.py` - CRUD básico | Victor | 4h | Should |
| S3.3.1 | `create_scene(name, actions)` | Victor | 1.5h | Should |
| S3.3.2 | `get_scene(name)` / `list_scenes()` | Victor | 1h | Should |
| S3.3.3 | `update_scene(name, actions)` | Victor | 1h | Should |
| S3.3.4 | `delete_scene(name)` | Victor | 0.5h | Should |
| S3.4 | Implementar ejecución coordinada de escenas | Victor | 3h | Should |
| S3.5 | Crear servidor MCP `scene-manager` | Victor | 2h | Should |
| S3.6 | Implementar `speech_output.py` - TTS con Piper | Alejandro | 5h | Could |
| S3.6.1 | Configurar Piper TTS | Alejandro | 1h | Could |
| S3.6.2 | Integrar con output.py de mcp-client | Alejandro | 2h | Could |
| S3.6.3 | Crear flag `--voice` para habilitar TTS | Alejandro | 1h | Could |
| S3.6.4 | Probar latencia de respuesta con TTS | Alejandro | 1h | Could |
| S3.7 | Tests unitarios (SceneManager + TTS) | Ambos | 4h | Should |

#### Entregables

- ✅ Scene Manager funcional con persistencia
- ✅ Servidor MCP `scene-manager` integrado
- 🔄 TTS básico implementado (opcional)
- ✅ Tests unitarios

#### Criterios de Aceptación

- [ ] Usuario puede crear escena "Modo Cine" con comandos de voz
- [ ] Escena ejecuta múltiples acciones en orden (apagar luces, cerrar cortinas, encender TV)
- [ ] Escenas se persisten en BD y sobreviven reinicio
- [ ] TTS puede leer respuestas simples (si implementado)
- [ ] Latencia de creación de escena < 3s

---

### Sprint 4: Gestión de Escenas + TTS - Parte 2 (2 semanas)

**Objetivo:** Completar funcionalidades avanzadas de Scene Manager y pulir TTS.

**Duración:** 2 semanas (Marzo, Semanas 10-11)
**Esfuerzo Estimado:** 20 horas

#### Tareas Detalladas

| ID | Tarea | Responsable | Horas | Prioridad |
|----|-------|-------------|-------|-----------|
| S4.1 | Implementar triggers para escenas (tiempo, eventos) | Victor | 4h | Could |
| S4.2 | Implementar condiciones para escenas | Victor | 3h | Could |
| S4.3 | Implementar rollback de escenas (undo) | Victor | 3h | Could |
| S4.4 | Optimizar TTS: caché de respuestas comunes | Alejandro | 2h | Could |
| S4.5 | Mejorar calidad de voz TTS (ajustes de prosody) | Alejandro | 2h | Could |
| S4.6 | Implementar modo mixto (TTS + texto) | Alejandro | 2h | Could |
| S4.7 | Crear herramienta MCP `scene_execute_with_params` | Victor | 2h | Should |
| S4.8 | Tests de integración (escenas + TTS) | Ambos | 2h | Should |

#### Entregables

- ✅ Scene Manager con triggers y condiciones
- ✅ TTS optimizado y pulido
- ✅ Documentación de usuario para escenas

#### Criterios de Aceptación

- [ ] Escena puede ejecutarse automáticamente a las 8 PM
- [ ] Escena "Buenos Días" puede tener condición (si temperatura < 18°C, subir calefacción)
- [ ] Usuario puede deshacer escena ejecutada
- [ ] TTS responde en < 1.5s para respuestas cacheadas
- [ ] Documentación explica cómo crear escenas complejas

---

### Sprint 5: Administración y Aprendizaje (2 semanas)

**Objetivo:** Implementar módulos de administración del sistema y aprendizaje de preferencias.

**Duración:** 2 semanas (Marzo-Abril, Semanas 12-13)
**Esfuerzo Estimado:** 28 horas

#### Tareas Detalladas

| ID | Tarea | Responsable | Horas | Prioridad |
|----|-------|-------------|-------|-----------|
| S5.1 | Extender schema BD: tablas `system_metrics` | Alejandro | 1h | Should |
| S5.2 | Implementar `device_registry.py` (RF-027) | Victor | 4h | Should |
| S5.2.1 | CRUD de dispositivos | Victor | 2h | Should |
| S5.2.2 | Auto-discovery de dispositivos IoT | Victor | 2h | Could |
| S5.3 | Implementar `metrics_collector.py` (RF-030) | Alejandro | 5h | Should |
| S5.3.1 | Métricas de latencia por comando | Alejandro | 2h | Should |
| S5.3.2 | Métricas de uso de dispositivos | Alejandro | 2h | Should |
| S5.3.3 | Generación de reportes básicos | Alejandro | 1h | Could |
| S5.4 | Implementar análisis de patrones (RF-031) | Victor | 4h | Could |
| S5.4.1 | Detectar rutinas frecuentes | Victor | 2h | Could |
| S5.4.2 | Sugerencias de escenas basadas en historial | Victor | 2h | Could |
| S5.5 | Mejorar `save_memory` tool para preferencias SRCS | Alejandro | 2h | Should |
| S5.6 | Implementar `user_preferences.py` | Alejandro | 3h | Should |
| S5.7 | Crear servidor MCP `admin-tools` | Victor | 3h | Should |
| S5.8 | CLI de administración (opcional) | Alejandro | 2h | Could |
| S5.9 | Tests unitarios (admin + learning) | Ambos | 4h | Should |

#### Entregables

- ✅ Device Registry con CRUD completo
- ✅ Metrics Collector recopilando datos
- 🔄 Sistema de aprendizaje básico (opcional)
- ✅ Servidor MCP de administración

#### Criterios de Aceptación

- [ ] Admin puede ver todos los dispositivos registrados
- [ ] Sistema registra latencia de cada comando ejecutado
- [ ] Sistema puede sugerir crear escena "Llegar a Casa" basado en patrones
- [ ] Preferencias del usuario se persisten y usan en contexto del agente
- [ ] Reporte de métricas disponible (JSON o texto)

---

### Sprint 6: Pruebas, Validación y Documentación Final (4 semanas)

**Objetivo:** Completar testing exhaustivo, validar con usuarios reales y finalizar documentación.

**Duración:** 4 semanas (Abril-Mayo, Semanas 14-17)
**Esfuerzo Estimado:** 28 horas

#### Tareas Detalladas

| ID | Tarea | Responsable | Horas | Prioridad |
|----|-------|-------------|-------|-----------|
| **Semana 1-2: Testing** | | | | |
| S6.1 | Completar tests unitarios (objetivo: >70% coverage) | Ambos | 6h | Must |
| S6.2 | Tests de integración end-to-end | Ambos | 4h | Must |
| S6.2.1 | Flujo: Comando voz → LLM → MCP → IoT → Respuesta | Ambos | 2h | Must |
| S6.2.2 | Flujo: Crear escena → Ejecutar escena → Verificar estado | Ambos | 2h | Must |
| S6.3 | Tests de rendimiento (latencia < 2s) | Alejandro | 3h | Must |
| S6.4 | Tests de seguridad (SQL injection, XSS en inputs) | Victor | 2h | Should |
| S6.5 | Tests de resiliencia (dispositivo offline, LLM falla) | Victor | 2h | Should |
| **Semana 3: Evaluación con Usuarios** | | | | |
| S6.6 | Reclutamiento de 5-10 usuarios de prueba | Ambos | 1h | Must |
| S6.7 | Preparar escenarios de evaluación (5 escenarios del doc 08) | Alejandro | 2h | Must |
| S6.8 | Sesiones de evaluación con usuarios | Ambos | 4h | Must |
| S6.9 | Recopilación de métricas cuantitativas (latencia, tasa éxito) | Victor | 1h | Must |
| S6.10 | Aplicar cuestionario SUS (System Usability Scale) | Alejandro | 1h | Must |
| S6.11 | Análisis de resultados y ajustes | Ambos | 2h | Must |
| **Semana 4: Documentación** | | | | |
| S6.12 | Completar `docs/12-Manual-Usuario.md` | Victor | 3h | Must |
| S6.13 | Crear video demo del sistema (5-10 min) | Alejandro | 2h | Must |
| S6.14 | Actualizar README.md con instalación y uso | Victor | 1h | Must |
| S6.15 | Revisar y actualizar toda la documentación | Ambos | 2h | Must |
| S6.16 | Preparar presentación de defensa | Ambos | 3h | Must |

#### Entregables

- ✅ Suite completa de tests (>70% coverage)
- ✅ Informe de evaluación con usuarios
- ✅ Manual de usuario completo
- ✅ Video demo del sistema
- ✅ Presentación de defensa

#### Criterios de Aceptación

- [ ] Coverage de tests > 70% en componentes críticos
- [ ] Latencia promedio de comando simple < 2s (medida con 20+ comandos)
- [ ] Al menos 5 usuarios completaron evaluación
- [ ] Puntaje SUS promedio > 68 (Above Average)
- [ ] Tasa de éxito de comandos > 85%
- [ ] Manual de usuario permite a un usuario nuevo instalar y usar el sistema
- [ ] Video demo muestra 5+ funcionalidades principales

---

## 5. Asignación de Recursos

### 5.1 Equipo de Desarrollo

| Rol | Responsable | Dedicación | Horas/Semana |
|-----|-------------|------------|--------------|
| **Desarrollador Backend** | Alejandro Mosquera | 50% | ~10h/semana |
| **Desarrollador Full-Stack** | Victor Rodríguez | 50% | ~10h/semana |
| **Asesor Técnico** | Ing. Aris Castillo, MSC | Consultoría | ~1h/semana |

### 5.2 Distribución de Tareas por Integrante

#### Alejandro Mosquera (75 horas)

**Áreas de Especialización:**
- Backend y base de datos
- Servidores MCP (Climate, Entertainment)
- TTS y procesamiento de audio
- Métricas y administración

**Asignación Detallada:**
| Sprint | Tareas Principales | Horas |
|--------|-------------------|-------|
| Sprint 0 | Fork, setup, análisis de mcp-client | 3h |
| Sprint 1 | Schema BD, migrations, servidor Climate | 11h |
| Sprint 2 | Servidor Entertainment, conectores | 13h |
| Sprint 3 | TTS con Piper, integración | 10h |
| Sprint 4 | Optimización TTS, modo mixto | 6h |
| Sprint 5 | Metrics Collector, preferencias | 12h |
| Sprint 6 | Tests rendimiento, evaluación usuarios, video demo | 13h |
| **TOTAL** | | **68h** |

#### Victor Rodríguez (75 horas)

**Áreas de Especialización:**
- Servidores MCP (Lighting, Security)
- Conectores IoT
- Scene Manager
- Testing y QA

**Asignación Detallada:**
| Sprint | Tareas Principales | Horas |
|--------|-------------------|-------|
| Sprint 0 | Setup entorno, documentación, análisis | 3h |
| Sprint 1 | Servidor Lighting, tests | 12h |
| Sprint 2 | Servidor Security, conectores IoT | 13h |
| Sprint 3 | Scene Manager (CRUD + ejecución) | 9h |
| Sprint 4 | Triggers, condiciones, rollback | 10h |
| Sprint 5 | Device Registry, aprendizaje | 11h |
| Sprint 6 | Tests integración, seguridad, manual usuario | 14h |
| **TOTAL** | | **72h** |

### 5.3 Responsabilidades Compartidas

**Ambos Integrantes:**
- Revisión de código (code reviews)
- Testing de integración
- Evaluación con usuarios
- Documentación final
- Preparación de defensa

---

## 6. Dependencias y Ruta Crítica

### 6.1 Diagrama de Dependencias

```
[Sprint 0: Fork Setup] (CRÍTICO)
         ↓
    ┌────┴────┐
    ↓         ↓
[S1: Servers 1-2] [S1: BD Extension] (CRÍTICO)
    ↓         ↓
    └────┬────┘
         ↓
[S2: Servers 3-4 + IoT Connectors] (CRÍTICO)
         ↓
    ┌────┴────┐
    ↓         ↓
[S3: Scenes] [S3: TTS] (IMPORTANTE)
    ↓         ↓
[S4: Advanced Scenes] [S4: TTS Optimization]
    ↓         ↓
    └────┬────┘
         ↓
    [S5: Admin + Learning]
         ↓
    [S6: Testing + Validation] (CRÍTICO)
```

### 6.2 Ruta Crítica (Critical Path)

La ruta crítica del proyecto es:

1. **Sprint 0** → 2. **Sprint 1** → 3. **Sprint 2** → 4. **Sprint 6**

**Justificación:**
- Sin Sprint 0, no hay base de código
- Sin Sprint 1, no hay servidores MCP ni BD
- Sin Sprint 2, no hay integración IoT real (requisito mínimo)
- Sprint 6 es obligatorio para entrega

**Sprints 3, 4, 5** son importantes pero no críticos para MVP:
- Escenas pueden ser implementadas manualmente vía config
- TTS es opcional (Could Have)
- Admin puede ser básico vía SQL directo

### 6.3 Dependencias Entre Tareas

| Tarea | Depende De | Tipo |
|-------|------------|------|
| S1.4 (Servidor Lighting) | S0.5 (Análisis mcp-client) | Dura |
| S1.6 (Config servidores) | S1.4, S1.5 (Servidores implementados) | Dura |
| S1.7 (Pruebas integración) | S1.6 | Dura |
| S2.6 (Integrar conectores) | S2.3, S2.4, S1.4, S1.5 | Dura |
| S3.4 (Ejecución escenas) | S2.6 (Servidores + conectores) | Dura |
| S5.4 (Análisis patrones) | S3.4 (Escenas ejecutándose) | Blanda |
| S6.2 (Tests E2E) | S2.6 (Sistema integrado) | Dura |
| S6.8 (Evaluación usuarios) | S6.2 (Tests pasando) | Dura |

**Dependencia Dura:** No se puede comenzar hasta que termine la tarea previa
**Dependencia Blanda:** Se puede comenzar, pero se completa mejor con la tarea previa

### 6.4 Holgura (Slack) por Sprint

| Sprint | Duración Planificada | Holgura | Total Disponible |
|--------|---------------------|---------|------------------|
| Sprint 0 | 1 semana | 0 días | 1 semana |
| Sprint 1 | 2 semanas | 2 días | 12 días |
| Sprint 2 | 2 semanas | 2 días | 12 días |
| Sprint 3 | 2 semanas | 3 días | 14 días |
| Sprint 4 | 2 semanas | 3 días | 14 días |
| Sprint 5 | 2 semanas | 3 días | 14 días |
| Sprint 6 | 4 semanas | 5 días | 23 días |

**Buffer Total:** ~18 días (~3.6 semanas) distribuidos a lo largo del proyecto

---

## 7. Gestión de Riesgos

### 7.1 Identificación de Riesgos

| ID | Riesgo | Probabilidad | Impacto | Severidad |
|----|--------|--------------|---------|-----------|
| R1 | Incompatibilidad de versiones de dependencias de mcp-client | Media | Alto | **ALTO** |
| R2 | Conectores IoT no funcionan con dispositivos reales | Alta | Alto | **CRÍTICO** |
| R3 | Latencia del LLM excede 2s consistentemente | Media | Medio | **MEDIO** |
| R4 | Dificultad para reclutar usuarios de prueba | Media | Medio | **MEDIO** |
| R5 | Retraso en entregas por carga académica | Alta | Medio | **MEDIO** |
| R6 | TTS consume demasiados recursos (CPU/RAM) | Media | Bajo | **BAJO** |
| R7 | Cambios en API de dispositivos IoT (Hue, Nest) | Baja | Alto | **MEDIO** |
| R8 | Pérdida de datos por error en migrations | Baja | Alto | **MEDIO** |

### 7.2 Estrategias de Mitigación

#### R1: Incompatibilidad de Dependencias

**Mitigación:**
- ✅ Usar `poetry` o `pipenv` para lock de versiones exactas
- ✅ Crear contenedor Docker con entorno reproducible
- ✅ Probar fork de mcp-client en Sprint 0 antes de continuar

**Contingencia:**
- Si incompatibilidad crítica: Re-implementar componentes afectados
- Tiempo buffer: 5-10 horas adicionales

#### R2: Conectores IoT No Funcionan

**Mitigación:**
- ✅ Adquirir dispositivos IoT ANTES de Sprint 2 (semana 5)
- ✅ Probar APIs de fabricantes con curl/Postman primero
- ✅ Implementar mocks para desarrollo sin hardware
- ✅ Tener plan B: usar simuladores IoT (Home Assistant)

**Contingencia:**
- Si Philips Hue falla: Cambiar a bombillos Tuya/Wyze
- Si todo falla: Demo con simuladores (reduce nota pero es aceptable)

#### R3: Latencia del LLM Excede 2s

**Mitigación:**
- ✅ Usar modelo Llama 3.1 (7B) en vez de 13B/70B
- ✅ Probar alternativas: Mistral, Phi-3
- ✅ Implementar caché de respuestas comunes
- ✅ Optimizar prompts para reducir tokens

**Contingencia:**
- Relaxar requisito a < 3s en casos complejos
- Documentar limitación en sección de RNF
- Usar Claude API en demo final (fast, pero requiere internet)

#### R4: Dificultad para Reclutar Usuarios

**Mitigación:**
- ✅ Comenzar reclutamiento en Semana 10 (no esperar a Sprint 6)
- ✅ Ofrecer incentivos (café, reconocimiento en tesis)
- ✅ Reclutar en clases de UTP, grupos de Facebook, familia

**Contingencia:**
- Mínimo aceptable: 5 usuarios (vs 10 ideal)
- Auto-evaluación exhaustiva si < 5 usuarios

#### R5: Retraso por Carga Académica

**Mitigación:**
- ✅ Planificar sprints considerando calendarios de exámenes
- ✅ Adelantar trabajo en semanas ligeras
- ✅ Comunicar delays al asesor proactivamente

**Contingencia:**
- Usar holgura de 18 días
- Reducir alcance de Sprints 3-4 (escenas avanzadas)
- Extender Sprint 6 si necesario (aún dentro de 6 meses)

#### R6: TTS Consume Muchos Recursos

**Mitigación:**
- ✅ Probar Piper (ligero) antes que Bark (pesado)
- ✅ Hacer TTS opcional (`--voice` flag)
- ✅ Usar servicios cloud (Google TTS) como alternativa

**Contingencia:**
- TTS marcado como "Could Have" - no crítico para aprobación
- Demo sin voz si recursos limitados

#### R7: Cambios en APIs de IoT

**Mitigación:**
- ✅ Usar librerías oficiales (phue, nest_thermostat) en vez de REST directo
- ✅ Monitorear changelogs de fabricantes

**Contingencia:**
- Actualizar conectores si cambio ocurre
- Documentar limitación temporal

#### R8: Pérdida de Datos en Migrations

**Mitigación:**
- ✅ Probar migrations en BD de prueba primero
- ✅ Backup de BD antes de cada migration
- ✅ Usar Alembic upgrade/downgrade

**Contingencia:**
- Restaurar desde backup
- Re-crear datos de prueba

### 7.3 Monitoreo de Riesgos

**Frecuencia:** Semanal en retrospectiva de sprint

**Responsable:** Ambos integrantes

**Métricas:**
- Velocidad de sprint (horas completadas vs planificadas)
- Cobertura de tests (target: >70%)
- Número de bugs críticos abiertos
- Latencia promedio de comandos

---

## 8. Criterios de Aceptación y Hitos

### 8.1 Definición de "Done" (DoD)

Una tarea se considera completa cuando:

- [ ] Código implementado y funciona según requisitos
- [ ] Tests unitarios escritos y pasando (>70% coverage)
- [ ] Code review completado por otro integrante
- [ ] Documentación actualizada (docstrings, README)
- [ ] Sin errores de linting (black, flake8, mypy)
- [ ] Integrado en rama `srcs-development` sin conflictos

### 8.2 Hitos y Entregables

#### M0: Documentación Completa (Semana 2)

**Entregables:**
- ✅ 10 documentos principales completados (01-SRS a 10-Glosario)
- ✅ ADR-001 de base tecnológica
- ✅ docs/09-Matriz-Trazabilidad.md
- ✅ docs/11-Planificacion-Detallada.md (este documento)
- ⏳ docs/12-Manual-Usuario.md

**Criterio de Aceptación:**
- Asesor aprueba documentación como base sólida para desarrollo

#### M1: Fork Funcional (Semana 3)

**Entregables:**
- ✅ Repositorio `smart-room-mcp` en GitHub
- ✅ CLI básico de mcp-client funcionando
- ✅ Documentación de componentes heredados

**Criterio de Aceptación:**
- CLI responde a comandos básicos
- Llama 3.1 en Ollama funciona

#### M2: Primer Servidor MCP Funcionando (Semana 7)

**Entregables:**
- ✅ Al menos 1 servidor MCP (Lighting) completamente funcional
- ✅ Integración con McpToolkit
- ✅ Tests unitarios pasando

**Criterio de Aceptación:**
- Usuario puede controlar luz con comando de voz
- Acción se registra en BD

#### M3: Sistema Integrado (Semana 11)

**Entregables:**
- ✅ 4 servidores MCP completos
- ✅ 2+ conectores IoT funcionando
- ✅ Control de dispositivos IoT reales
- ✅ Scene Manager básico

**Criterio de Aceptación:**
- Sistema controla 3+ dispositivos IoT reales
- Usuario puede crear y ejecutar escenas
- Latencia < 3s en comandos simples

#### M4: Funcionalidades Avanzadas (Semana 13)

**Entregables:**
- ✅ Scene Manager con triggers y condiciones
- 🔄 TTS funcional (opcional)
- ✅ Device Registry
- ✅ Metrics Collector

**Criterio de Aceptación:**
- Escenas se ejecutan automáticamente
- Métricas se recopilan y almacenan
- TTS responde en < 2s (si implementado)

#### M5: Sistema Validado (Semana 17)

**Entregables:**
- ✅ Suite de tests completa (>70% coverage)
- ✅ Evaluación con 5+ usuarios completada
- ✅ Informe de evaluación con métricas SUS
- ✅ Manual de usuario terminado

**Criterio de Aceptación:**
- SUS promedio > 68
- Tasa de éxito de comandos > 85%
- Latencia promedio < 2s
- Manual permite instalación autónoma

#### M6: Entrega Final (Semana 22)

**Entregables:**
- ✅ Código fuente completo en GitHub
- ✅ Documentación completa (13 documentos)
- ✅ Video demo (5-10 min)
- ✅ Presentación de defensa
- ✅ Informe final de tesis

**Criterio de Aceptación:**
- Sistema cumple con todos los requisitos "Must Have"
- Documentación aprobada por asesor
- Presentación preparada y ensayada

---

## 9. Métricas de Seguimiento

### 9.1 Métricas de Proceso

| Métrica | Objetivo | Frecuencia | Responsable |
|---------|----------|------------|-------------|
| Velocidad de Sprint (horas) | 20-28h/sprint | Semanal | Ambos |
| Burndown de tareas | Tendencia descendente | Diaria | Ambos |
| Bugs críticos abiertos | < 3 | Semanal | Ambos |
| Cobertura de tests | >70% | Por sprint | Ambos |
| Revisión de código (días) | < 2 días | Por PR | Ambos |

### 9.2 Métricas de Producto

| Métrica | Objetivo | Frecuencia | Herramienta |
|---------|----------|------------|-------------|
| Latencia comando simple | < 2s | Por sprint | Custom timer |
| Latencia escena | < 5s | Por sprint | Custom timer |
| Tasa de éxito de comandos | >85% | Por sprint | Logs de action_logs |
| Uptime de servidores MCP | >95% | Continua | Health checks |
| Uso de memoria (MB) | < 500MB | Por sprint | psutil |

### 9.3 Métricas de Calidad

| Métrica | Objetivo | Frecuencia | Herramienta |
|---------|----------|------------|-------------|
| Complejidad ciclomática | < 10 | Por commit | radon |
| Duplicación de código | < 3% | Semanal | pylint |
| Type hints coverage | >80% | Por sprint | mypy |
| Docstring coverage | >90% | Por sprint | interrogate |
| SUS Score | >68 | Sprint 6 | Cuestionario |

---

## 10. Comunicación y Colaboración

### 10.1 Canales de Comunicación

| Canal | Propósito | Frecuencia |
|-------|-----------|------------|
| WhatsApp/Telegram | Coordinación diaria | Diaria |
| Google Meet | Revisión semanal | Semanal |
| Email | Comunicación con asesor | Semanal |
| GitHub Issues | Tracking de bugs y features | Continua |
| GitHub PRs | Code review | Por feature |

### 10.2 Ceremonias Ágiles

**Daily Standup (Asincrónico):**
- Cada integrante reporta en chat:
  - ¿Qué hice ayer?
  - ¿Qué haré hoy?
  - ¿Tengo bloqueos?

**Sprint Review (Semanal):**
- Demostración de funcionalidades completadas
- Feedback del asesor
- Ajuste de plan si necesario

**Sprint Retrospective (Bi-semanal):**
- ¿Qué salió bien?
- ¿Qué salió mal?
- ¿Qué mejoraremos?

---

## 11. Herramientas y Tecnologías

### 11.1 Stack Tecnológico

**Heredado de mcp-client:**
- Python 3.12+
- LangChain + LangGraph
- SQLite + Alembic
- Rich (CLI)
- Whisper (STT)
- Ollama + Llama 3.1

**Nuevas Tecnologías:**
- Piper (TTS)
- phue (Philips Hue SDK)
- nest_thermostat (Nest SDK)
- pytest + pytest-asyncio (testing)
- black + flake8 + mypy (linting)

### 11.2 Herramientas de Desarrollo

- **IDE:** VS Code / PyCharm
- **Control de Versiones:** Git + GitHub
- **CI/CD:** GitHub Actions (opcional)
- **Gestión de Proyecto:** GitHub Projects / Notion
- **Documentación:** Markdown + PlantUML + Mermaid

---

## 12. Conclusiones

### 12.1 Resumen del Plan

Este plan de desarrollo detalla la implementación del SRCS en **7 sprints** (150 horas) aprovechando **mcp-client como base** (ahorro de 90 horas).

**Puntos Clave:**
- ✅ Fork de mcp-client reduce tiempo de desarrollo en 37.5%
- ✅ Ruta crítica: Sprint 0 → 1 → 2 → 6 (mínimo viable)
- ✅ Sprints 3-5 agregan funcionalidades avanzadas (Should/Could Have)
- ✅ 18 días de holgura distribuidos para manejar riesgos
- ✅ Evaluación con usuarios en Sprint 6 (requisito académico)

### 12.2 Próximos Pasos Inmediatos

1. **Semana 2 (actual):** Completar documentación restante (docs/12-Manual-Usuario.md)
2. **Semana 3:** Ejecutar Sprint 0 (fork y setup)
3. **Semana 4:** Iniciar Sprint 1 (primeros servidores MCP)

### 12.3 Compromiso del Equipo

Nos comprometemos a:
- 📅 Seguir el cronograma establecido con flexibilidad razonable
- 🧪 Mantener alta calidad de código (>70% test coverage)
- 📝 Documentar exhaustivamente el desarrollo
- 🔄 Comunicar proactivamente con el asesor
- 🎯 Entregar un sistema funcional y validado

---

## Apéndices

### Apéndice A: Glosario de Términos del Plan

- **Sprint:** Iteración de desarrollo de duración fija (1-4 semanas)
- **DoD (Definition of Done):** Criterios que debe cumplir una tarea para considerarse completa
- **Ruta Crítica:** Secuencia de tareas que determina la duración mínima del proyecto
- **Holgura (Slack):** Tiempo extra disponible en una tarea sin retrasar el proyecto
- **Burndown:** Gráfico que muestra trabajo restante vs tiempo
- **MoSCoW:** Priorización Must/Should/Could/Won't Have

### Apéndice B: Referencias

- [Documentación de mcp-client-cli](https://github.com/adhikasp/mcp-client-cli)
- [Scrum Guide](https://scrumguides.org/)
- [Atlassian Agile Coach](https://www.atlassian.com/agile)
- docs/00-ADR-Base-Tecnologica.md
- docs/01-SRS-Especificacion-Requisitos.md
- docs/09-Matriz-Trazabilidad.md

---

**Última actualización:** Enero 2025
**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC
**Estado:** ✅ APROBADO PARA EJECUCIÓN
