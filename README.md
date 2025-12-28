# 🏥 Remote Health Monitoring System (TÜBİTAK 2209-A)

This project is a high-reliability, real-time health monitoring solution developed under the **TÜBİTAK 2209-A National Research Program**. It focuses on transmitting vital health data from remote areas with limited internet connectivity using **LoRaWAN** technology and **Microsoft Azure IoT** infrastructure.

## 📡 System Architecture
The system is built on a tripartite architecture:
1. **Edge (Hardware):** ESP32-based sensors collecting vital signs.
2. **Connectivity:** **LoRa (Long Range)** technology for low-power, long-distance data transmission to a gateway, then routed via **MQTT** to the cloud.
3. **Cloud & Mobile:** **Azure IoT Hub** for secure data ingestion and a **Flutter** mobile application for real-time visualization.



## 🛠 Tech Stack
- **Mobile:** Flutter & Dart (Stateful architecture for real-time data updates).
- **Cloud:** Microsoft Azure IoT Hub (Device Twins, Messaging).
- **Communication:** MQTT Protocol (Port 8883 - Secure).
- **Protocol:** LoRaWAN (Right-to-Left data flow from sensor to gateway).

## 🚀 Key Technical Implementation
- **Secure Authentication:** Implemented TLS/SSL encrypted connection to Azure IoT Hub.
- **Dynamic Configuration:** Managed device metadata and connection strings using environment-driven variables.
- **Real-time Monitoring:** Leveraged the `mqtt_client` package to listen to device streams and update the UI reactively using `setState`.

## 📂 Project Structure
```text
├── lib/
│   ├── main.dart         # Flutter UI and MQTT connection logic
│   └── config.dart       # Environment configuration (Template)
├── assets/               # System architecture diagrams
└── README.md
