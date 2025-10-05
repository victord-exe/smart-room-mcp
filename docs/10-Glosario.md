# Glosario de Términos
## Sistema Integral de Control Inteligente para Smart Rooms mediante MCP

**Universidad Tecnológica de Panamá**
**Facultad de Ingeniería de Sistemas Computacionales**
**Trabajo de Graduación - 2025**

**Autores:** Alejandro Mosquera, Victor Rodríguez
**Asesor:** Ing. Aris Castillo, MSC

---

## Índice

1. [Términos Generales](#términos-generales)
2. [Términos de Inteligencia Artificial](#términos-de-inteligencia-artificial)
3. [Términos de Arquitectura y Protocolos](#términos-de-arquitectura-y-protocolos)
4. [Términos de IoT y Dispositivos](#términos-de-iot-y-dispositivos)
5. [Términos de Evaluación y Métricas](#términos-de-evaluación-y-métricas)
6. [Acrónimos](#acrónimos)

---

## Términos Generales

### Smart Room
Espacio físico equipado con dispositivos conectados (IoT) y sistemas inteligentes que permiten la automatización y control adaptativo del ambiente (iluminación, climatización, seguridad, entretenimiento) basándose en las necesidades y preferencias de los usuarios.

### Computación Ubicua
Paradigma de computación en el cual los sistemas computacionales están integrados de forma transparente en el entorno cotidiano, permitiendo que la tecnología esté disponible en cualquier lugar y momento sin requerir atención explícita del usuario.

### Fragmentación Tecnológica
Problemática en sistemas Smart Room donde diferentes dispositivos operan con protocolos propietarios y aislados, dificultando la interoperabilidad y resultando en experiencias de usuario inconsistentes.

### Privacidad de Datos
Derecho del usuario a controlar cómo se recopilan, almacenan, procesan y comparten sus datos personales. En este proyecto, se garantiza mediante procesamiento local sin dependencia de servicios en la nube.

### Interoperabilidad
Capacidad de diferentes sistemas, dispositivos o aplicaciones para comunicarse, intercambiar datos y utilizar la información intercambiada de manera efectiva.

### Escalabilidad
Capacidad del sistema para adaptarse y mantener su rendimiento al aumentar la cantidad de dispositivos, usuarios o carga de trabajo.

### Modularidad
Principio de diseño donde el sistema se divide en componentes independientes que pueden desarrollarse, probarse y mantenerse de forma separada, facilitando la extensibilidad.

---

## Términos de Inteligencia Artificial

### LLM (Large Language Model)
Modelo de Lenguaje Grande. Modelo de inteligencia artificial entrenado con grandes cantidades de datos textuales para comprender y generar lenguaje natural. En este proyecto, actúa como el cerebro central del sistema.

### Llama
Familia de modelos de lenguaje grande desarrollados por Meta AI, diseñados para ejecución local y disponibles como código abierto. Utilizado como el LLM central del proyecto.

### Procesamiento de Lenguaje Natural (NLP)
Área de la inteligencia artificial enfocada en la interacción entre computadoras y lenguaje humano, permitiendo interpretar comandos de voz o texto de los usuarios.

### Agente AI (Agente de Inteligencia Artificial)
Programa autónomo que percibe su entorno, toma decisiones y ejecuta acciones para alcanzar objetivos específicos. En este proyecto, incluye el agente central (LLM) y agentes especializados (servidores MCP).

### Agente Orquestador
Agente AI central responsable de coordinar y dirigir las acciones de múltiples agentes especializados, tomando decisiones de alto nivel basadas en el contexto global del sistema.

### Inferencia Local
Ejecución de modelos de IA directamente en el hardware local (servidor UTP/MDU) sin necesidad de enviar datos a servicios externos en la nube.

### Contexto
Información relevante sobre el estado actual del sistema, preferencias del usuario, historial de interacciones y condiciones ambientales que el LLM utiliza para tomar decisiones contextuales.

### Prompt
Instrucción o comando en lenguaje natural proporcionado al LLM para solicitar una acción, consulta o generación de texto.

### Fine-tuning
Proceso de ajustar un modelo de IA preentrenado con datos específicos del dominio (en este caso, comandos de Smart Room) para mejorar su rendimiento en tareas particulares.

### Embeddings
Representaciones vectoriales de palabras o frases que capturan relaciones semánticas, utilizadas para búsquedas de similitud y comprensión contextual.

---

## Términos de Arquitectura y Protocolos

### MCP (Model Context Protocol)
Protocolo estandarizado desarrollado por Anthropic para la comunicación entre agentes de inteligencia artificial, permitiendo intercambio estructurado de contexto, herramientas y recursos.

### Servidor MCP
Componente que expone herramientas específicas (tools), recursos y prompts a través del protocolo MCP. En este proyecto, cada subsistema (iluminación, climatización, etc.) tiene su servidor MCP dedicado.

### Cliente MCP
Componente que se conecta a uno o más servidores MCP para descubrir y utilizar las herramientas disponibles. En este proyecto, el Cliente Coordinador MCP actúa como puente entre el LLM y los servidores.

### Tool (Herramienta MCP)
Función expuesta por un servidor MCP que puede ser invocada por el LLM para realizar acciones específicas (ej: `turn_on_lights`, `set_temperature`).

### Resource (Recurso MCP)
Datos o información que un servidor MCP pone a disposición del LLM (ej: estado actual de dispositivos, configuraciones, logs).

### Prompt Template (Plantilla de Prompt MCP)
Patrones predefinidos de instrucciones que facilitan interacciones comunes con el sistema.

### StdIO Transport
Método de comunicación entre cliente y servidor MCP utilizando entrada/salida estándar (stdin/stdout), permitiendo comunicación local eficiente.

### Cliente Coordinador MCP
Componente central del sistema que recibe decisiones del LLM, las traduce en llamadas a herramientas MCP apropiadas, y consolida respuestas de múltiples servidores MCP.

### JSON-RPC 2.0
Protocolo de llamada a procedimiento remoto basado en JSON utilizado por MCP para la comunicación entre cliente y servidores.

---

## Términos de IoT y Dispositivos

### IoT (Internet of Things / Internet de las Cosas)
Red de dispositivos físicos embebidos con sensores, software y conectividad que les permite intercambiar datos y ser controlados remotamente.

### Dispositivo IoT
Objeto físico conectado a la red capaz de recopilar datos mediante sensores y/o ejecutar acciones mediante actuadores (ej: bombillas inteligentes, termostatos).

### Conector IoT
Componente de software que traduce comandos del sistema MCP a las APIs específicas de cada dispositivo o plataforma IoT (ej: Conector Philips Hue, Conector Home Assistant).

### Actuador
Componente de un dispositivo IoT que convierte señales eléctricas en acciones físicas (ej: encender una luz, ajustar un motor).

### Sensor
Componente que detecta cambios en el entorno físico y convierte esas mediciones en señales eléctricas (ej: sensor de temperatura, sensor de movimiento).

### API REST
Interfaz de Programación de Aplicaciones basada en el protocolo HTTP que sigue principios REST, utilizada por muchos dispositivos IoT para control remoto.

### Home Assistant
Plataforma de automatización del hogar de código abierto que integra múltiples dispositivos IoT bajo una interfaz unificada.

### Protocolo Propietario
Protocolo de comunicación diseñado específicamente para productos de un fabricante, que dificulta la integración con dispositivos de otras marcas.

### MQTT
Protocolo de mensajería ligero utilizado frecuentemente en IoT para comunicación máquina-a-máquina.

### Zigbee / Z-Wave
Protocolos de comunicación inalámbrica diseñados específicamente para redes de dispositivos domésticos de bajo consumo energético.

---

## Términos de Interfaz de Usuario

### HCI (Human-Computer Interaction)
Interacción Humano-Computadora. Disciplina que estudia el diseño y uso de interfaces entre personas y sistemas computacionales.

### Interfaz de Voz
Modalidad de interacción que permite al usuario comunicarse con el sistema mediante comandos hablados en lenguaje natural.

### STT (Speech-to-Text)
Tecnología que convierte audio de voz humana en texto escrito. En este proyecto se utiliza Whisper de OpenAI.

### TTS (Text-to-Speech)
Tecnología que convierte texto escrito en audio de voz sintetizada. En este proyecto se considera Bark o Piper.

### Comando de Voz
Instrucción verbal proporcionada por el usuario al sistema (ej: "enciende las luces del salón").

### Comando Compuesto
Instrucción que requiere múltiples acciones coordinadas (ej: "activa modo cine" → atenuar luces + cerrar cortinas + encender TV).

### Escena / Rutina
Conjunto predefinido de estados de dispositivos que se activan simultáneamente mediante un solo comando (ej: "modo lectura", "modo descanso").

### Interfaz Natural
Diseño de interacción que permite al usuario comunicarse con el sistema de manera similar a como lo haría con otra persona, sin necesidad de aprender comandos técnicos.

### Feedback Háptico / Visual / Auditivo
Respuestas del sistema que confirman al usuario que su comando fue recibido y procesado.

---

## Términos de Evaluación y Métricas

### Latencia
Tiempo que transcurre desde que el usuario emite un comando hasta que el sistema comienza a procesarlo. Objetivo: < 500ms.

### Tiempo de Respuesta
Tiempo total desde que se emite un comando hasta que se completa la acción solicitada y se notifica al usuario.

### Throughput
Cantidad de comandos o solicitudes que el sistema puede procesar exitosamente por unidad de tiempo.

### Tasa de Éxito
Porcentaje de comandos que el sistema interpreta y ejecuta correctamente en el primer intento.

### SUS (System Usability Scale)
Cuestionario estandarizado de 10 preguntas utilizado para medir la percepción de usabilidad de un sistema por parte de los usuarios.

### Heurísticas de Nielsen
Conjunto de 10 principios generales de diseño de interfaces desarrollados por Jakob Nielsen para evaluación de usabilidad.

### Métrica Cuantitativa
Medida numérica objetiva del rendimiento del sistema (ej: latencia en milisegundos, porcentaje de éxito).

### Métrica Cualitativa
Evaluación subjetiva basada en la percepción y experiencia de los usuarios (ej: naturalidad de interacción, satisfacción).

### Caso de Prueba
Especificación detallada de condiciones iniciales, entrada, acciones y resultados esperados para validar una funcionalidad específica.

### Escenario de Uso
Descripción narrativa de cómo un usuario típico interactuaría con el sistema para lograr un objetivo específico.

---

## Términos del Proyecto

### UTP
Universidad Tecnológica de Panamá. Institución donde se implementará el Smart Room y se desarrollará el proyecto.

### MDU
Mälardalen University. Universidad de Suecia con la cual existe colaboración académica y que cuenta con infraestructura Smart Room operativa.

### MILA
Proyecto precedente (2024) que implementó un asistente de voz local con Home Assistant, demostrando la viabilidad del procesamiento offline.

### Programa Erasmus+
Programa de la Unión Europea que financia el proyecto de generación de capacidades en educación superior, incluyendo la instalación del Smart Room en la UTP.

### Prototipo Funcional
Implementación parcial del sistema con funcionalidades core operativas, diseñada para demostración de concepto y validación de la propuesta.

### Demostración de Concepto (PoC)
Implementación limitada destinada a verificar la viabilidad de una idea o enfoque técnico.

---

## Términos de Desarrollo

### Desarrollo Ágil
Metodología iterativa e incremental de desarrollo de software que enfatiza la adaptabilidad, colaboración y entregas frecuentes de valor.

### Sprint
Período de tiempo fijo (típicamente 1-4 semanas) durante el cual se completa un conjunto específico de trabajo.

### Historia de Usuario
Descripción corta y simple de una funcionalidad desde la perspectiva del usuario, siguiendo el formato: "Como [rol] quiero [funcionalidad] para [beneficio]".

### Criterios de Aceptación
Condiciones específicas que deben cumplirse para que una historia de usuario se considere completada exitosamente.

### Punto de Historia
Unidad abstracta utilizada para estimar el esfuerzo relativo requerido para implementar una historia de usuario.

### Requisito Funcional (RF)
Especificación de una función o característica que el sistema debe proporcionar.

### Requisito No Funcional (RNF)
Especificación de una restricción o cualidad que el sistema debe satisfacer (ej: rendimiento, seguridad, usabilidad).

### Caso de Uso
Descripción detallada de cómo un actor interactúa con el sistema para lograr un objetivo específico.

### Diagrama de Secuencia
Representación visual que muestra la interacción entre diferentes componentes del sistema a lo largo del tiempo.

### Matriz de Trazabilidad
Tabla que relaciona requisitos, historias de usuario, casos de uso y casos de prueba para asegurar cobertura completa.

---

## Términos de Persistencia

### SQLite
Sistema de gestión de bases de datos relacional embebido, utilizado para almacenamiento local de configuraciones, historial y preferencias.

### Checkpoint
Mecanismo de LangGraph para guardar el estado de conversaciones y permitir continuación de sesiones.

### Cache
Almacenamiento temporal de datos frecuentemente accedidos para mejorar el rendimiento del sistema.

### Configuración Persistente
Preferencias y ajustes del sistema que se mantienen entre reinicios.

---

## Acrónimos

| Acrónimo | Significado | Definición |
|----------|-------------|------------|
| AI | Artificial Intelligence | Inteligencia Artificial |
| API | Application Programming Interface | Interfaz de Programación de Aplicaciones |
| GPU | Graphics Processing Unit | Unidad de Procesamiento Gráfico |
| HCI | Human-Computer Interaction | Interacción Humano-Computadora |
| HTTP | Hypertext Transfer Protocol | Protocolo de Transferencia de Hipertexto |
| IoT | Internet of Things | Internet de las Cosas |
| JSON | JavaScript Object Notation | Notación de Objetos JavaScript |
| LLM | Large Language Model | Modelo de Lenguaje Grande |
| MCP | Model Context Protocol | Protocolo de Contexto de Modelo |
| MDU | Mälardalen University | Universidad Mälardalen |
| MQTT | Message Queuing Telemetry Transport | Transporte de Telemetría de Cola de Mensajes |
| NLP | Natural Language Processing | Procesamiento de Lenguaje Natural |
| NVMe | Non-Volatile Memory Express | Memoria No Volátil Express |
| PoC | Proof of Concept | Demostración de Concepto |
| RAM | Random Access Memory | Memoria de Acceso Aleatorio |
| REST | Representational State Transfer | Transferencia de Estado Representacional |
| RF | Requisito Funcional | Functional Requirement |
| RNF | Requisito No Funcional | Non-Functional Requirement |
| SRS | Software Requirements Specification | Especificación de Requisitos de Software |
| SSD | Solid State Drive | Unidad de Estado Sólido |
| STT | Speech-to-Text | Voz a Texto |
| SUS | System Usability Scale | Escala de Usabilidad del Sistema |
| TTS | Text-to-Speech | Texto a Voz |
| UI | User Interface | Interfaz de Usuario |
| UTP | Universidad Tecnológica de Panamá | Technological University of Panama |
| UX | User Experience | Experiencia de Usuario |
| VRAM | Video Random Access Memory | Memoria de Acceso Aleatorio de Video |

---

## Convenciones de Nomenclatura

### Identificadores de Documentación

- **RF-XXX**: Requisito Funcional (ej: RF-001, RF-002)
- **RNF-XXX**: Requisito No Funcional (ej: RNF-001, RNF-002)
- **HU-XXX**: Historia de Usuario (ej: HU-001, HU-002)
- **CU-XXX**: Caso de Uso (ej: CU-001, CU-002)
- **CP-XXX**: Caso de Prueba (ej: CP-001, CP-002)
- **DS-XXX**: Diagrama de Secuencia (ej: DS-001, DS-002)
- **ADR-XXX**: Decisión Arquitectónica (Architecture Decision Record)

### Identificadores de Código

- **Módulos Python**: `snake_case` (ej: `llm_agent.py`, `mcp_coordinator.py`)
- **Clases**: `PascalCase` (ej: `LLMAgent`, `MCPServer`)
- **Funciones y métodos**: `snake_case` (ej: `process_command()`, `send_to_device()`)
- **Constantes**: `UPPER_SNAKE_CASE` (ej: `MAX_RETRIES`, `DEFAULT_TIMEOUT`)
- **Variables**: `snake_case` (ej: `device_id`, `user_command`)

### Nomenclatura de Servidores MCP

- `mcp-server-lighting`: Servidor MCP para control de iluminación
- `mcp-server-climate`: Servidor MCP para climatización
- `mcp-server-security`: Servidor MCP para seguridad
- `mcp-server-entertainment`: Servidor MCP para entretenimiento

### Nomenclatura de Herramientas MCP

- Formato: `{subsistema}_{acción}`
- Ejemplos:
  - `lighting_turn_on`
  - `lighting_set_brightness`
  - `climate_set_temperature`
  - `security_arm_system`

---

## Referencias

1. Anthropic. (2024). Model Context Protocol Specification. https://modelcontextprotocol.io/
2. Meta AI. (2024). Llama Models Documentation.
3. Torres-Hernandez, C. M., et al. (2025). Smart Homes: A meta-study on sense of security and home automation.
4. IEEE. (1998). IEEE Std 830-1998 - IEEE Recommended Practice for Software Requirements Specifications.

---

**Versión:** 1.0
**Fecha:** Octubre 2025
**Estado:** Borrador
