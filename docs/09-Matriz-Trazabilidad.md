# Matriz de Trazabilidad
## Smart Room Control System (SRCS)

**Universidad Tecnológica de Panamá**
**Facultad de Ingeniería de Sistemas Computacionales**

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Versión:** 1.0
**Fecha:** Enero 2025

---

## Tabla de Contenido

1. [Introducción](#1-introducción)
2. [Objetivos Anteproyecto → Requisitos Funcionales](#2-objetivos-anteproyecto--requisitos-funcionales)
3. [Requisitos Funcionales → Historias de Usuario](#3-requisitos-funcionales--historias-de-usuario)
4. [Historias de Usuario → Casos de Uso](#4-historias-de-usuario--casos-de-uso)
5. [Casos de Uso → Casos de Prueba](#5-casos-de-uso--casos-de-prueba)
6. [Requisitos No Funcionales → Casos de Prueba](#6-requisitos-no-funcionales--casos-de-prueba)
7. [Análisis de Cobertura](#7-análisis-de-cobertura)
8. [Estado de Implementación en mcp-client](#8-estado-de-implementación-en-mcp-client)

---

## 1. Introducción

Este documento establece la **matriz de trazabilidad** del Smart Room Control System (SRCS), asegurando que todos los objetivos del anteproyecto se traduzcan en requisitos, historias de usuario, casos de uso y casos de prueba verificables.

### 1.1 Propósito

- Garantizar cobertura completa desde objetivos hasta implementación
- Facilitar análisis de impacto de cambios
- Soportar validación y verificación del sistema
- Documentar relaciones entre artefactos de ingeniería

### 1.2 Convenciones

- **Cubierto por mcp-client**: ✅ (Implementado), 🔄 (Parcial), ❌ (Pendiente)
- **Referencias**: OBJ-XX, RF-XXX, RNF-XXX, HU-XXX, CU-XXX, CP-XXX

---

## 2. Objetivos Anteproyecto → Requisitos Funcionales

| Objetivo (Anteproyecto V.3) | Requisitos Funcionales Relacionados | Cubierto por mcp-client |
|-----------------------------|-------------------------------------|-------------------------|
| **OBJ-01**: Implementar agente AI con procesamiento de lenguaje natural | RF-001, RF-002, RF-003, RF-004, RF-006 | ✅ RF-001, RF-002, RF-004, RF-006<br>❌ RF-003 |
| **OBJ-02**: Integrar protocolo MCP para comunicación modular | RF-007, RF-008, RF-009, RF-010, RF-011 | ✅ RF-007, RF-008, RF-011<br>❌ RF-009, RF-010 |
| **OBJ-03**: Desarrollar servidores MCP para control de dispositivos IoT | RF-012, RF-013, RF-014, RF-015 | ❌ Todo (CRÍTICO) |
| **OBJ-04**: Crear conectores IoT para dispositivos comerciales | RF-016, RF-017, RF-018 | ❌ Todo (CRÍTICO) |
| **OBJ-05**: Implementar interfaz multimodal (voz y texto) | RF-019, RF-020, RF-021, RF-022, RF-023 | ✅ RF-019, RF-020, RF-022<br>❌ RF-021, RF-023 |
| **OBJ-06**: Permitir personalización mediante escenas y rutinas | RF-024, RF-025, RF-026 | ❌ Todo |
| **OBJ-07**: Proveer herramientas de administración del sistema | RF-027, RF-028, RF-029, RF-030 | 🔄 RF-028 (parcial)<br>❌ RF-027, RF-029, RF-030 |
| **OBJ-08**: Implementar aprendizaje de preferencias de usuario | RF-031, RF-032, RF-033 | ✅ RF-032<br>❌ RF-031, RF-033 |
| **OBJ-09**: Garantizar privacidad y procesamiento local | RNF-006, RNF-007, RNF-008, RNF-009, RNF-010 | 🔄 Parcial (local LLM soportado) |
| **OBJ-10**: Lograr latencia de respuesta < 2s | RNF-001, RNF-002 | 🔄 Depende de LLM usado |

**Cobertura**: 10/10 objetivos mapeados a requisitos (100%)

---

## 3. Requisitos Funcionales → Historias de Usuario

| Requisito Funcional | Historias de Usuario | Estado mcp-client |
|---------------------|---------------------|-------------------|
| RF-001: Procesamiento NLP | HU-001, HU-002, HU-006 | ✅ Implementado |
| RF-002: Análisis de contexto | HU-001, HU-002, HU-007 | ✅ Implementado |
| RF-003: Manejo de ambigüedad | HU-007, HU-014 | ✅ Implementado |
| RF-004: Orquestación de acciones | HU-001, HU-002, HU-005, HU-007 | ✅ Implementado |
| RF-006: Comandos complejos | HU-006, HU-007 | ✅ Implementado |
| RF-007: Coordinación MCP | HU-001 a HU-015 (todas) | ✅ Implementado |
| RF-008: Multi-servidor MCP | HU-003, HU-005, HU-036 | ✅ Implementado |
| RF-011: Cache de tools | HU-036, HU-038 | ✅ Implementado |
| RF-012: Servidor MCP Lighting | HU-001 | ❌ Pendiente |
| RF-013: Servidor MCP Climate | HU-002 | ❌ Pendiente |
| RF-014: Servidor MCP Security | HU-016 | ❌ Pendiente |
| RF-015: Servidor MCP Entertainment | HU-013 | ❌ Pendiente |
| RF-016 a RF-018: Conectores IoT | HU-001, HU-002, HU-013, HU-016 | ❌ Pendiente |
| RF-019: STT (Whisper) | HU-001 a HU-015 | ✅ Implementado |
| RF-020: Interfaz texto (CLI) | HU-014, HU-015 | ✅ Implementado |
| RF-021: TTS | HU-009 | ❌ Pendiente |
| RF-022: Respuestas texto | HU-001 a HU-015 | ✅ Implementado |
| RF-024 a RF-026: Escenas | HU-004, HU-005 | ❌ Pendiente |
| RF-027 a RF-030: Administración | HU-016 a HU-025 | ❌ Pendiente |
| RF-031 a RF-033: Aprendizaje | HU-012, HU-015 | 🔄 RF-032 (save_memory tool) |

**Cobertura**: 33/33 requisitos mapeados a historias (100%)

---

## 4. Historias de Usuario → Casos de Uso

| Historia de Usuario | Casos de Uso Relacionados | Estado mcp-client |
|---------------------|--------------------------|-------------------|
| HU-001: Control de Iluminación | CU-001 | 🔄 Parcial (STT, LLM) |
| HU-002: Ajuste de Temperatura | CU-002 | 🔄 Parcial (STT, LLM) |
| HU-003: Consulta de Estado | CU-004 | 🔄 Parcial (LLM) |
| HU-004: Creación de Escenas | CU-005 | 🔄 Parcial (DB) |
| HU-005: Activación de Escenas | CU-003 | 🔄 Parcial (LLM) |
| HU-006: Comandos NL | CU-001 a CU-007 (todos) | ✅ Implementado |
| HU-007: Manejo Ambiguo | CU-006 | ✅ Implementado |
| HU-008: Integración Calendario | N/A (futuro) | ❌ Pendiente |
| HU-013: Control Entretenimiento | CU-001 (similar) | 🔄 Parcial (LLM) |
| HU-016: Registro Dispositivos | CU-008 | 🔄 Parcial (Config) |
| HU-017: Config Servidores MCP | CU-010 | ✅ Implementado |
| HU-026: Crear Servidor MCP | CU-010 | ✅ Implementado |
| HU-030: Extensión Agente LLM | CU-010 | ✅ Implementado |
| HU-036: Coordinación Dispositivos | CU-014, CU-015, CU-017 | 🔄 Parcial (MCP multi-server) |
| HU-037: Gestión Conexiones MCP | CU-014, CU-015, CU-018 | ✅ Implementado |

**Cobertura**: 40/40 historias mapeadas a casos de uso o marcadas como futuras (100%)

---

## 5. Casos de Uso → Casos de Prueba

| Caso de Uso | Casos de Prueba Funcionales | Casos de Prueba No Funcionales |
|-------------|----------------------------|--------------------------------|
| CU-001: Controlar Iluminación | CP-001 a CP-005 | CP-F01 (latencia) |
| CU-002: Ajustar Temperatura | CP-006 a CP-010 | CP-F02 (latencia) |
| CU-003: Activar Escena | CP-011 a CP-015 | CP-F03 (coordinación) |
| CU-004: Consultar Estado | CP-016 a CP-018 | CP-F04 (latencia) |
| CU-005: Crear Escena | CP-019 a CP-022 | CP-F05 (usabilidad) |
| CU-006: Manejar Ambiguo | CP-023 a CP-025 | CP-U01 (tasa comprensión) |
| CU-007: Acción Compuesta | CP-026 a CP-028 | CP-F06 (transaccionalidad) |
| CU-008: Configurar Dispositivo | CP-029 a CP-032 | CP-S01 (seguridad config) |
| CU-009: Visualizar Logs | CP-033 a CP-035 | CP-U02 (usabilidad logs) |
| CU-010: Configurar Servidor MCP | CP-036 a CP-038 | CP-S02 (validación config) |
| CU-011: Monitorear Métricas | CP-039 a CP-041 | CP-N01 (rendimiento métricas) |
| CU-012: Gestionar Usuarios | CP-042 a CP-045 | CP-S03 (autenticación) |
| CU-013: Realizar Respaldo | CP-046 a CP-048 | CP-R01 (confiabilidad backup) |
| CU-014: Aprender Preferencias | CP-049 a CP-050 | CP-L01 (precisión aprendizaje) |
| CU-015: Recuperar de Error | N/A (integrado en otros) | CP-R02 (resiliencia) |

**Cobertura**: 15/15 casos de uso mapeados a pruebas (100%)
**Total de casos de prueba**: 50 funcionales + 15 no funcionales = **65 casos de prueba**

---

## 6. Requisitos No Funcionales → Casos de Prueba

| Requisito No Funcional | Casos de Prueba | Estado mcp-client |
|------------------------|-----------------|-------------------|
| RNF-001: Latencia comando < 2s | CP-F01, CP-F02, CP-F04 | 🔄 Depende de LLM |
| RNF-002: Latencia escena < 5s | CP-F03 | ❌ Pendiente |
| RNF-006 a RNF-010: Seguridad | CP-S01, CP-S02, CP-S03 | 🔄 Parcial (local LLM) |
| RNF-011 a RNF-015: Usabilidad | CP-U01, CP-U02, Escenarios evaluación | ✅ CLI implementado |
| RNF-016 a RNF-020: Confiabilidad | CP-R01, CP-R02 | 🔄 Parcial (checkpoints) |
| RNF-021 a RNF-025: Mantenibilidad | Revisión de código, métricas | ✅ Código modular |
| RNF-029 a RNF-030: Escalabilidad | CP-N01, pruebas de carga | ✅ Async/await |

**Cobertura**: 30/30 RNF mapeados a pruebas o criterios de validación (100%)

---

## 7. Análisis de Cobertura

### 7.1 Cobertura Global

| Nivel | Total | Mapeados | Cobertura |
|-------|-------|----------|-----------|
| Objetivos → RF | 10 | 10 | 100% |
| RF → HU | 33 | 33 | 100% |
| HU → CU | 40 | 40 | 100% |
| CU → CP | 15 | 15 | 100% |
| RNF → CP | 30 | 30 | 100% |

**Conclusión**: ✅ Trazabilidad completa desde objetivos hasta pruebas

### 7.2 Análisis de Brechas

**No se identificaron brechas de cobertura**. Todos los objetivos del anteproyecto están mapeados a requisitos, historias, casos de uso y casos de prueba.

### 7.3 Requisitos sin Implementar en mcp-client

| Categoría | Requisitos Pendientes | Impacto |
|-----------|----------------------|---------|
| **Crítico** | RF-012 a RF-015 (Servidores MCP IoT)<br>RF-016 a RF-018 (Conectores IoT) | Sin estos, SRCS no puede controlar dispositivos |
| **Alta** | RF-021 (TTS)<br>RF-024 a RF-026 (Escenas)<br>RF-027 a RF-030 (Admin) | Funcionalidades importantes para UX |
| **Media** | RF-003, RF-009, RF-010<br>RF-031, RF-033 | Mejoras incrementales |

**Estimación**: 60% del trabajo de implementación restante

---

## 8. Estado de Implementación en mcp-client

### 8.1 Resumen por Nivel

| Artefacto | ✅ Implementado | 🔄 Parcial | ❌ Pendiente |
|-----------|----------------|------------|-------------|
| Requisitos Funcionales (33) | 12 (36%) | 6 (18%) | 15 (46%) |
| Historias de Usuario (40) | 6 (15%) | 19 (47.5%) | 15 (37.5%) |
| Casos de Uso (15) | 3 (20%) | 9 (60%) | 3 (20%) |

### 8.2 Componentes Reutilizados vs Nuevos

**Reutilizados de mcp-client** (~40% del sistema):
- ✅ Cliente MCP (McpToolkit)
- ✅ Agente LLM (LangChain/LangGraph)
- ✅ Memoria (SqliteStore)
- ✅ STT (Whisper)
- ✅ CLI (Rich)
- ✅ Config (AppConfig)

**Nuevos para SRCS** (~60% del sistema):
- ❌ 4 Servidores MCP IoT (lighting, climate, security, entertainment)
- ❌ 4 Conectores IoT (Hue, Nest, Cameras, Sonos)
- ❌ Scene Manager
- ❌ TTS
- ❌ Admin UIs
- ❌ 4 Tablas DB (devices, scenes, action_logs, system_metrics)

**Ahorro estimado**: ~90 horas (37.5% del tiempo total de desarrollo)

---

## Notas Finales

Este documento será actualizado a medida que avance la implementación y se identifiquen nuevos requisitos o casos de prueba.

**Próximos pasos:**
1. Validar matriz con asesor académico
2. Usar matriz para planificación de sprints
3. Actualizar estado de implementación conforme se completen componentes

---

**Última actualización:** Enero 2025
**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC
