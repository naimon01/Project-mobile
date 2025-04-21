import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AIPage extends StatefulWidget {
  final String userName;

  const AIPage({super.key, required this.userName});

  @override
  State<AIPage> createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  String _aiResponse = "Waiting for AI response...";
  int _runCounter = 0;
  late final WebViewController _webViewController;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  final FlutterTts flutterTts = FlutterTts(); // Text-to-Speech
  bool _isWeatherAiActive = false;
  bool _isCameraMonitorActive = false;
  bool _isCameraVisible = false; // Tambahkan variabel untuk kontrol visibilitas kamera

  @override
  void initState() {
    super.initState();
    _initializeWebView();
    _initializeFirebaseListeners();
  }

  void _initializeWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://laptop-131814.tail24951c.ts.net/video'));
  }

  void _initializeFirebaseListeners() {
    _dbRef.child('Ai/response').onValue.listen((event) async {
      final data = event.snapshot.value;
      if (data != null && _aiResponse != data.toString()) {
        setState(() {
          _aiResponse = data.toString();
        });
        await flutterTts.setLanguage("ms-MY"); // Tukar ke "ms-MY" jika perlu
        await flutterTts.setPitch(1.0);
        await flutterTts.setSpeechRate(0.5); // Optional
        await flutterTts.speak(_aiResponse);
      }
    });
  }

  void _runAI() {
    setState(() {
      _runCounter++;
    });
    _dbRef.child('Ai/runingState').set(_runCounter);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('AI Process Triggered (Run #$_runCounter)'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _clearAIResponse() {
    setState(() {
      _aiResponse = "Response cleared";
    });
    flutterTts.stop(); // Hentikan bacaan jika tengah baca
  }

  void _toggleCameraMonitor(bool value) {
    setState(() {
      _isCameraMonitorActive = value;
      _isCameraVisible = value; // Kontrol visibilitas kamera berdasarkan switch
    });
    _dbRef.child('Ai/cameraMonitorActive').set(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'AI Control Center',
                    style: GoogleFonts.orbitron(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome, ${widget.userName.toLowerCase()}!',
                  style: GoogleFonts.rajdhani(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Live Camera Feed
                Row(
                  children: [
                    const Icon(Icons.camera_alt, color: Colors.greenAccent),
                    const SizedBox(width: 8),
                    Text(
                      'Live Camera Feed',
                      style: GoogleFonts.orbitron(
                        fontSize: 18,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _isCameraVisible
                      ? WebViewWidget(controller: _webViewController)
                      : Container(
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.videocam_off, size: 50, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            'Camera Feed is Off',
                            style: GoogleFonts.rajdhani(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Turn on Camera Monitoring to activate',
                            style: GoogleFonts.rajdhani(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // AI Control
                Card(
                  color: Colors.black.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.settings, color: Colors.cyanAccent),
                            const SizedBox(width: 8),
                            Text(
                              'AI Control',
                              style: GoogleFonts.orbitron(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _runAI,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent[400],
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'RUN AI ANALYSIS',
                              style: GoogleFonts.rajdhani(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // AI Response
                Card(
                  color: Colors.black.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.chat, color: Colors.white),
                                const SizedBox(width: 8),
                                Text(
                                  'AI Response:',
                                  style: GoogleFonts.orbitron(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.clear, color: Colors.redAccent),
                              onPressed: _clearAIResponse,
                              tooltip: 'Clear response',
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[700]!),
                          ),
                          child: Text(
                            _aiResponse,
                            style: GoogleFonts.rajdhani(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Smart Weather AI
                Card(
                  color: Colors.black.withOpacity(0.7),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.cloud, color: Colors.lightBlueAccent),
                            const SizedBox(width: 8),
                            Text(
                              'Smart Weather AI',
                              style: GoogleFonts.orbitron(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Auto Water Prediction',
                              style: GoogleFonts.rajdhani(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Switch(
                              value: _isWeatherAiActive,
                              onChanged: (value) {
                                setState(() {
                                  _isWeatherAiActive = value;
                                });
                                _dbRef.child('Ai/weatherAiActive').set(value);
                              },
                              activeColor: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Kamera Monitoring AI
                Card(
                  color: Colors.black.withOpacity(0.7),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.visibility, color: Colors.orangeAccent),
                            const SizedBox(width: 8),
                            Text(
                              'AI Camera Monitoring',
                              style: GoogleFonts.orbitron(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pest Alert Monitoring',
                              style: GoogleFonts.rajdhani(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Switch(
                              value: _isCameraMonitorActive,
                              onChanged: _toggleCameraMonitor, // Gunakan fungsi yang sudah dimodifikasi
                              activeColor: Colors.orangeAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}