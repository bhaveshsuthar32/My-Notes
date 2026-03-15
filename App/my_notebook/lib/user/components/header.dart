// import 'package:flutter/material.dart';

// class Header extends StatelessWidget implements PreferredSizeWidget {
//   const Header({super.key});

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.black,
//       leading: Builder(builder: (context) {
//         return IconButton(onPressed: (){
//           Scaffold.of(context).openDrawer();
//         }, icon: const Icon(Icons.menu_book_outlined),
//            color: Colors.white,
//         );
//       }),
//       title: Text("My Notes", style: TextStyle(color: Colors.white)),

//     );
//   }
// }

import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 24, 138, 237),

      // ☰ Drawer button
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu_book_outlined),
            color: Colors.white,
          );
        },
      ),

      title: const Text("My Notes", style: TextStyle(color: Colors.white)),

      // 👉 Right side profile menu
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: PopupMenuButton<int>(
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            // 🔹 Profile icon
            icon: _profileIcon(),

            // 🔹 Dropdown items
            itemBuilder: (context) => [
              PopupMenuItem(enabled: false, child: _profileHeader()),
              const PopupMenuDivider(),

              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                ),
              ),
            ],

            onSelected: (value) {
              if (value == 1) {
                debugPrint("Profile clicked");
              } else if (value == 2) {
                debugPrint("Settings clicked");
              } else if (value == 3) {
                debugPrint("Logout clicked");
              }
            },
          ),
        ),
      ],
    );
  }

  // 🔹 Rounded profile image with white border
  Widget _profileIcon() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s',
        ),
      ),
    );
  }

  // 🔹 Profile info (dummy data)
  Widget _profileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("John Doe", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(
          "User ID: 102345",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
