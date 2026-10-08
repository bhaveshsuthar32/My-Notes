// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/admin/admin.dart';
// import 'package:my_notebook/user/pages/notes/new_notes_form.dart';
// import 'package:my_notebook/user/pages/notes/notes_page.dart';
// import 'package:my_notebook/user/pages/topics/topics_page.dart';
// import 'package:provider/provider.dart';

// import 'package:my_notebook/theme/theme_provider.dart';
// import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/pages/login/login.dart';
// import 'package:my_notebook/user/pages/register/regitster.dart';

// class Drawerbar extends StatelessWidget {
//   const Drawerbar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           // 🔹 Profile Header
//           const UserAccountsDrawerHeader(
//             decoration: BoxDecoration(
//               color: Color(0xFF1976D2),
//             ),
//             accountName: Text(
//               "James Martin",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             accountEmail: Text("james012@gmail.com"),
//             currentAccountPicture: CircleAvatar(
//               backgroundImage: NetworkImage(
//                 "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
//               ),
//             ),
//           ),

//           ListTile(
//             leading: const Icon(Icons.info_outline),
//             title: const Text("About Us"),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const Home(),
//                 ),
//               );
//             },
//           ),

//           ListTile(
//             leading: const Icon(Icons.contact_page_outlined),
//             title: const Text("Admin"),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const Admin(),
//                 ),
//               );
//             },
//           ),

//           ListTile(
//             leading: const Icon(Icons.login),
//             title: const Text("Login"),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const LoginPage(),
//                 ),
//               );
//             },
//           ),

//           ListTile(
//             leading: const Icon(Icons.admin_panel_settings),
//             title: const Text("Register"),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const Regitster(),
//                 ),
//               );
//             },
//           ),

//           ListTile(
//             leading: const Icon(Icons.padding_rounded) ,
//             title: Text("New Notes"),
//             onTap: (){
//               Navigator.push(
//                 context, MaterialPageRoute(builder: (_) =>  NewNotes(),),);
//             },
//           ),

//         ListTile(
//           leading: const Icon(Icons.note_alt_outlined) ,
//           title: Text("Notes"),
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (_) => NotesPage(),),);
//           },
//         ),

//           ListTile(
//           leading: const Icon(Icons.note_alt_outlined) ,
//           title: Text("Topics"),
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (_) => TopicsPage(),),);
//           },
//         ),

//           const Divider(),

//           Consumer<ThemeProvider>(
//             builder: (context, themeProvider, child) {
//               return SwitchListTile(
//                 secondary: Icon(
//                   themeProvider.isDarkMode
//                       ? Icons.dark_mode
//                       : Icons.light_mode,
//                 ),
//                 title: const Text("Dark Mode"),
//                 value: themeProvider.isDarkMode,
//                 onChanged: (value) {
//                   themeProvider.toggleTheme(value);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/admin/admin.dart';
// import 'package:my_notebook/user/pages/notes/new_notes_form.dart';
// import 'package:my_notebook/user/pages/notes/notes_page.dart';
// import 'package:my_notebook/user/pages/topics/topics_page.dart';
// import 'package:provider/provider.dart';

// import 'package:my_notebook/theme/theme_provider.dart';
// import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/pages/login/login.dart';
// import 'package:my_notebook/user/pages/register/regitster.dart';

// class Drawerbar extends StatelessWidget {
//   final Function(int) onPageSelected;

//   const Drawerbar({super.key, required this.onPageSelected});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     final backgroundColor = isDark ? const Color(0xFF17171F) : Colors.white;

//     final textColor = isDark
//         ? const Color(0xFFF3F3F6)
//         : const Color(0xFF252532);

//     final secondaryColor = isDark
//         ? const Color(0xFFA3A3B2)
//         : const Color(0xFF777786);

//     final dividerColor = isDark
//         ? const Color(0xFF2D2D38)
//         : const Color(0xFFEAEAF1);

//     return Drawer(
//       backgroundColor: backgroundColor,
//       width: 300,

//       child: SafeArea(
//         child: Column(
//           children: [
//             // =====================================================
//             // DRAWER HEADER
//             // =====================================================
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
//               decoration: BoxDecoration(
//                 color: isDark
//                     ? const Color(0xFF20202B)
//                     : const Color(0xFFF7F7FC),
//                 border: Border(bottom: BorderSide(color: dividerColor)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // App Logo + Name
//                   Row(
//                     children: [
//                       Container(
//                         width: 44,
//                         height: 44,
//                         decoration: BoxDecoration(
//                           color: isDark
//                               ? const Color(0xFF302F50)
//                               : const Color(0xFFEDEBFF),
//                           borderRadius: BorderRadius.circular(13),
//                         ),
//                         child: const Icon(
//                           Icons.menu_book_rounded,
//                           color: Color(0xFF5B5CEB),
//                           size: 24,
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       Expanded(
//                         child: Text(
//                           "My Notebook",
//                           style: TextStyle(
//                             color: textColor,
//                             fontSize: 19,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),

//                       // Close Drawer
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           Icons.close_rounded,
//                           color: secondaryColor,
//                           size: 22,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // Profile
//                   Row(
//                     children: [
//                       Container(
//                         width: 48,
//                         height: 48,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: const Color(0xFF5B5CEB).withOpacity(0.25),
//                             width: 2,
//                           ),
//                         ),
//                         child: ClipOval(
//                           child: Image.network(
//                             "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
//                             fit: BoxFit.cover,
//                             errorBuilder: (_, __, ___) {
//                               return Container(
//                                 color: isDark
//                                     ? const Color(0xFF302F50)
//                                     : const Color(0xFFEDEBFF),
//                                 child: const Icon(
//                                   Icons.person_rounded,
//                                   color: Color(0xFF5B5CEB),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "James Martin",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: textColor,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),

//                             const SizedBox(height: 3),

//                             Text(
//                               "james012@gmail.com",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: secondaryColor,
//                                 fontSize: 11,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // =====================================================
//             // MENU ITEMS
//             // =====================================================
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.fromLTRB(12, 14, 12, 10),
//                 children: [
//                   // SECTION
//                   _sectionTitle(context, "GENERAL"),

//                   // About Us
//                   _drawerItem(
//                     context,
//                     icon: Icons.info_outline_rounded,
//                     title: "About Us",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const Home()),
//                       );
//                     },
//                   ),

//                   // Admin
//                   _drawerItem(
//                     context,
//                     icon: Icons.admin_panel_settings_outlined,
//                     title: "Admin",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const Admin()),
//                       );
//                     },
//                   ),

//                   // Login
//                   _drawerItem(
//                     context,
//                     icon: Icons.login_rounded,
//                     title: "Login",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const LoginPage()),
//                       );
//                     },
//                   ),

//                   // Register
//                   _drawerItem(
//                     context,
//                     icon: Icons.person_add_alt_1_rounded,
//                     title: "Register",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const Regitster()),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 14),

//                   _sectionTitle(context, "NOTES"),

//                   // New Notes
//                   _drawerItem(
//                     context,
//                     icon: Icons.note_add_outlined,
//                     title: "New Notes",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => NewNotes()),
//                       );
//                     },
//                   ),

//                   // Notes
//                   _drawerItem(
//                     context,
//                     icon: Icons.notes_rounded,
//                     title: "Notes",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => NotesPage()),
//                       );
//                     },
//                   ),

//                   // Topics
//                   // _drawerItem(
//                   //   context,
//                   //   icon: Icons.topic_outlined,
//                   //   title: "Topics",
//                   //   onTap: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (_) => TopicsPage(),
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                   _drawerItem(
//                     context,
//                     icon: Icons.topic_outlined,
//                     title: "Topics",
//                     onTap: () {
//                       Navigator.pop(context);
//                       onPageSelected(1);
//                     },
//                   ),

//                   const SizedBox(height: 14),

//                   _sectionTitle(context, "PREFERENCES"),

//                   // Dark Mode
//                   Consumer<ThemeProvider>(
//                     builder: (context, themeProvider, child) {
//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 6),
//                         decoration: BoxDecoration(
//                           color: isDark
//                               ? const Color(0xFF22222D)
//                               : const Color(0xFFF7F7FB),
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: SwitchListTile(
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 14,
//                           ),
//                           secondary: Container(
//                             width: 38,
//                             height: 38,
//                             decoration: BoxDecoration(
//                               color: isDark
//                                   ? const Color(0xFF302F50)
//                                   : const Color(0xFFEDEBFF),
//                               borderRadius: BorderRadius.circular(11),
//                             ),
//                             child: Icon(
//                               themeProvider.isDarkMode
//                                   ? Icons.dark_mode_rounded
//                                   : Icons.light_mode_rounded,
//                               color: const Color(0xFF5B5CEB),
//                               size: 20,
//                             ),
//                           ),
//                           title: Text(
//                             "Dark Mode",
//                             style: TextStyle(
//                               color: textColor,
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           subtitle: Text(
//                             themeProvider.isDarkMode
//                                 ? "Dark theme enabled"
//                                 : "Light theme enabled",
//                             style: TextStyle(
//                               color: secondaryColor,
//                               fontSize: 10,
//                             ),
//                           ),
//                           value: themeProvider.isDarkMode,
//                           activeColor: const Color(0xFF5B5CEB),
//                           onChanged: (value) {
//                             themeProvider.toggleTheme(value);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // =====================================================
//             // BOTTOM
//             // =====================================================
//             Container(
//               padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: dividerColor)),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.menu_book_rounded,
//                     size: 17,
//                     color: secondaryColor,
//                   ),

//                   const SizedBox(width: 7),

//                   Text(
//                     "My Notebook",
//                     style: TextStyle(
//                       color: secondaryColor,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),

//                   const Spacer(),

//                   Text(
//                     "v1.0.0",
//                     style: TextStyle(color: secondaryColor, fontSize: 9),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // =========================================================
//   // SECTION TITLE
//   // =========================================================

//   Widget _sectionTitle(BuildContext context, String title) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
//       child: Text(
//         title,
//         style: TextStyle(
//           color: isDark ? const Color(0xFF777785) : const Color(0xFF9999A7),
//           fontSize: 9.5,
//           fontWeight: FontWeight.w700,
//           letterSpacing: 1.1,
//         ),
//       ),
//     );
//   }

//   // =========================================================
//   // DRAWER ITEM
//   // =========================================================

//   Widget _drawerItem(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 4),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(13),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(13),
//           splashColor: const Color(0xFF5B5CEB).withOpacity(0.08),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
//             child: Row(
//               children: [
//                 Container(
//                   width: 38,
//                   height: 38,
//                   decoration: BoxDecoration(
//                     color: isDark
//                         ? const Color(0xFF252532)
//                         : const Color(0xFFF4F3FC),
//                     borderRadius: BorderRadius.circular(11),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: isDark
//                         ? const Color(0xFFAAA8F5)
//                         : const Color(0xFF5B5CEB),
//                     size: 20,
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       color: theme.textTheme.bodyLarge?.color,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),

//                 Icon(
//                   Icons.chevron_right_rounded,
//                   color: isDark
//                       ? const Color(0xFF666672)
//                       : const Color(0xFFB0B0BC),
//                   size: 19,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// // }

// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/admin/admin.dart';
// import 'package:my_notebook/user/pages/notes/new_notes_form.dart';
// import 'package:my_notebook/user/pages/notes/notes_page.dart';
// import 'package:my_notebook/user/pages/topics/topics_page.dart';
// import 'package:provider/provider.dart';

// import 'package:my_notebook/theme/theme_provider.dart';
// import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/pages/login/login.dart';
// import 'package:my_notebook/user/pages/register/regitster.dart';

// class Drawerbar extends StatelessWidget {
//   final Function(int)? onPageSelected;

//   const Drawerbar({super.key, this.onPageSelected});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     final backgroundColor = isDark ? const Color(0xFF17171F) : Colors.white;

//     final textColor = isDark
//         ? const Color(0xFFF3F3F6)
//         : const Color(0xFF252532);

//     final secondaryColor = isDark
//         ? const Color(0xFFA3A3B2)
//         : const Color(0xFF777786);

//     final dividerColor = isDark
//         ? const Color(0xFF2D2D38)
//         : const Color(0xFFEAEAF1);

//     return Drawer(
//       backgroundColor: backgroundColor,
//       width: 300,
//       child: SafeArea(
//         child: Column(
//           children: [
//             // =========================================================
//             // DRAWER HEADER
//             // =========================================================
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
//               decoration: BoxDecoration(
//                 color: isDark
//                     ? const Color(0xFF20202B)
//                     : const Color(0xFFF7F7FC),
//                 border: Border(bottom: BorderSide(color: dividerColor)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Logo + Title + Close
//                   Row(
//                     children: [
//                       Container(
//                         width: 44,
//                         height: 44,
//                         decoration: BoxDecoration(
//                           color: isDark
//                               ? const Color(0xFF302F50)
//                               : const Color(0xFFEDEBFF),
//                           borderRadius: BorderRadius.circular(13),
//                         ),
//                         child: const Icon(
//                           Icons.menu_book_rounded,
//                           color: Color(0xFF5B5CEB),
//                           size: 24,
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       Expanded(
//                         child: Text(
//                           "My Notebook",
//                           style: TextStyle(
//                             color: textColor,
//                             fontSize: 19,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),

//                       IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           Icons.close_rounded,
//                           color: secondaryColor,
//                           size: 22,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // ===================================================
//                   // PROFILE
//                   // ===================================================
//                   Row(
//                     children: [
//                       Container(
//                         width: 48,
//                         height: 48,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: const Color(0xFF5B5CEB).withOpacity(0.25),
//                             width: 2,
//                           ),
//                         ),
//                         child: ClipOval(
//                           child: Image.network(
//                             "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 color: isDark
//                                     ? const Color(0xFF302F50)
//                                     : const Color(0xFFEDEBFF),
//                                 child: const Icon(
//                                   Icons.person_rounded,
//                                   color: Color(0xFF5B5CEB),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "James Martin",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: textColor,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),

//                             const SizedBox(height: 3),

//                             Text(
//                               "james012@gmail.com",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: secondaryColor,
//                                 fontSize: 11,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // =========================================================
//             // MENU
//             // =========================================================
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.fromLTRB(12, 14, 12, 10),
//                 children: [
//                   // =====================================================
//                   // GENERAL
//                   // =====================================================
//                   _sectionTitle(context, "GENERAL"),

//                   // HOME / ABOUT
//                   _drawerItem(
//                     context,
//                     icon: Icons.home_outlined,
//                     title: "About Us",
//                     onTap: () {
//                       Navigator.pop(context);

//                       // If Drawer is inside RootPage
//                       if (onPageSelected != null) {
//                         onPageSelected!(0);
//                       } else {
//                         // If Drawer is inside another standalone page
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const Home()),
//                         );
//                       }
//                     },
//                   ),

//                   // ADMIN
//                   _drawerItem(
//                     context,
//                     icon: Icons.admin_panel_settings_outlined,
//                     title: "Admin",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const Admin()),
//                       );
//                     },
//                   ),

//                   // LOGIN
//                   _drawerItem(
//                     context,
//                     icon: Icons.login_rounded,
//                     title: "Login",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const LoginPage()),
//                       );
//                     },
//                   ),

//                   // REGISTER
//                   _drawerItem(
//                     context,
//                     icon: Icons.person_add_alt_1_rounded,
//                     title: "Register",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const Regitster()),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 14),

//                   // =====================================================
//                   // NOTES
//                   // =====================================================
//                   _sectionTitle(context, "NOTES"),

//                   // NEW NOTES
//                   _drawerItem(
//                     context,
//                     icon: Icons.note_add_outlined,
//                     title: "New Notes",
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => NewNotes()),
//                       );
//                     },
//                   ),

//                   // NOTES
//                   _drawerItem(
//                     context,
//                     icon: Icons.notes_rounded,
//                     title: "Notes",

//                     // onTap: () {
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //       builder: (_) => NotesPage(),
//                     //     ),
//                     //   );
//                     // },
//                     onTap: () {
//                       Navigator.pop(context);

//                       if (onPageSelected != null) {
//                         onPageSelected!(2);
//                       } 
//                       // else {
//                       //   Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(builder: (_) => const NotesPage()),
//                       //   );
//                       // }
//                     },
//                   ),

//                   // TOPICS
//                   _drawerItem(
//                     context,
//                     icon: Icons.topic_outlined,
//                     title: "Topics",
//                     onTap: () {
//                       Navigator.pop(context);

//                       // ===============================================
//                       // Drawer opened from RootPage
//                       // ===============================================
//                       if (onPageSelected != null) {
//                         onPageSelected!(1);
//                       } 
//                       // else {
//                       //   // =============================================
//                       //   // Drawer opened from another standalone page
//                       //   // =============================================
//                       //   Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(builder: (_) => const TopicsPage()),
//                       //   );
//                       // }
//                     },
//                   ),

//                   const SizedBox(height: 14),

//                   // =====================================================
//                   // PREFERENCES
//                   // =====================================================
//                   _sectionTitle(context, "PREFERENCES"),

//                   // DARK MODE
//                   Consumer<ThemeProvider>(
//                     builder: (context, themeProvider, child) {
//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 6),
//                         decoration: BoxDecoration(
//                           color: isDark
//                               ? const Color(0xFF22222D)
//                               : const Color(0xFFF7F7FB),
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: SwitchListTile(
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 14,
//                           ),

//                           secondary: Container(
//                             width: 38,
//                             height: 38,
//                             decoration: BoxDecoration(
//                               color: isDark
//                                   ? const Color(0xFF302F50)
//                                   : const Color(0xFFEDEBFF),
//                               borderRadius: BorderRadius.circular(11),
//                             ),
//                             child: Icon(
//                               themeProvider.isDarkMode
//                                   ? Icons.dark_mode_rounded
//                                   : Icons.light_mode_rounded,
//                               color: const Color(0xFF5B5CEB),
//                               size: 20,
//                             ),
//                           ),

//                           title: Text(
//                             "Dark Mode",
//                             style: TextStyle(
//                               color: textColor,
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),

//                           subtitle: Text(
//                             themeProvider.isDarkMode
//                                 ? "Dark theme enabled"
//                                 : "Light theme enabled",
//                             style: TextStyle(
//                               color: secondaryColor,
//                               fontSize: 10,
//                             ),
//                           ),

//                           value: themeProvider.isDarkMode,

//                           activeColor: const Color(0xFF5B5CEB),

//                           onChanged: (value) {
//                             themeProvider.toggleTheme(value);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // ===========================================================
//             // FOOTER
//             // ===========================================================
//             Container(
//               padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: dividerColor)),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.menu_book_rounded,
//                     size: 17,
//                     color: secondaryColor,
//                   ),

//                   const SizedBox(width: 7),

//                   Text(
//                     "My Notebook",
//                     style: TextStyle(
//                       color: secondaryColor,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),

//                   const Spacer(),

//                   Text(
//                     "v1.0.0",
//                     style: TextStyle(color: secondaryColor, fontSize: 9),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ===============================================================
//   // SECTION TITLE
//   // ===============================================================

//   Widget _sectionTitle(BuildContext context, String title) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
//       child: Text(
//         title,
//         style: TextStyle(
//           color: isDark ? const Color(0xFF777785) : const Color(0xFF9999A7),
//           fontSize: 9.5,
//           fontWeight: FontWeight.w700,
//           letterSpacing: 1.1,
//         ),
//       ),
//     );
//   }

//   // ===============================================================
//   // DRAWER ITEM
//   // ===============================================================

//   Widget _drawerItem(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     final theme = Theme.of(context);

//     final isDark = theme.brightness == Brightness.dark;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 4),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(13),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(13),
//           splashColor: const Color(0xFF5B5CEB).withOpacity(0.08),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
//             child: Row(
//               children: [
//                 // ICON
//                 Container(
//                   width: 38,
//                   height: 38,
//                   decoration: BoxDecoration(
//                     color: isDark
//                         ? const Color(0xFF252532)
//                         : const Color(0xFFF4F3FC),
//                     borderRadius: BorderRadius.circular(11),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: isDark
//                         ? const Color(0xFFAAA8F5)
//                         : const Color(0xFF5B5CEB),
//                     size: 20,
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 // TITLE
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       color: theme.textTheme.bodyLarge?.color,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),

//                 // ARROW
//                 Icon(
//                   Icons.chevron_right_rounded,
//                   color: isDark
//                       ? const Color(0xFF666672)
//                       : const Color(0xFFB0B0BC),
//                   size: 19,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:my_notebook/user/admin/admin.dart';
import 'package:my_notebook/user/pages/notes/new_notes_form.dart';
import 'package:provider/provider.dart';

import 'package:my_notebook/theme/theme_provider.dart';
// import 'package:my_notebook/user/pages/home.dart';
import 'package:my_notebook/user/pages/login/login.dart';
import 'package:my_notebook/user/pages/register/regitster.dart';

class Drawerbar extends StatelessWidget {
  final Function(int)? onPageSelected;

  const Drawerbar({
    super.key,
    this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor =
        isDark ? const Color(0xFF17171F) : Colors.white;

    final textColor =
        isDark ? const Color(0xFFF3F3F6) : const Color(0xFF252532);

    final secondaryColor =
        isDark ? const Color(0xFFA3A3B2) : const Color(0xFF777786);

    final dividerColor =
        isDark ? const Color(0xFF2D2D38) : const Color(0xFFEAEAF1);

    return Drawer(
      backgroundColor: backgroundColor,
      width: 300,
      child: SafeArea(
        child: Column(
          children: [
            // =========================================================
            // DRAWER HEADER
            // =========================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                20,
                22,
                20,
                20,
              ),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF20202B)
                    : const Color(0xFFF7F7FC),
                border: Border(
                  bottom: BorderSide(
                    color: dividerColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LOGO + TITLE + CLOSE
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF302F50)
                              : const Color(0xFFEDEBFF),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.menu_book_rounded,
                          color: Color(0xFF5B5CEB),
                          size: 24,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          "My Notebook",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: secondaryColor,
                          size: 22,
                        ),
                      ),
                    ],
                  ),

                  // const SizedBox(height: 20),

                  // ===================================================
                  // PROFILE
                  // ===================================================
                  // Row(
                  //   children: [
                  //     Container(
                  //       width: 48,
                  //       height: 48,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(
                  //           color: const Color(0xFF5B5CEB)
                  //               .withOpacity(0.25),
                  //           width: 2,
                  //         ),
                  //       ),
                  //       child: ClipOval(
                  //         child: Image.network(
                  //           "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                  //           fit: BoxFit.cover,
                  //           errorBuilder:
                  //               (context, error, stackTrace) {
                  //             return Container(
                  //               color: isDark
                  //                   ? const Color(0xFF302F50)
                  //                   : const Color(0xFFEDEBFF),
                  //               child: const Icon(
                  //                 Icons.person_rounded,
                  //                 color: Color(0xFF5B5CEB),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //     ),

                  //     const SizedBox(width: 12),

                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment:
                  //             CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "James Martin",
                  //             maxLines: 1,
                  //             overflow: TextOverflow.ellipsis,
                  //             style: TextStyle(
                  //               color: textColor,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w700,
                  //             ),
                  //           ),

                  //           const SizedBox(height: 3),

                  //           Text(
                  //             "james012@gmail.com",
                  //             maxLines: 1,
                  //             overflow: TextOverflow.ellipsis,
                  //             style: TextStyle(
                  //               color: secondaryColor,
                  //               fontSize: 11,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),

            // =========================================================
            // MENU
            // =========================================================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  14,
                  12,
                  10,
                ),
                children: [
                  // =====================================================
                  // GENERAL
                  // =====================================================
                  _sectionTitle(
                    context,
                    "GENERAL",
                  ),

                  // HOME
                  _drawerItem(
                    context,
                    icon: Icons.home_outlined,
                    title: "Home",
                    onTap: () {
                      Navigator.pop(context);

                      if (onPageSelected != null) {
                        onPageSelected!(0);
                      }
                    },
                  ),

                  // ADMIN
                  _drawerItem(
                    context,
                    icon: Icons.admin_panel_settings_outlined,
                    title: "Admin",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Admin(),
                        ),
                      );
                    },
                  ),

                  // LOGIN
                  _drawerItem(
                    context,
                    icon: Icons.login_rounded,
                    title: "Login",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    },
                  ),

                  // REGISTER
                  _drawerItem(
                    context,
                    icon: Icons.person_add_alt_1_rounded,
                    title: "Register",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Regitster(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  // =====================================================
                  // NOTES
                  // =====================================================
                  _sectionTitle(
                    context,
                    "NOTES",
                  ),

                  // NEW NOTES
                  _drawerItem(
                    context,
                    icon: Icons.note_add_outlined,
                    title: "New Notes",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewNotes(),
                        ),
                      );
                    },
                  ),

                  // NOTES
                  _drawerItem(
                    context,
                    icon: Icons.notes_rounded,
                    title: "Notes",
                    onTap: () {
                      // Navigator.pop(context);

                      if (onPageSelected != null) {
                        onPageSelected!(2);
                      }
                    },
                  ),

                  // TOPICS
                  _drawerItem(
                    context,
                    icon: Icons.topic_outlined,
                    title: "Topics",
                    onTap: () {
                      // Navigator.pop(context);

                      if (onPageSelected != null) {
                        onPageSelected!(1);
                      }
                    },
                  ),

                  const SizedBox(height: 14),

                  // =====================================================
                  // PREFERENCES
                  // =====================================================
                  _sectionTitle(
                    context,
                    "PREFERENCES",
                  ),

                  // DARK MODE
                  Consumer<ThemeProvider>(
                    builder: (
                      context,
                      themeProvider,
                      child,
                    ) {
                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF22222D)
                              : const Color(0xFFF7F7FB),
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                        child: SwitchListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          secondary: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF302F50)
                                  : const Color(0xFFEDEBFF),
                              borderRadius:
                                  BorderRadius.circular(11),
                            ),
                            child: Icon(
                              themeProvider.isDarkMode
                                  ? Icons.dark_mode_rounded
                                  : Icons.light_mode_rounded,
                              color:
                                  const Color(0xFF5B5CEB),
                              size: 20,
                            ),
                          ),
                          title: Text(
                            "Dark Mode",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            themeProvider.isDarkMode
                                ? "Dark theme enabled"
                                : "Light theme enabled",
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 10,
                            ),
                          ),
                          value: themeProvider.isDarkMode,
                          activeColor:
                              const Color(0xFF5B5CEB),
                          onChanged: (value) {
                            themeProvider.toggleTheme(
                              value,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // ===========================================================
            // FOOTER
            // ===========================================================
            Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                16,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: dividerColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    size: 17,
                    color: secondaryColor,
                  ),

                  const SizedBox(width: 7),

                  Text(
                    "My Notebook",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    "v1.0.0",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 9,
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

  // ===============================================================
  // SECTION TITLE
  // ===============================================================

  Widget _sectionTitle(
    BuildContext context,
    String title,
  ) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        4,
        12,
        8,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isDark
              ? const Color(0xFF777785)
              : const Color(0xFF9999A7),
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  // ===============================================================
  // DRAWER ITEM
  // ===============================================================

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark =
        theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(
        bottom: 4,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(13),
          splashColor:
              const Color(0xFF5B5CEB)
                  .withOpacity(0.08),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 9,
            ),
            child: Row(
              children: [
                // ICON
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF252532)
                        : const Color(0xFFF4F3FC),
                    borderRadius:
                        BorderRadius.circular(11),
                  ),
                  child: Icon(
                    icon,
                    color: isDark
                        ? const Color(0xFFAAA8F5)
                        : const Color(0xFF5B5CEB),
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                // TITLE
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: theme
                          .textTheme
                          .bodyLarge
                          ?.color,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // ARROW
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark
                      ? const Color(0xFF666672)
                      : const Color(0xFFB0B0BC),
                  size: 19,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}