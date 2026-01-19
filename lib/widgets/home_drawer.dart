import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  Widget _buildMenuItem(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        Navigator.pop(context); 
        onTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 100), 
          
          _buildMenuItem(context, 'Address', () {}),
          _buildMenuItem(context, 'About', () {}),
          _buildMenuItem(context, 'Contact', () {}),

          _buildMenuItem(context, 'Logout', () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }),
        ],
      ),
    );
  }
}