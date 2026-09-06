// import 'package:flutter/material.dart';
// import 'package:my_notebook/services/api_services.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';

// class NotesPage extends StatefulWidget {
//   const NotesPage({super.key});

//   @override
//   State<NotesPage> createState() => _NotesPageState();
// }

// class _NotesPageState extends State<NotesPage> {
//   List<dynamic> notes = [];

//   bool isloading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     getNotes();
//   }

//   Future<void> getNotes() async {
//     try {
//       final data = await ApiServices().getNotesData();

//       setState(() {
//         notes = data;
//         isloading = false;
//       });
//     } catch (e) {
//       print(e);

//       setState(() {
//         isloading = false;
//         errorMessage = e.toString();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Header(),
//       drawer: Drawerbar(),

//       body: errorMessage != null
//           ? Center(child: Text(errorMessage!))
//           : isloading
//           ? const Center(child: CircularProgressIndicator())
//           // Notes
//           : ListView.builder(
//               itemCount: notes.length,

//               itemBuilder: (context, index) {
//                 final note = notes[index];

//                 return Container(
//                   margin: const EdgeInsets.all(24),
//                   padding: const EdgeInsets.all(12),

//                   decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Colors.black38),
//                     borderRadius: BorderRadius.circular(6),
//                   ),

//                   child: Row(
//                     children: [
//                       Expanded(child: Image.network(
//                         note['images'][0].toString(),
//                         fit: BoxFit.cover,
//                       )),
//                       // Right side
//                       Expanded(
//                         flex: 5,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [

//                             // Title
//                             Text(note["title"].toString()),

//                             // Description
//                             Text(note["subtitle"].toString()),

//                             Text(note['content'].toString()),

//                             // Buttons
//                             Row(
//                               children: [
//                                 Text("View"),
//                                 Text("Delete"),
//                                 Text("Edit"),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_notebook/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';


class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<dynamic> notes = [];

  bool isloading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  Future<void> getNotes() async {
    try {
      final data = await ApiServices().getNotesData();

      setState(() {
        notes = data;
        isloading = false;
        errorMessage = null;
      });
    } catch (e) {
      print("API ERROR: $e");

      setState(() {
        isloading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    final bool isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: Header(),
      drawer: Drawerbar(),

      body: errorMessage != null
          ? Center(
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: isDark
                    ? Colors.red[200] : Colors.red,
                      // ? Colors.white
                      // : Colors.black,
                ),
              ),
            )

          : isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )

              : notes.isEmpty
                  ? Center(
                      child: Text(
                        "No Notes Found",

                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : Colors.black,

                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )

                  : ListView.builder(
                      padding: const EdgeInsets.all(16),

                      itemCount: notes.length,

                      itemBuilder: (context, index) {
                        final note = notes[index];

                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: 16,
                          ),

                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.grey.shade900
                                : Colors.white,

                            borderRadius:
                                BorderRadius.circular(12),

                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black54
                                    : Colors.black12,

                                blurRadius: 8,
                                spreadRadius: 1,

                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(12),

                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                // ================= IMAGE =================

                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(8),

                                  child: SizedBox(
                                    width: 110,
                                    height: 110,

                                    child: note["images"] != null &&
                                            note["images"].isNotEmpty
                                        ? Image.network(
                                            note["images"][0]
                                                .toString(),

                                            fit: BoxFit.cover,

                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: isDark
                                                    ? Colors.grey.shade800
                                                    : Colors.grey.shade200,

                                                child: Icon(
                                                  Icons
                                                      .image_not_supported,
                                                  size: 40,

                                                  color: isDark
                                                      ? Colors.white54
                                                      : Colors.black45,
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            color: isDark
                                                ? Colors.grey.shade800
                                                : Colors.grey.shade200,

                                            child: Icon(
                                              Icons.image,
                                              size: 40,

                                              color: isDark
                                                  ? Colors.white54
                                                  : Colors.black45,
                                            ),
                                          ),
                                  ),
                                ),

                                const SizedBox(width: 14),

                                // ================= CONTENT =================

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [

                                      // TITLE
                                      Text(
                                        note["title"].toString(),

                                        maxLines: 2,
                                        overflow:
                                            TextOverflow.ellipsis,

                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,

                                          fontSize: 18,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 5),

                                      // SUBTITLE
                                      // Text(
                                      //   note["subtitle"]
                                      //       .toString(),

                                      //   maxLines: 2,
                                      //   overflow:
                                      //       TextOverflow.ellipsis,

                                      //   style: TextStyle(
                                      //     color: isDark
                                      //         ? Colors.white70
                                      //         : Colors.black54,

                                      //     fontSize: 14,
                                      //     fontWeight:
                                      //         FontWeight.w500,
                                      //   ),
                                      // ),

                                      // const SizedBox(height: 6),

                                      // CONTENT
                                      Text(
                                        note["content"].toString(),

                                        maxLines: 2,
                                        overflow:
                                            TextOverflow.ellipsis,

                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white60
                                              : Colors.black87,

                                          fontSize: 13,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      // ================= ICONS =================

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,

                                        children: [

                                          // VIEW
                                          IconButton(
                                            tooltip: "View",

                                            onPressed: () {},

                                            icon: Icon(
                                              Icons
                                                  .visibility_outlined,

                                              color: isDark
                                                  ? Colors.white70
                                                  : Colors.black54,
                                            ),
                                          ),

                                          // EDIT
                                          IconButton(
                                            tooltip: "Edit",

                                            onPressed: () {},

                                            icon: Icon(
                                              Icons.edit_outlined,

                                              color: isDark
                                                  ? Colors.white70
                                                  : Colors.black54,
                                            ),
                                          ),

                                          // DELETE
                                          IconButton(
                                            tooltip: "Delete",

                                            onPressed: () {},

                                            icon: Icon(
                                              Icons
                                                  .delete_outline,

                                              color: isDark
                                                  ? Colors.redAccent
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}