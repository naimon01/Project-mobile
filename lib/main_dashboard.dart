import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmobile/dashboard_content.dart';
import 'package:projectmobile/developerprofile.dart';
import 'package:projectmobile/helpsupportpage.dart';
import 'package:projectmobile/signin.dart';
import 'package:projectmobile/ai_scanning.dart'; // Import page AI Scanning

class MainDashboard extends StatefulWidget {
  final String userName;
  final String userEmail;

  const MainDashboard({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardContent(userName: widget.userName),
      AIPage(userName: widget.userName), // <-- Added AI Scanning
      DeveloperProfilePage(),
      HelpSupportPage()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.tealAccent, Colors.lightGreenAccent],
          ).createShader(bounds),
          child: Text(
            'Smart Farming System',
            style: GoogleFonts.orbitron(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.tealAccent),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black87,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.userName, style: GoogleFonts.rajdhani(fontSize: 18)),
              accountEmail: Text(widget.userEmail, style: GoogleFonts.rajdhani(fontSize: 14)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.teal.shade800),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade800, Colors.green.shade900],
                ),
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
            _buildDrawerItem(Icons.qr_code_scanner, 'AI Scanning', 1), // <- NEW
            _buildDrawerItem(Icons.person, 'Developer Profile', 2),
            _buildDrawerItem(Icons.help, 'Help & Support', 3)
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade900, Colors.green.shade900, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(child: _pages[_selectedIndex]),
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.tealAccent),
      title: Text(title, style: GoogleFonts.rajdhani(color: Colors.white)),
      selected: _selectedIndex == index,
      onTap: () {
        _onItemTapped(index);
        Navigator.pop(context);
      },
    );
  }
}
