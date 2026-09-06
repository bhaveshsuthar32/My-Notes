// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const Header(),
//       drawer: Drawerbar(),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(0),
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _top_screen(),
//             const SizedBox(height: 20),

//             _category_part(),
//             const SizedBox(height: 10),
//             _notes_list(),
//             const SizedBox(height: 10,),
//             _new_notes(),
//           ],
//         ),
//       ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:my_notebook/theme/theme_provider.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0; // 0 = New, 1 = Oldest, 2 = Latest

  /// ───── Dummy Notes Data ─────
  final List<Map<String, String>> notes = [
    {
      "title": "Flutter Basics",
      "description":
          "Learn widgets, state management and layouts in Flutter. This is beginner friendly.",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s",
    },
    {
      "title": "Node.js API",
      "description":
          "Build REST APIs using Express and MongoDB with clean architecture.",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: const Header(),
      drawer: Drawerbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _top_screen(),
            const SizedBox(height: 20),

            _category_part(),
            const SizedBox(height: 15),

            _notes_list(),
            const SizedBox(height: 10),

            _notesBody(),
          ],
        ),
      ),
    );
  }

  Widget _top_screen() {
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: 280,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 61, 164, 254),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ───── Row : Image + Title ─────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image / Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.note_alt_rounded,
                  size: 36,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 16),

              // Title
              const Expanded(
                child: Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// ───── Full Width Description ─────
          const Text(
            "A simple and smart platform to manage your notes efficiently. ",
            style: TextStyle(fontSize: 15, color: Colors.white70, height: 1.5),
          ),

          // const Spacer(),
          const SizedBox(height: 28),

          /// ───── Search Bar (UI only) ─────
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Search your notes...",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _category_part() {
  //    final themeProvider = Provider.of<ThemeProvider>(context);
  //   return Padding(
  //     padding: const EdgeInsets.all(24), // outer padding
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start, // center CATEGORY text
  //       children: [
  //         // Category title
  //         const Text(
  //           "🔖CATEGORY",
  //           textAlign: TextAlign.left,
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),

  //         const SizedBox(height: 16), // spacing
  //         // First Row
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
  //                   children: const [
  //                     Icon(Icons.person, color: Colors.black54, size: 32),
  //                     SizedBox(height: 8),
  //                     Text(
  //                       "Personal",
  //                       style: TextStyle(
  //                         color: themeProvider.isDarkMode
  //                             ? Colors.white
  //                             : Colors.black,
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
  //                   children: const [
  //                     Icon(Icons.work, color: Colors.black54, size: 32),
  //                     SizedBox(height: 8),
  //                     Text("Work"),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),

  //         // Second Row
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
  //                   children: const [
  //                     Icon(Icons.school, color: Colors.black54, size: 32),
  //                     SizedBox(height: 8),
  //                     Text("Study"),
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
  //                   children: const [
  //                     Icon(Icons.lightbulb, color: Colors.black54, size: 32),
  //                     SizedBox(height: 8),
  //                     Text("Ideas"),
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





Widget _category_part() {
  final themeProvider = Provider.of<ThemeProvider>(context);

  return Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🔖CATEGORY",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        // ---------- First Row ----------
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.black54,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Personal",
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.black
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.work,
                      color: Colors.black54,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text("Work",   style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.black
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ---------- Second Row ----------
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.school,
                      color: Colors.black54,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text("Study", 
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                            ? Colors.black
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                    ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.lightbulb,
                      color: Colors.black54,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text("Ideas",
                    style: TextStyle(color: themeProvider.isDarkMode
                            ? Colors.black
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                    ),
                    ),
                     
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}














  //   int selectedIndex = 0; // 0 = New, 1 = Oldest, 2 = Latest

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
  //     final bool isSelected = selectedIndex == index;

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
  //             color: isSelected
  //                 ? const Color.fromARGB(255, 255, 254, 254)
  //                 : Colors.transparent,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow: isSelected
  //                 ? [
  //                     BoxShadow(
  //                       color: const Color.fromARGB(
  //                         255,
  //                         0,
  //                         0,
  //                         0,
  //                       ).withOpacity(0.1),
  //                       blurRadius: 8,
  //                       offset: const Offset(0, 3),
  //                     ),
  //                   ]
  //                 : [],
  //           ),
  //           child: Center(
  //             child: Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w600,
  //                 color: isSelected
  //                     ? const Color.fromARGB(255, 0, 0, 0)
  //                     : const Color.fromARGB(255, 255, 255, 255),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  //   // Widget _new_notes (){
  //   //   return Container(
  //   //     child: Column(

  //   //       children: [
  //   //         Row(
  //   //           children: [
  //   //             Image.network( 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s'),
  //   //             Column(
  //   //               children: [
  //   //                 Text("Topic name"),
  //   //                 Text("short description"),
  //   //                 Row(
  //   //                   children: [
  //   //                     Icon(Icons.note_alt_sharp),
  //   //                     Icon(Icons.delete),
  //   //                     Icon(Icons.edit_note)
  //   //                   ],
  //   //                 )
  //   //               ],
  //   //             )
  //   //           ],
  //   //         )
  //   //       ],
  //   //     ),
  //   //   );
  //   // }

  //   Widget _noteAction({required IconData icon, required Color color}) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8),
  //     child: InkWell(
  //       borderRadius: BorderRadius.circular(8),
  //       onTap: () {},
  //       child: Container(
  //         padding: const EdgeInsets.all(6),
  //         decoration: BoxDecoration(
  //           color: color.withOpacity(0.1),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Icon(
  //           icon,
  //           size: 20,
  //           color: color,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _new_notes() {
  //   final width = MediaQuery.of(context).size.width;

  //   return Center(
  //     child: Container(
  //       width: width * 0.95,
  //       margin: const EdgeInsets.symmetric(vertical: 10),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(16),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.08),
  //             blurRadius: 12,
  //             offset: const Offset(0, 6),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           /// ───── Left Image (25%) ─────
  //           Container(
  //             width: width * 0.25,
  //             height: 120,
  //             decoration: BoxDecoration(
  //               borderRadius: const BorderRadius.only(
  //                 topLeft: Radius.circular(16),
  //                 bottomLeft: Radius.circular(16),
  //               ),
  //               image: const DecorationImage(
  //                 image: NetworkImage(
  //                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s',
  //                 ),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),

  //           /// ───── Right Content ─────
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.all(14),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   /// Title
  //                   const Text(
  //                     "Topic Name",
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.black87,
  //                     ),
  //                   ),

  //                   const SizedBox(height: 6),

  //                   /// Description (overflow safe)
  //                   const Text(
  //                     "This is a short description of the note. "
  //                     "If text is long, container height will grow automatically "
  //                     "without overflow issues.",
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                       color: Colors.black54,
  //                       height: 1.4,
  //                     ),
  //                   ),

  //                   const SizedBox(height: 12),

  //                   /// Action Buttons
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       _noteAction(
  //                         icon: Icons.note_alt_outlined,
  //                         color: Colors.blue,
  //                       ),
  //                       _noteAction(
  //                         icon: Icons.edit_note,
  //                         color: Colors.orange,
  //                       ),
  //                       _noteAction(
  //                         icon: Icons.delete_outline,
  //                         color: Colors.red,
  //                       ),
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // }

  // ───────────────── SORT TABS ─────────────────
  Widget _notes_list() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 85, 137, 210),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _sortItem("New", 0),
            _sortItem("Oldest", 1),
            _sortItem("Latest", 2),
          ],
        ),
      ),
    );
  }

  Widget _sortItem(String title, int index) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────── NOTES BODY ─────────────────
  Widget _notesBody() {
    List<Map<String, String>> data = [];

    if (selectedIndex == 0) {
      data = notes; // New
    } else if (selectedIndex == 1) {
      data = notes.reversed.toList(); // Oldest
    } else {
      data = notes; // Latest (dummy same)
    }

    return Column(children: data.map((note) => _noteCard(note)).toList());
  }

  // ───────────────── NOTE CARD ─────────────────
  Widget _noteCard(Map<String, String> note) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: width * 0.95,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image (25%)
            Container(
              width: width * 0.25,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: NetworkImage(note["image"]!),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// Text Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note["title"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      note["description"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.note_alt_outlined,
                          size: 20,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.edit_note, size: 20, color: Colors.orange),
                        SizedBox(width: 10),
                        Icon(Icons.delete_outline, size: 20, color: Colors.red),
                      ],
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
