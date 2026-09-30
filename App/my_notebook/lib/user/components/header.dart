// // import 'package:flutter/material.dart';

// // class Header extends StatelessWidget implements PreferredSizeWidget {
// //   const Header({super.key});

// //   @override
// //   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

// //   @override
// //   Widget build(BuildContext context) {
// //     return AppBar(
// //       backgroundColor: Colors.black,
// //       leading: Builder(builder: (context) {
// //         return IconButton(onPressed: (){
// //           Scaffold.of(context).openDrawer();
// //         }, icon: const Icon(Icons.menu_book_outlined),
// //            color: Colors.white,
// //         );
// //       }),
// //       title: Text("My Notes", style: TextStyle(color: Colors.white)),

// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class Header extends StatelessWidget implements PreferredSizeWidget {
//   const Header({super.key});

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: const Color.fromARGB(255, 24, 138, 237),

//       // ☰ Drawer button
//       leading: Builder(
//         builder: (context) {
//           return IconButton(
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//             icon: const Icon(Icons.menu_book_outlined),
//             color: Colors.white,
//           );
//         },
//       ),

//       title: const Text("My Notes", style: TextStyle(color: Colors.white)),

//       // 👉 Right side profile menu
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 12),
//           child: PopupMenuButton<int>(
//             offset: const Offset(0, 50),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),

//             // 🔹 Profile icon
//             icon: _profileIcon(),

//             // 🔹 Dropdown items
//             itemBuilder: (context) => [
//               PopupMenuItem(enabled: false, child: _profileHeader()),
//               const PopupMenuDivider(),

//               const PopupMenuItem(
//                 value: 1,
//                 child: ListTile(
//                   leading: Icon(Icons.person),
//                   title: Text("Profile"),
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 2,
//                 child: ListTile(
//                   leading: Icon(Icons.settings),
//                   title: Text("Settings"),
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 3,
//                 child: ListTile(
//                   leading: Icon(Icons.logout),
//                   title: Text("Logout"),
//                 ),
//               ),
//             ],

//             onSelected: (value) {
//               if (value == 1) {
//                 debugPrint("Profile clicked");
//               } else if (value == 2) {
//                 debugPrint("Settings clicked");
//               } else if (value == 3) {
//                 debugPrint("Logout clicked");
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // 🔹 Rounded profile image with white border
//   Widget _profileIcon() {
//     return Container(
//       padding: const EdgeInsets.all(2),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.white, width: 2),
//       ),
//       child: CircleAvatar(
//         radius: 16,
//         backgroundImage: NetworkImage(
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s',
//         ),
//       ),
//     );
//   }

//   // 🔹 Profile info (dummy data)
//   Widget _profileHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         Text("John Doe", style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(height: 4),
//         Text(
//           "User ID: 102345",
//           style: TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class Header extends StatelessWidget implements PreferredSizeWidget {
//   const Header({super.key});

//   @override
//   Size get preferredSize => const Size.fromHeight(72);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       backgroundColor: Colors.white,

//       // Drawer button
//       leading: Builder(
//         builder: (context) {
//           return IconButton(
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//             icon: const Icon(
//               Icons.menu_rounded,
//               size: 27,
//               color: Color(0xFF252532),
//             ),
//           );
//         },
//       ),

//       // Center title
//       titleSpacing: 0,
//       title: Row(
//         children: [
//           Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//               color: const Color(0xFFEDEBFF),
//               borderRadius: BorderRadius.circular(11),
//             ),
//             child: const Icon(
//               Icons.menu_book_rounded,
//               color: Color(0xFF5B5CEB),
//               size: 22,
//             ),
//           ),

//           const SizedBox(width: 10),

//           const Text(
//             "My Notebook",
//             style: TextStyle(
//               color: Color(0xFF20202B),
//               fontSize: 19,
//               fontWeight: FontWeight.w700,
//               letterSpacing: -0.2,
//             ),
//           ),
//         ],
//       ),

//       // Right side
//       actions: [
//         IconButton(
//           onPressed: () {
//             // Search action
//           },
//           icon: const Icon(
//             Icons.search_rounded,
//             color: Color(0xFF555563),
//             size: 24,
//           ),
//         ),

//         Padding(
//           padding: const EdgeInsets.only(right: 10),
//           child: IconButton(
//             onPressed: () {
//               // Notification action
//             },
//             icon: const Icon(
//               Icons.notifications_none_rounded,
//               color: Color(0xFF555563),
//               size: 25,
//             ),
//           ),
//         ),
//       ],

//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1),
//         child: Container(
//           height: 1,
//           color: const Color(0xFFEDEDF3),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor =
        isDark ? const Color(0xFF17171F) : Colors.white;

    final textColor =
        isDark ? const Color(0xFFF5F5F7) : const Color(0xFF20202B);

    final secondaryTextColor =
        isDark ? const Color(0xFFA5A5B5) : const Color(0xFF8A8A98);

    final borderColor =
        isDark ? const Color(0xFF2A2A35) : const Color(0xFFEDEDF3);

    final iconBackground =
        isDark ? const Color(0xFF292844) : const Color(0xFFEDEBFF);

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,

      // ================= LEFT =================
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu_rounded,
              size: 27,
              color: textColor,
            ),
          );
        },
      ),

      titleSpacing: 0,

      title: Row(
        children: [
          // Notebook Icon
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Color(0xFF5B5CEB),
              size: 22,
            ),
          ),

          const SizedBox(width: 10),

          // App Name
          Flexible(
            child: Text(
              "My Notebook",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: 19,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),

      // ================= RIGHT =================
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Hello + Name
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "John",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),

            // Profile Image
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBackground,
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF3A3948)
                        : const Color(0xFFE6E5F2),
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    "https://i.pravatar.cc/150?img=12",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person_rounded,
                        color: const Color(0xFF5B5CEB),
                        size: 25,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],

      // ================= BOTTOM BORDER =================
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: borderColor,
        ),
      ),
    );
  }
}