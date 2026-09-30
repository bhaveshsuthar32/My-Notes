
// import 'package:flutter/material.dart';
// import 'package:my_notebook/theme/theme_provider.dart';
// import 'package:provider/provider.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int selectedIndex = 0; // 0 = New, 1 = Oldest, 2 = Latest

//   /// ───── Dummy Notes Data ─────
//   final List<Map<String, String>> notes = [
//     {
//       "title": "Flutter Basics",
//       "description":
//           "Learn widgets, state management and layouts in Flutter. This is beginner friendly.",
//       "image":
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s",
//     },
//     {
//       "title": "Node.js API",
//       "description":
//           "Build REST APIs using Express and MongoDB with clean architecture.",
//       "image":
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
    
//     return Scaffold(
      
      
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _top_screen(),
//             const SizedBox(height: 20),

//             _category_part(),
//             const SizedBox(height: 15),

//             _notes_list(),
//             const SizedBox(height: 10),

//             _notesBody(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _top_screen() {
//     final width = MediaQuery.of(context).size.width;

//     return Container(
//       height: 280,
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
//       decoration: const BoxDecoration(
//         color: Color.fromARGB(255, 61, 164, 254),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(26),
//           bottomRight: Radius.circular(26),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// ───── Row : Image + Title ─────
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Image / Icon
//               Container(
//                 width: 64,
//                 height: 64,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: const Icon(
//                   Icons.note_alt_rounded,
//                   size: 36,
//                   color: Colors.white,
//                 ),
//               ),

//               const SizedBox(width: 16),

//               // Title
//               const Expanded(
//                 child: Text(
//                   "Welcome Back!",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 18),

//           /// ───── Full Width Description ─────
//           const Text(
//             "A simple and smart platform to manage your notes efficiently. ",
//             style: TextStyle(fontSize: 15, color: Colors.white70, height: 1.5),
//           ),

//           // const Spacer(),
//           const SizedBox(height: 28),

//           /// ───── Search Bar (UI only) ─────
//           Container(
//             height: 48,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: const [
//                 Icon(Icons.search, color: Colors.grey),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     "Search your notes...",
//                     style: TextStyle(color: Colors.grey, fontSize: 14),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }





// Widget _category_part() {
//   final themeProvider = Provider.of<ThemeProvider>(context);

//   return Padding(
//     padding: const EdgeInsets.all(24),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "🔖CATEGORY",
//           textAlign: TextAlign.left,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),

//         const SizedBox(height: 16),

//         // ---------- First Row ----------
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.green[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.person,
//                       color: Colors.black54,
//                       size: 32,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       "Personal",
//                       style: TextStyle(
//                         color: themeProvider.isDarkMode
//                             ? Colors.black
//                             : Colors.black,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.work,
//                       color: Colors.black54,
//                       size: 32,
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Work",   style: TextStyle(
//                         color: themeProvider.isDarkMode
//                             ? Colors.black
//                             : Colors.black,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),

//         // ---------- Second Row ----------
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.orange[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.school,
//                       color: Colors.black54,
//                       size: 32,
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Study", 
//                     style: TextStyle(
//                       color: themeProvider.isDarkMode
//                             ? Colors.black
//                             : Colors.black,
//                         fontWeight: FontWeight.w500,
//                     ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.purple[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.lightbulb,
//                       color: Colors.black54,
//                       size: 32,
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Ideas",
//                     style: TextStyle(color: themeProvider.isDarkMode
//                             ? Colors.black
//                             : Colors.black,
//                         fontWeight: FontWeight.w500,
//                     ),
//                     ),
                     
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }


//   // ───────────────── SORT TABS ─────────────────
//   Widget _notes_list() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Container(
//         padding: const EdgeInsets.all(6),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 85, 137, 210),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             _sortItem("New", 0),
//             _sortItem("Oldest", 1),
//             _sortItem("Latest", 2),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sortItem(String title, int index) {
//     final isSelected = selectedIndex == index;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Colors.transparent,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? Colors.black : Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ───────────────── NOTES BODY ─────────────────
//   Widget _notesBody() {
//     List<Map<String, String>> data = [];

//     if (selectedIndex == 0) {
//       data = notes; // New
//     } else if (selectedIndex == 1) {
//       data = notes.reversed.toList(); // Oldest
//     } else {
//       data = notes; // Latest (dummy same)
//     }

//     return Column(children: data.map((note) => _noteCard(note)).toList());
//   }

//   // ───────────────── NOTE CARD ─────────────────
//   Widget _noteCard(Map<String, String> note) {
//     final width = MediaQuery.of(context).size.width;

//     return Center(
//       child: Container(
//         width: width * 0.95,
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Image (25%)
//             Container(
//               width: width * 0.25,
//               height: 120,
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   bottomLeft: Radius.circular(16),
//                 ),
//                 image: DecorationImage(
//                   image: NetworkImage(note["image"]!),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             /// Text Section
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(14),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       note["title"]!,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       note["description"]!,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black54,
//                         height: 1.4,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: const [
//                         Icon(
//                           Icons.note_alt_outlined,
//                           size: 20,
//                           color: Colors.blue,
//                         ),
//                         SizedBox(width: 10),
//                         Icon(Icons.edit_note, size: 20, color: Colors.orange),
//                         SizedBox(width: 10),
//                         Icon(Icons.delete_outline, size: 20, color: Colors.red),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int selectedIndex = 0;

//   final List<Map<String, String>> notes = [
//     {
//       "title": "Flutter Basics",
//       "description":
//           "Learn widgets, state management and layouts in Flutter. This is beginner friendly.",
//       "image":
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s",
//       "category": "Development",
//     },
//     {
//       "title": "Node.js API",
//       "description":
//           "Build REST APIs using Express and MongoDB with clean architecture.",
//       "image":
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s",
//       "category": "Development",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final width = size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7FC),

//       body: SafeArea(
//         child: RefreshIndicator(
//           color: const Color(0xFF5B5CEB),
//           onRefresh: () async {
//             await Future.delayed(
//               const Duration(milliseconds: 700),
//             );
//           },
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeader(width),

//                 const SizedBox(height: 22),

//                 _buildStats(width),

//                 const SizedBox(height: 28),

//                 _buildSectionTitle(
//                   title: "Quick Topics",
//                   action: "See all",
//                   onTap: () {},
//                 ),

//                 const SizedBox(height: 14),

//                 _buildCategories(),

//                 const SizedBox(height: 28),

//                 _buildSectionTitle(
//                   title: "Recent Notes",
//                   action: "See all",
//                   onTap: () {},
//                 ),

//                 const SizedBox(height: 14),

//                 _buildSortTabs(),

//                 const SizedBox(height: 14),

//                 _buildNotes(),

//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ------------------------------------------------------------
//   // HEADER
//   // ------------------------------------------------------------

//   Widget _buildHeader(double width) {
//     final horizontalPadding = width < 360 ? 16.0 : 20.0;

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(
//         horizontalPadding,
//         22,
//         horizontalPadding,
//         24,
//       ),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF7775F2),
//             Color(0xFF4E4DE7),
//           ],
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 52,
//                 height: 52,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.16),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: const Icon(
//                   Icons.menu_book_rounded,
//                   color: Colors.white,
//                   size: 28,
//                 ),
//               ),

//               const SizedBox(width: 13),

//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Good Morning 👋",
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     SizedBox(height: 3),
//                     Text(
//                       "My Notebook",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               _headerIcon(
//                 icon: Icons.notifications_none_rounded,
//                 onTap: () {},
//               ),
//             ],
//           ),

//           const SizedBox(height: 22),

//           const Text(
//             "Capture your ideas.",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 25,
//               fontWeight: FontWeight.w700,
//               height: 1.15,
//             ),
//           ),

//           const SizedBox(height: 4),

//           const Text(
//             "Organize your knowledge in one place.",
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//               height: 1.4,
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Search
//           Container(
//             height: 52,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 15,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 const Icon(
//                   Icons.search_rounded,
//                   color: Color(0xFF77778A),
//                   size: 23,
//                 ),

//                 const SizedBox(width: 10),

//                 const Expanded(
//                   child: Text(
//                     "Search your notes...",
//                     style: TextStyle(
//                       color: Color(0xFF9999A8),
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),

//                 Container(
//                   width: 34,
//                   height: 34,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF0F0FF),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(
//                     Icons.tune_rounded,
//                     color: Color(0xFF5B5CEB),
//                     size: 19,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _headerIcon({
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(15),
//         child: Container(
//           width: 46,
//           height: 46,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.14),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Icon(
//             icon,
//             color: Colors.white,
//             size: 23,
//           ),
//         ),
//       ),
//     );
//   }

//   // ------------------------------------------------------------
//   // STATS
//   // ------------------------------------------------------------

//   Widget _buildStats(double width) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Expanded(
//             child: _statCard(
//               icon: Icons.description_outlined,
//               title: "Notes",
//               value: "12",
//             ),
//           ),

//           const SizedBox(width: 12),

//           Expanded(
//             child: _statCard(
//               icon: Icons.folder_outlined,
//               title: "Topics",
//               value: "5",
//             ),
//           ),

//           const SizedBox(width: 12),

//           Expanded(
//             child: _statCard(
//               icon: Icons.bookmark_border_rounded,
//               title: "Saved",
//               value: "8",
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _statCard({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 15,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: const Color(0xFFEAEAF4),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.035),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 36,
//             height: 36,
//             decoration: BoxDecoration(
//               color: const Color(0xFFF0F0FF),
//               borderRadius: BorderRadius.circular(11),
//             ),
//             child: Icon(
//               icon,
//               color: const Color(0xFF5B5CEB),
//               size: 20,
//             ),
//           ),

//           const SizedBox(height: 11),

//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 21,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF20202B),
//             ),
//           ),

//           const SizedBox(height: 2),

//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Color(0xFF888895),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ------------------------------------------------------------
//   // SECTION TITLE
//   // ------------------------------------------------------------

//   Widget _buildSectionTitle({
//     required String title,
//     required String action,
//     required VoidCallback onTap,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 19,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF20202B),
//               ),
//             ),
//           ),

//           GestureDetector(
//             onTap: onTap,
//             child: const Text(
//               "See all",
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Color(0xFF5B5CEB),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ------------------------------------------------------------
//   // CATEGORIES
//   // ------------------------------------------------------------

//   Widget _buildCategories() {
//     final categories = [
//       {
//         "title": "Personal",
//         "icon": Icons.person_outline_rounded,
//       },
//       {
//         "title": "Work",
//         "icon": Icons.work_outline_rounded,
//       },
//       {
//         "title": "Study",
//         "icon": Icons.school_outlined,
//       },
//       {
//         "title": "Ideas",
//         "icon": Icons.lightbulb_outline_rounded,
//       },
//     ];

//     return SizedBox(
//       height: 104,
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: categories.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         itemBuilder: (context, index) {
//           final category = categories[index];

//           return _categoryCard(
//             title: category["title"] as String,
//             icon: category["icon"] as IconData,
//             index: index,
//           );
//         },
//       ),
//     );
//   }

//   Widget _categoryCard({
//     required String title,
//     required IconData icon,
//     required int index,
//   }) {
//     final colors = [
//       const Color(0xFFEDEBFF),
//       const Color(0xFFE9F4FF),
//       const Color(0xFFFFF2E5),
//       const Color(0xFFEAF9F0),
//     ];

//     return Container(
//       width: 105,
//       padding: const EdgeInsets.all(13),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: const Color(0xFFEAEAF4),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.035),
//             blurRadius: 9,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 39,
//             height: 39,
//             decoration: BoxDecoration(
//               color: colors[index],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               icon,
//               color: const Color(0xFF5B5CEB),
//               size: 21,
//             ),
//           ),

//           const Spacer(),

//           Text(
//             title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF292936),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ------------------------------------------------------------
//   // SORT TABS
//   // ------------------------------------------------------------

//   Widget _buildSortTabs() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         height: 46,
//         padding: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           color: const Color(0xFFEDEDF8),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           children: [
//             _sortItem("New", 0),
//             _sortItem("Oldest", 1),
//             _sortItem("Latest", 2),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sortItem(String title, int index) {
//     final isSelected = selectedIndex == index;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 220),
//           curve: Curves.easeOut,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? Colors.white
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(11),
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 7,
//                       offset: const Offset(0, 2),
//                     ),
//                   ]
//                 : null,
//           ),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: isSelected
//                   ? const Color(0xFF4E4DE7)
//                   : const Color(0xFF77778A),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ------------------------------------------------------------
//   // NOTES
//   // ------------------------------------------------------------

//   Widget _buildNotes() {
//     List<Map<String, String>> data;

//     if (selectedIndex == 0) {
//       data = notes;
//     } else if (selectedIndex == 1) {
//       data = notes.reversed.toList();
//     } else {
//       data = notes;
//     }

//     if (data.isEmpty) {
//       return _emptyNotes();
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: data.map((note) {
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 13),
//             child: _noteCard(note),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _noteCard(Map<String, String> note) {
//     return Material(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(20),
//       child: InkWell(
//         onTap: () {
//           // Open View Note page here
//         },
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: const Color(0xFFEAEAF4),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.035),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               // Image
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(14),
//                 child: SizedBox(
//                   width: 92,
//                   height: 100,
//                   child: Image.network(
//                     note["image"] ?? "",
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: const Color(0xFFEDEBFF),
//                         child: const Icon(
//                           Icons.image_not_supported_outlined,
//                           color: Color(0xFF5B5CEB),
//                           size: 28,
//                         ),
//                       );
//                     },
//                     loadingBuilder: (
//                       context,
//                       child,
//                       loadingProgress,
//                     ) {
//                       if (loadingProgress == null) {
//                         return child;
//                       }

//                       return Container(
//                         color: const Color(0xFFF2F2F8),
//                         child: const Center(
//                           child: SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Color(0xFF5B5CEB),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),

//               const SizedBox(width: 13),

//               // Content
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             note["title"] ?? "",
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xFF24242F),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(width: 5),

//                         const Icon(
//                           Icons.arrow_forward_ios_rounded,
//                           size: 14,
//                           color: Color(0xFF9A9AAA),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 7),

//                     Text(
//                       note["description"] ?? "",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 12.5,
//                         height: 1.45,
//                         color: Color(0xFF858593),
//                       ),
//                     ),

//                     const SizedBox(height: 11),

//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 9,
//                             vertical: 5,
//                           ),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFF0F0FF),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             note["category"] ?? "Note",
//                             style: const TextStyle(
//                               fontSize: 10,
//                               color: Color(0xFF5B5CEB),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),

//                         const Spacer(),

//                         const Icon(
//                           Icons.more_horiz_rounded,
//                           color: Color(0xFF9A9AAA),
//                           size: 21,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ------------------------------------------------------------
//   // EMPTY STATE
//   // ------------------------------------------------------------

//   Widget _emptyNotes() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 35,
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             Container(
//               width: 70,
//               height: 70,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEDEBFF),
//                 borderRadius: BorderRadius.circular(22),
//               ),
//               child: const Icon(
//                 Icons.note_add_outlined,
//                 color: Color(0xFF5B5CEB),
//                 size: 32,
//               ),
//             ),

//             const SizedBox(height: 14),

//             const Text(
//               "No notes yet",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF292936),
//               ),
//             ),

//             const SizedBox(height: 5),

//             const Text(
//               "Create your first note and start\nbuilding your knowledge.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 13,
//                 height: 1.5,
//                 color: Color(0xFF888895),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  final List<Map<String, String>> notes = [
    {
      "title": "Flutter Basics",
      "description":
          "Learn widgets, state management and layouts in Flutter.",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s",
      "category": "Development",
    },
    {
      "title": "Node.js API",
      "description":
          "Build REST APIs using Express and PostgreSQL.",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s",
      "category": "Development",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: RefreshIndicator(
        color: const Color(0xFF5B5CEB),
        onRefresh: () async {
          await Future.delayed(
            const Duration(milliseconds: 700),
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),

              // ================= WELCOME =================

              _buildWelcome(context),

              const SizedBox(height: 22),

              // ================= STATS =================

              _buildStats(context),

              const SizedBox(height: 28),

              // ================= QUICK TOPICS =================

              _buildSectionTitle(
                context,
                title: "Quick Topics",
                action: "See all",
                onTap: () {
                  // RootPage ke Topics tab par ja sakta hai
                },
              ),

              const SizedBox(height: 14),

              _buildCategories(context),

              const SizedBox(height: 28),

              // ================= RECENT NOTES =================

              _buildSectionTitle(
                context,
                title: "Recent Notes",
                action: "See all",
                onTap: () {
                  // All Notes page open karna ho to yaha Navigator use karo
                },
              ),

              const SizedBox(height: 14),

              _buildSortTabs(context),

              const SizedBox(height: 14),

              _buildNotes(context),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // WELCOME
  // =========================================================

  Widget _buildWelcome(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF7775F2),
              Color(0xFF4E4DE7),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5B5CEB).withOpacity(0.20),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Profile
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.18),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.35),
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://i.pravatar.cc/150?img=12",
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return const Icon(
                          Icons.person,
                          color: Colors.white,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hello,",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "John 👋",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                // Small notification button
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 23,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            const Text(
              "Capture your ideas.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Organize your knowledge in one place.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // STATS
  // =========================================================

  Widget _buildStats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _statCard(
              context,
              icon: Icons.description_outlined,
              title: "Notes",
              value: "12",
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: _statCard(
              context,
              icon: Icons.folder_outlined,
              title: "Topics",
              value: "5",
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: _statCard(
              context,
              icon: Icons.bookmark_border_rounded,
              title: "Saved",
              value: "8",
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? const Color(0xFF30303D)
              : const Color(0xFFEAEAF4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF292844)
                  : const Color(0xFFF0F0FF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5B5CEB),
              size: 20,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            title,
            style: TextStyle(
              color: theme.textTheme.bodySmall?.color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SECTION TITLE
  // =========================================================

  Widget _buildSectionTitle(
    BuildContext context, {
    required String title,
    required String action,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: theme.textTheme.titleLarge?.color,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          GestureDetector(
            onTap: onTap,
            child: const Text(
              "See all",
              style: TextStyle(
                color: Color(0xFF5B5CEB),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TOPICS
  // =========================================================

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {
        "title": "Personal",
        "icon": Icons.person_outline_rounded,
      },
      {
        "title": "Work",
        "icon": Icons.work_outline_rounded,
      },
      {
        "title": "Study",
        "icon": Icons.school_outlined,
      },
      {
        "title": "Ideas",
        "icon": Icons.lightbulb_outline_rounded,
      },
    ];

    return SizedBox(
      height: 104,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          return _categoryCard(
            context,
            title: categories[index]["title"] as String,
            icon: categories[index]["icon"] as IconData,
            index: index,
          );
        },
      ),
    );
  }

  Widget _categoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required int index,
  }) {
    final theme = Theme.of(context);

    final colors = [
      const Color(0xFFEDEBFF),
      const Color(0xFFE9F4FF),
      const Color(0xFFFFF2E5),
      const Color(0xFFEAF9F0),
    ];

    return Container(
      width: 105,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF30303D)
              : const Color(0xFFEAEAF4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5B5CEB),
              size: 21,
            ),
          ),

          const Spacer(),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SORT
  // =========================================================

  Widget _buildSortTabs(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 46,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF252530)
              : const Color(0xFFEDEDF8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            _sortItem(context, "New", 0),
            _sortItem(context, "Oldest", 1),
            _sortItem(context, "Latest", 2),
          ],
        ),
      ),
    );
  }

  Widget _sortItem(
    BuildContext context,
    String title,
    int index,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark
                    ? const Color(0xFF353543)
                    : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? const Color(0xFF5B5CEB)
                  : theme.textTheme.bodySmall?.color,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // NOTES
  // =========================================================

  Widget _buildNotes(BuildContext context) {
    List<Map<String, String>> data;

    if (selectedIndex == 0) {
      data = notes;
    } else if (selectedIndex == 1) {
      data = notes.reversed.toList();
    } else {
      data = notes;
    }

    if (data.isEmpty) {
      return _emptyNotes(context);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: data.map((note) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: _noteCard(context, note),
          );
        }).toList(),
      ),
    );
  }

  Widget _noteCard(
    BuildContext context,
    Map<String, String> note,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          // View Note page
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? const Color(0xFF30303D)
                  : const Color(0xFFEAEAF4),
            ),
          ),
          child: Row(
            children: [
              // IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 90,
                  height: 95,
                  child: Image.network(
                    note["image"] ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: isDark
                            ? const Color(0xFF292844)
                            : const Color(0xFFEDEBFF),
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: Color(0xFF5B5CEB),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 13),

              // CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            note["title"] ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: theme.textTheme.titleMedium?.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: Color(0xFF9A9AAA),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Text(
                      note["description"] ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: theme.textTheme.bodySmall?.color,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),

                    const SizedBox(height: 11),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF292844)
                            : const Color(0xFFF0F0FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        note["category"] ?? "Note",
                        style: const TextStyle(
                          color: Color(0xFF5B5CEB),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY
  // =========================================================

  Widget _emptyNotes(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 35,
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBFF),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.note_add_outlined,
                color: Color(0xFF5B5CEB),
                size: 32,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              "No notes yet",
              style: TextStyle(
                color: theme.textTheme.titleMedium?.color,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Create your first note and start\nbuilding your knowledge.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}