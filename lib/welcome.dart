import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/signin.dart';
import 'package:projectmobile/signup.dart';

class SmartFarmingWelcomeScreen extends StatelessWidget {
  const SmartFarmingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade900,
              Colors.green.shade900,
              Colors.black,
            ],
          ),
        ),
        child: Column(
          children: [
            // Header section
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Drone icon placeholder
// Replace the drone icon line with:
                      Icon(Icons.energy_savings_leaf_outlined, size: 100, color: Colors.tealAccent),                      const SizedBox(height: 30),

                      // Main title
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Colors.tealAccent, Colors.lightGreenAccent],
                        ).createShader(bounds),
                        child: Text(
                          'SMART FARMING SYSTEM',
                          style: GoogleFonts.orbitron(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Subtitle
                      Text(
                        'IoT System',
                        style: GoogleFonts.rajdhani(
                          fontSize: 29,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Features grid
                      Wrap(
                        spacing: 20,
                        runSpacing: 15,
                        alignment: WrapAlignment.center,
                        children: [
                          _FeatureChip(icon: Icons.sensors, text: "IoT Sensors"),
                          _FeatureChip(icon: Icons.analytics, text: "AI Analytics"),
                          _FeatureChip(icon: Icons.cloud, text: "Cloud Sync"),
                          _FeatureChip(icon: Icons.autorenew, text: "Automation"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Button section
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Main action button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [Colors.tealAccent, Colors.lightGreenAccent],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.tealAccent.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "SIGN IN",
                          style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Secondary action
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen() ));

                      },
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.rajdhani(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Footer text
                    Text(
                      "Learn more about our technology",
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.tealAccent.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.tealAccent),
          const SizedBox(width: 8),
          Text(text,
            style: GoogleFonts.rajdhani(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}