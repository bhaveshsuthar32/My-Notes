import 'package:flutter/material.dart';
import 'package:my_notebook/user/pages/notes/new_notes_form.dart';
import 'package:my_notebook/user/pages/notes/notes_page.dart';
import 'package:my_notebook/user/pages/topics/topics_page.dart';
import 'package:provider/provider.dart';

import 'package:my_notebook/theme/theme_provider.dart';
import 'package:my_notebook/user/pages/home.dart';
import 'package:my_notebook/user/pages/login/login.dart';
import 'package:my_notebook/user/pages/register/regitster.dart';

class Drawerbar extends StatelessWidget {
  const Drawerbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 🔹 Profile Header
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1976D2),
            ),
            accountName: Text(
              "James Martin",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text("james012@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About Us"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Home(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.contact_page_outlined),
            title: const Text("Admin"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Home(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.login),
            title: const Text("Login"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text("Register"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Regitster(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.padding_rounded) ,
            title: Text("New Notes"),
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(builder: (_) =>  NewNotes(),),);
            },
          ),

        ListTile(
          leading: const Icon(Icons.note_alt_outlined) ,
          title: Text("Notes"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => NotesPage(),),);
          },
        ),

          ListTile(
          leading: const Icon(Icons.note_alt_outlined) ,
          title: Text("Topics"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => TopicsPage(),),);
          },
        ),



          const Divider(),

          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                secondary: Icon(
                  themeProvider.isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                title: const Text("Dark Mode"),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}