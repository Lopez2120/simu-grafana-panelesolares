Solar Monitoring Stack (Grafana + InfluxDB + Telegraf)

Este proyecto es una prueba de concepto (PoC) para simular el monitoreo de un sistema de paneles solares con inversor.  
Se utilizan contenedores Docker para levantar un stack completo de monitoreo con:

- Grafana → visualización de datos y dashboards 24/7.  
- InfluxDB → base de datos de series temporales para almacenar métricas.  
- Telegraf → agente que simula datos de un inversor solar y los envía a InfluxDB.  

------------------------------------------------------------
Objetivo
------------------------------------------------------------
- Mostrar cómo se puede monitorear un sistema solar en tiempo real.  
- Simular métricas de un inversor solar (potencia, voltaje, temperatura).  
- Visualizar la información en un dashboard de Grafana.  
- (Opcional) Configurar alertas vía Telegram para notificar al usuario.  

------------------------------------------------------------
Arquitectura
------------------------------------------------------------
[ Telegraf (simulación) ] ---> [ InfluxDB (DB de métricas) ] ---> [ Grafana (dashboards) ]

- Telegraf: ejecuta un script que genera datos falsos de un inversor solar cada 10 segundos.  
- InfluxDB: almacena esos datos en la base solar.  
- Grafana: se conecta a InfluxDB y muestra los datos en tiempo real.  

------------------------------------------------------------
Requisitos
------------------------------------------------------------
- Docker  
- Docker Compose  

Instalación en Debian/Kali:
  sudo apt update
  sudo apt install -y docker.io docker-compose

Verificar instalación:
  docker --version
  docker compose version

------------------------------------------------------------
Configuración del proyecto
------------------------------------------------------------
1. docker-compose.yml  
   Define los tres servicios principales:  
   - InfluxDB: base de datos de series temporales.  
   - Telegraf: agente que genera datos simulados y los envía a InfluxDB.  
   - Grafana: interfaz web para visualizar dashboards.  

2. telegraf.conf  
   Configuración de Telegraf para:  
   - Ejecutar un script que simula datos solares.  
   - Enviar esos datos a la base solar en InfluxDB.  

3. scripts/fake_solar.sh  
   Script que genera datos falsos de un inversor solar (potencia, voltaje, temperatura).  

4. dashboards/solar_dashboard.json  
   Dashboard de Grafana preconfigurado para mostrar:  
   - Potencia actual (W).  
   - Producción de energía en tiempo real.  
   - Voltaje (V).  
   - Temperatura del inversor (°C).  

------------------------------------------------------------
Levantar el stack
------------------------------------------------------------
1. Clonar el repositorio y entrar al directorio.  
2. Ejecutar:
   docker compose up -d
3. Verificar que los contenedores estén corriendo:
   docker ps
   Deberías ver grafana, influxdb y telegraf.

------------------------------------------------------------
Configuración en Grafana
------------------------------------------------------------
1. Acceder a Grafana:  
   http://localhost:3000  
   Usuario: admin  
   Contraseña: admin  

2. Agregar Data Source:  
   - Tipo: InfluxDB  
   - URL: http://influxdb:8086  
   - Database: solar  
   - Guardar & Test → Data source is working  

3. Importar Dashboard:  
   - Menú → Dashboards → Import  
   - Seleccionar el archivo dashboards/solar_dashboard.json  
   - Asociar la Data Source InfluxDB  

------------------------------------------------------------
Dashboard Solar
------------------------------------------------------------
El dashboard incluye:
- Potencia Actual (W) → gauge en tiempo real.  
- Producción de Energía (W) → gráfico de líneas.  
- Voltaje (V) → gráfico de líneas.  
- Temperatura del inversor (°C) → gráfico de líneas con umbrales.  

------------------------------------------------------------
Alertas vía Telegram (opcional)
------------------------------------------------------------
1. Crear un bot en Telegram con @BotFather → obtener TOKEN.  
2. Obtener tu chat_id con @userinfobot.  
3. En Grafana → Alerting → Contact points → Add contact point  
   - Tipo: Webhook  
   - URL: https://api.telegram.org/bot<TOKEN>/sendMessage?chat_id=<CHAT_ID>&text=${message}  
4. Crear una alerta en un panel (ejemplo: si power < 200W durante 5m).  

------------------------------------------------------------
Resultado
------------------------------------------------------------
- Stack completo de monitoreo solar corriendo en Docker.  
- Datos simulados de un inversor solar (potencia, voltaje, temperatura).  
- Dashboard en Grafana con visualización en tiempo real.  
- Posibilidad de enviar alertas a Telegram.  

------------------------------------------------------------
Estructura del proyecto
------------------------------------------------------------
.
├── docker-compose.yml
├── telegraf.conf
├── scripts/
│   └── fake_solar.sh
└── dashboards/
    └── solar_dashboard.json

------------------------------------------------------------
Notas
------------------------------------------------------------
- Este proyecto es una simulación: los datos son generados aleatoriamente.  
- En un entorno real, Telegraf se configuraría para leer datos del inversor vía Modbus, MQTT o API HTTP.  
- Grafana puede integrarse con múltiples fuentes de datos y sistemas de alertas.  

------------------------------------------------------------
Licencia
------------------------------------------------------------
MIT License – libre para usar, modificar y compartir.
