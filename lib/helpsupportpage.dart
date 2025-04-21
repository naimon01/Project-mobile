import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Help & Support',
                      style: GoogleFonts.orbitron(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Got an issue or question? We are here to help!',
                    style: GoogleFonts.rajdhani(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // FAQs (EN)
                  _buildSectionTitle('📌 Frequently Asked Questions (FAQs)'),
                  _buildText(
                    '1. What is Auto and Manual mode in Pump Control?\n'
                        '   Auto mode will activate the pump automatically based on the soil moisture readings. If the soil is too dry (below 30%), the pump will turn on. If it is too wet (above 60%), the pump will turn off.\n'
                        '   Manual mode gives full control to the user to turn the pump on/off manually.\n\n'
                        '2. Why can’t I change the pump switch?\n'
                        '   If the pump switch is not working, it is because Auto mode is active. Switch to Manual mode to control the pump manually.\n\n'
                        '3. What do the readings on the Dashboard mean (Temperature, Humidity, Soil Moisture)?\n'
                        '   Temperature: The current temperature in the planting area (°C).\n'
                        '   Humidity: The current air humidity (%).\n'
                        '   Soil Moisture: The soil moisture level (%). The lower the value, the drier the soil.\n'
                        '   Pump Status: Shows whether the pump is on or off.\n'
                        '   IR Sensor: Detects movement or presence (if active).\n\n'
                        '4. How much sensor data is shown in the historical chart?\n'
                        '   Each historical chart only shows the latest 20 data points in real-time.',
                  ),

                  const SizedBox(height: 20),

                  // Contact Support with clickable email, phone, and website
                  _buildSectionTitle('📧 Contact Support'),

                  // Email link
                  GestureDetector(
                    onTap: () {
                      launch('mailto:helpsupport@smartfarmingapp.com');
                    },
                    child: Text(
                      '• Email: helpsupport@smartfarmingapp.com',
                      style: GoogleFonts.rajdhani(
                        fontSize: 16,
                        color: Colors.white70,
                        decoration: TextDecoration.underline, // Underline to show it’s a link
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Phone number link
                  GestureDetector(
                    onTap: () {
                      launch('tel:+601112397853');
                    },
                    child: Text(
                      '• Phone: +60 11-1239-7853',
                      style: GoogleFonts.rajdhani(
                        fontSize: 16,
                        color: Colors.white70,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Visit link
                  GestureDetector(
                    onTap: () {
                      launch('https://www.smartfarmingapp.com/tutorials');
                    },
                    child: Text(
                      '• Visit: www.smartfarmingapp.com/tutorials',
                      style: GoogleFonts.rajdhani(
                        fontSize: 16,
                        color: Colors.white70,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Video Tutorials
                  _buildSectionTitle('🎥 Video Tutorials'),
                  _buildText(
                    '• Watch brief video guides on how to use AI features, dashboard functionalities, and more.\n'
                        '• Visit: www.smartfarmingapp.com/tutorials',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.rajdhani(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.lightGreenAccent,
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: GoogleFonts.rajdhani(
        fontSize: 16,
        color: Colors.white70,
      ),
    );
  }
}
