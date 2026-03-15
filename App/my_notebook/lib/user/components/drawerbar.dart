import 'package:flutter/material.dart';
import 'package:my_notebook/user/pages/home.dart';
import 'package:my_notebook/user/pages/register/regitster.dart';

class Drawerbar extends StatefulWidget {
  const Drawerbar({super.key});

  @override
  State<Drawerbar> createState() => _DrawerbarState();
}

class _DrawerbarState extends State<Drawerbar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            // 🔹 Profile Header
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF1976D2), // Blue background
              ),
              accountName: const Text(
                "James Martin",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text("james012@gmail.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", // profile image
                ),
              ),
            ),

            // 🔹 Menu Items
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("About Us"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_page_outlined),
              title: const Text("Contact Us"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Regitster()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text("Admin"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
          ],
        ),
    );
  }
}