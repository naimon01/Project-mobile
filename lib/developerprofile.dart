import 'package:flutter/material.dart';

class DeveloperProfilePage extends StatefulWidget {
  const DeveloperProfilePage({super.key});

  @override
  State<DeveloperProfilePage> createState() => _DeveloperProfilePageState();
}

class _DeveloperProfilePageState extends State<DeveloperProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25,),
            Text(
                'DEVELOPER  PROFILE',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 23
                )),
            SizedBox(height: 19,),
            // Futuristic Profile Header
            Container(

              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0A0E21).withOpacity(0.8),
                    const Color(0xFF1D1E33),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                children: [

                  // Animated Code Background Profile Picture
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent.withOpacity(0.2),
                              Colors.lightBlueAccent.withOpacity(0.5),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 3,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.lightBlueAccent,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/gambarpastport.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.lightBlueAccent,
                        Colors.blueAccent,
                        Colors.lightBlueAccent,
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds),
                    child: const Text(
                      'MUHAMMAD NAIM',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Stack(
                    children: [
                      const Text(
                        'FLUTTER DEVELOPER',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          letterSpacing: 3,
                        ),
                      ),
                      Positioned(
                        bottom: -5,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.lightBlueAccent,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    children: [
                      _buildSocialChip(Icons.code, 'GitHub'),
                      _buildSocialChip(Icons.link, 'Portfolio'),
                      _buildSocialChip(Icons.email, 'Email'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('ABOUT ME'),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D1E33),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: const Text(
                      'Class: 4A\nAge: 20\n\n'
                          'Passionate Junior Flutter Developer with experience in mobile app development through hackathon competitions. '
                          'Currently pursuing Diploma in Electronic Engineering with IoT specialization, bringing unique hardware+software perspective to app development.\n\n'
                          'Self-taught coder with strong foundation in Dart and Flutter framework. Enthusiastic about clean code architecture and pixel-perfect UI implementations.\n\n'
                          'When not debugging, I enjoy exploring new Flutter packages, contributing to open-source projects, and building IoT-integrated mobile solutions.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSectionTitle('TECH STACK'),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildTechStackItem('Flutter', Icons.phone_android),
                      _buildTechStackItem('Dart', Icons.data_object),
                      _buildTechStackItem('Firebase', Icons.cloud),
                      _buildTechStackItem('REST API', Icons.api),
                      _buildTechStackItem('Provider', Icons.settings),
                      _buildTechStackItem('Git', Icons.code),
                      _buildTechStackItem('UI/UX', Icons.design_services),
                      _buildTechStackItem('IoT', Icons.sensors),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('EXPERIENCE'),
                            const SizedBox(height: 15),
                            _buildTimelineItem(
                              'Flutter Hackathon',
                              'Competition Participant',
                              '2024',
                              Icons.emoji_events,
                            ),
                            _buildTimelineItem(
                              'Personal Projects',
                              'Self-Learning Journey',
                              '2025-Present',
                              Icons.rocket_launch,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('EDUCATION'),
                            const SizedBox(height: 15),
                            _buildTimelineItem(
                              'Diploma in Electronic Engineering (IoT)',
                              'Kolej Kemahiran Tinggi MARA Petaling JAya',
                              '2023-2025',
                              Icons.school,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlueAccent,
                            Colors.blueAccent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Widget Builders
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlueAccent,
                Colors.blueAccent,
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 18, color: Colors.lightBlueAccent),
      label: Text(label,
          style: const TextStyle(fontSize: 12, color: Colors.white70)),
      backgroundColor: const Color(0xFF1D1E33),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
      ),
    );
  }

  Widget _buildTechStackItem(String tech, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.1),
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.lightBlueAccent),
          const SizedBox(width: 8),
          Text(
            tech,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
      String title, String subtitle, String year, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlueAccent.withOpacity(0.3),
                  Colors.blueAccent.withOpacity(0.3),
                ],
              ),
            ),
            child: Icon(icon, size: 20, color: Colors.lightBlueAccent),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  year,
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
