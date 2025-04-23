import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardContent extends StatefulWidget {
  final String userName;

  const DashboardContent({super.key, required this.userName});

  @override
  State<DashboardContent> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<DashboardContent> {
  bool _pumpStatus = false;
  double _soilMoisture = 0.0;
  double _temperature = 0.0;
  double _humidity = 0.0;
  bool _irSensorDetected = false;
  bool _isAutoMode = true;

  List<SensorData> _tempData = [];
  List<SensorData> _humidityData = [];
  List<SensorData> _moistureData = [];

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _initializeFirebaseListeners();
  }

  void _initializeFirebaseListeners() {
    _dbRef.child('Sensor/temperature').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _temperature = double.tryParse(data.toString()) ?? _temperature;
          _tempData.add(SensorData(DateTime.now(), _temperature));
          if (_tempData.length > 20) _tempData.removeAt(0);
        });
      }
    });

    _dbRef.child('Sensor/humidity').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _humidity = double.tryParse(data.toString()) ?? _humidity;
          _humidityData.add(SensorData(DateTime.now(), _humidity));
          if (_humidityData.length > 20) _humidityData.removeAt(0);
        });
      }
    });

    _dbRef.child('Sensor/moisture').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _soilMoisture = double.tryParse(data.toString()) ?? _soilMoisture;
          _moistureData.add(SensorData(DateTime.now(), _soilMoisture));
          if (_moistureData.length > 20) _moistureData.removeAt(0);
        });

        _handleAutoPumpControl();
      }
    });

    _dbRef.child('Sensor/ir').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _irSensorDetected = data.toString() == '1';
        });
      }
    });

    _dbRef.child('Actuator/pump').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _pumpStatus = data == 1;
        });
      }
    });
  }

  // ✅ Fungsi Kawalan Auto Pam Berdasarkan Threshold
  void _handleAutoPumpControl() {
    if (_isAutoMode) {
      if (_soilMoisture < 30 && !_pumpStatus) {
        _dbRef.child('Actuator/pump').set(1); // Hidupkan pam
        print("Auto: Pam hidup sebab moisture $_soilMoisture < 30");
      } else if (_soilMoisture > 60 && _pumpStatus) {
        _dbRef.child('Actuator/pump').set(0); // Matikan pam
        print("Auto: Pam mati sebab moisture $_soilMoisture > 60");
      }
    }
  }

  void _togglePump(bool status) {
    if (!_isAutoMode) {
      _dbRef.child('Actuator/pump').set(status ? 0 : 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Dashboard',
              style: GoogleFonts.orbitron(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome, ${widget.userName}!',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Irrigation Mode'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Manual'),
                      Switch(
                        value: _isAutoMode,
                        onChanged: (value) {
                          setState(() {
                            _isAutoMode = value;
                          });
                        },
                      ),
                      const Text('Auto'),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Pump Control'),
                  trailing: Switch(
                    value: _pumpStatus,
                    onChanged: _isAutoMode
                        ? null
                        : (value) {
                      setState(() {
                        _pumpStatus = value;
                        _togglePump(value);
                      });
                    },
                  ),
                  enabled: !_isAutoMode,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatusCard('Temperature', '${_temperature.toStringAsFixed(1)}°C', Icons.thermostat, Colors.red),
              const SizedBox(width: 8),
              _buildStatusCard('Humidity', '${_humidity.toStringAsFixed(1)}%', Icons.water_drop, Colors.blue),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildStatusCard('Soil Moisture', '${_soilMoisture.toStringAsFixed(1)}%', Icons.grass, Colors.green),
              const SizedBox(width: 8),
              _buildStatusCard('Pump Status', _pumpStatus ? 'ON' : 'OFF',
                  _pumpStatus ? Icons.power : Icons.power_off, _pumpStatus ? Colors.teal : Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildStatusCard(
                'IR Sensor',
                _irSensorDetected ? 'Not Detected' : 'Detected',
                Icons.sensors,
                Colors.orange,
              ),
              const SizedBox(width: 8),
              Expanded(child: Container()),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Sensor Data History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildSensorChart('Temperature (°C)', _tempData, Colors.red),
          const SizedBox(height: 16),
          _buildSensorChart('Humidity (%)', _humidityData, Colors.blue),
          const SizedBox(height: 16),
          _buildSensorChart('Soil Moisture (%)', _moistureData, Colors.green),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorChart(String title, List<SensorData> data, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(title: AxisTitle(text: 'Time')),
                primaryYAxis: NumericAxis(title: AxisTitle(text: title.split(' ')[0])),
                series: <LineSeries<SensorData, DateTime>>[
                  LineSeries<SensorData, DateTime>(
                    dataSource: data,
                    xValueMapper: (SensorData data, _) => data.time,
                    yValueMapper: (SensorData data, _) => data.value,
                    color: color,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SensorData {
  final DateTime time;
  final double value;

  SensorData(this.time, this.value);
}
