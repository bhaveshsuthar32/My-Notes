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

// import 'package:flutter/material.dart';
// import 'package:my_notebook/theme/theme_provider.dart';
// import 'package:my_notebook/user/pages/notes/new_notes_form.dart';
// import 'package:provider/provider.dart';
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
//         errorMessage = null;
//       });
//     } catch (e) {
//       print("API ERROR: $e");

//       setState(() {
//         isloading = false;
//         errorMessage = e.toString();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

//     final themeProvider = Provider.of<ThemeProvider>(context);

//     final bool isDark = themeProvider.isDarkMode;

//     return Scaffold(
//       appBar: Header(),
//       drawer: Drawerbar(),

//       body: errorMessage != null
//           ? Center(
//               child: Text(
//                 errorMessage!,
//                 textAlign: TextAlign.center,

//                 style: TextStyle(
//                   color: isDark
//                     ? Colors.red[200] : Colors.red,
//                       // ? Colors.white
//                       // : Colors.black,
//                 ),
//               ),
//             )

//           : isloading
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )

//               : notes.isEmpty
//                   ? Center(
//                       child: Text(
//                         "No Notes Found",

//                         style: TextStyle(
//                           color: isDark
//                               ? Colors.white
//                               : Colors.black,

//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     )

//                   : ListView.builder(
//                       padding: const EdgeInsets.all(16),

//                       itemCount: notes.length,

//                       itemBuilder: (context, index) {
//                         final note = notes[index];

//                         return Container(
//                           margin: const EdgeInsets.only(
//                             bottom: 16,
//                           ),

//                           decoration: BoxDecoration(
//                             color: isDark
//                                 ? Colors.grey.shade900
//                                 : Colors.white,

//                             borderRadius:
//                                 BorderRadius.circular(12),

//                             boxShadow: [
//                               BoxShadow(
//                                 color: isDark
//                                     ? Colors.black54
//                                     : Colors.black12,

//                                 blurRadius: 8,
//                                 spreadRadius: 1,

//                                 offset: const Offset(0, 3),
//                               ),
//                             ],
//                           ),

//                           child: Padding(
//                             padding: const EdgeInsets.all(12),

//                             child: Row(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment.start,

//                               children: [

//                                 // ================= IMAGE =================

//                                 ClipRRect(
//                                   borderRadius:
//                                       BorderRadius.circular(8),

//                                   child: SizedBox(
//                                     width: 110,
//                                     height: 110,

//                                     child: note["images"] != null &&
//                                             note["images"].isNotEmpty
//                                         ? Image.network(
//                                             note["images"][0]
//                                                 .toString(),

//                                             fit: BoxFit.cover,

//                                             errorBuilder:
//                                                 (context, error, stackTrace) {
//                                               return Container(
//                                                 color: isDark
//                                                     ? Colors.grey.shade800
//                                                     : Colors.grey.shade200,

//                                                 child: Icon(
//                                                   Icons
//                                                       .image_not_supported,
//                                                   size: 40,

//                                                   color: isDark
//                                                       ? Colors.white54
//                                                       : Colors.black45,
//                                                 ),
//                                               );
//                                             },
//                                           )
//                                         : Container(
//                                             color: isDark
//                                                 ? Colors.grey.shade800
//                                                 : Colors.grey.shade200,

//                                             child: Icon(
//                                               Icons.image,
//                                               size: 40,

//                                               color: isDark
//                                                   ? Colors.white54
//                                                   : Colors.black45,
//                                             ),
//                                           ),
//                                   ),
//                                 ),

//                                 const SizedBox(width: 14),

//                                 // ================= CONTENT =================

//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,

//                                     children: [

//                                       // TITLE
//                                       Text(
//                                         note["title"].toString(),

//                                         maxLines: 2,
//                                         overflow:
//                                             TextOverflow.ellipsis,

//                                         style: TextStyle(
//                                           color: isDark
//                                               ? Colors.white
//                                               : Colors.black,

//                                           fontSize: 18,
//                                           fontWeight:
//                                               FontWeight.bold,
//                                         ),
//                                       ),

//                                       const SizedBox(height: 5),

//                                       // SUBTITLE
//                                       // Text(
//                                       //   note["subtitle"]
//                                       //       .toString(),

//                                       //   maxLines: 2,
//                                       //   overflow:
//                                       //       TextOverflow.ellipsis,

//                                       //   style: TextStyle(
//                                       //     color: isDark
//                                       //         ? Colors.white70
//                                       //         : Colors.black54,

//                                       //     fontSize: 14,
//                                       //     fontWeight:
//                                       //         FontWeight.w500,
//                                       //   ),
//                                       // ),

//                                       // const SizedBox(height: 6),

//                                       // CONTENT
//                                       Text(
//                                         note["content"].toString(),

//                                         maxLines: 2,
//                                         overflow:
//                                             TextOverflow.ellipsis,

//                                         style: TextStyle(
//                                           color: isDark
//                                               ? Colors.white60
//                                               : Colors.black87,

//                                           fontSize: 13,
//                                         ),
//                                       ),

//                                       const SizedBox(height: 8),

//                                       // ================= ICONS =================

//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,

//                                         children: [

//                                           // VIEW
//                                           IconButton(
//                                             tooltip: "View",

//                                             onPressed: () {},

//                                             icon: Icon(
//                                               Icons
//                                                   .visibility_outlined,

//                                               color: isDark
//                                                   ? Colors.white70
//                                                   : Colors.black54,
//                                             ),
//                                           ),

//                                           // EDIT
//                                           IconButton(
//                                             tooltip: "Edit",

//                                             onPressed: () {},

//                                             icon: Icon(
//                                               Icons.edit_outlined,

//                                               color: isDark
//                                                   ? Colors.white70
//                                                   : Colors.black54,
//                                             ),
//                                           ),

//                                           // DELETE
//                                           IconButton(
//                                             tooltip: "Delete",

//                                             onPressed: () {},

//                                             icon: Icon(
//                                               Icons
//                                                   .delete_outline,

//                                               color: isDark
//                                                   ? Colors.redAccent
//                                                   : Colors.red,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),

//                           // FLOATING ACTION BUTTON
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const NewNotes(),
//             ),
//           );
//         },

//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:my_notebook/theme/theme_provider.dart';
import 'package:my_notebook/user/pages/notes/new_notes_form.dart';
import 'package:my_notebook/user/pages/notes/view_notes.dart';
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

  // Get first image URL
  String? getFirstImageUrl(dynamic note) {
    try {
      if (note["images"] == null) {
        return null;
      }

      if (note["images"] is! List) {
        return null;
      }

      if (note["images"].isEmpty) {
        return null;
      }

      final firstImage = note["images"][0];

      if (firstImage is Map && firstImage["value"] != null) {
        final String imageUrl = firstImage["value"].toString();

        if (imageUrl.isNotEmpty && imageUrl != "null") {
          return imageUrl;
        }
      }
    } catch (e) {
      print("IMAGE ERROR: $e");
    }

    return null;
  }

  // Get content preview
  String getContentPreview(dynamic note) {
    try {
      final content = note["content"];

      if (content == null) {
        return "No content";
      }

      if (content is List) {
        List<String> contentValues = [];

        for (final item in content) {
          if (item is Map && item["value"] != null) {
            final value = item["value"].toString().trim();

            if (value.isNotEmpty) {
              contentValues.add(value);
            }
          } else if (item != null) {
            contentValues.add(item.toString());
          }
        }

        if (contentValues.isNotEmpty) {
          return contentValues.join(" ");
        }

        return "No content";
      }

      return content.toString();
    } catch (e) {
      return "No content";
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final bool isDark = themeProvider.isDarkMode;

    final Color backgroundColor = isDark
        ? const Color(0xFF121212)
        : const Color(0xFFF6F7FB);

    final Color cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    final Color primaryTextColor = isDark
        ? Colors.white
        : const Color(0xFF1C1C1E);

    final Color secondaryTextColor = isDark
        ? Colors.white70
        : const Color(0xFF6B7280);

    final Color borderColor = isDark
        ? Colors.grey.shade800
        : Colors.grey.shade200;

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: Header(),

      drawer: Drawerbar(),

      body: errorMessage != null
          ? _buildErrorState(isDark: isDark, errorMessage: errorMessage!)
          : isloading
          ? _buildLoadingState(isDark)
          : notes.isEmpty
          ? _buildEmptyState(isDark: isDark)
          : RefreshIndicator(
              onRefresh: getNotes,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return _buildNoteCard(
                    context: context,
                    note: note,
                    index: index,
                    isDark: isDark,
                    cardColor: cardColor,
                    primaryTextColor: primaryTextColor,
                    secondaryTextColor: secondaryTextColor,
                    borderColor: borderColor,
                  );
                },
              ),
            ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewNotes()),
          );

          // Refresh notes after coming back
          getNotes();
        },
        icon: const Icon(Icons.add),
        label: const Text(
          "Add Note",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ================= NOTE CARD =================

  Widget _buildNoteCard({
    required BuildContext context,
    required dynamic note,
    required int index,
    required bool isDark,
    required Color cardColor,
    required Color primaryTextColor,
    required Color secondaryTextColor,
    required Color borderColor,
  }) {
    final String? imageUrl = getFirstImageUrl(note);

    final String title = note["title"]?.toString().trim().isNotEmpty == true
        ? note["title"].toString()
        : "Untitled Note";

    final String content = getContentPreview(note);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.25)
                : Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= IMAGE =================
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: 105,
                    height: 105,
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return Container(
                                color: isDark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade100,
                                child: const Center(
                                  child: SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return _buildImagePlaceholder(
                                isDark: isDark,
                                icon: Icons.image_not_supported_outlined,
                              );
                            },
                          )
                        : _buildImagePlaceholder(
                            isDark: isDark,
                            icon: Icons.image_outlined,
                          ),
                  ),
                ),

                const SizedBox(width: 14),

                // ================= CONTENT =================
                Expanded(
                  child: SizedBox(
                    height: 105,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITLE + MORE BUTTON
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),
                            ),

                            const SizedBox(width: 4),

                            Icon(
                              Icons.more_horiz,
                              color: secondaryTextColor,
                              size: 22,
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // CONTENT
                        Expanded(
                          child: Text(
                            content,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ================= DIVIDER =================
            Divider(height: 1, thickness: 0.7, color: borderColor),

            const SizedBox(height: 6),

            // ================= ACTIONS =================
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton(
                  icon: Icons.visibility_outlined,
                  label: "View",
                  color: isDark ? Colors.white70 : Colors.black54,
                  onPressed: () {
                    Navigator .push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewNotes(note: Map<String, dynamic>.from(note),))
                    );
                  },
                ),

                const SizedBox(width: 4),

                _buildActionButton(
                  icon: Icons.edit_outlined,
                  label: "Edit",
                  color: isDark ? Colors.white70 : Colors.black54,
                  onPressed: () {
                    // Edit functionality will be added later
                  },
                ),

                const SizedBox(width: 4),

                _buildActionButton(
                  icon: Icons.delete_outline,
                  label: "Delete",
                  color: isDark ? Colors.redAccent.shade100 : Colors.red,
                  onPressed: () {
                    // Delete functionality will be added later
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= IMAGE PLACEHOLDER =================

  Widget _buildImagePlaceholder({
    required bool isDark,
    required IconData icon,
  }) {
    return Container(
      color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
      child: Center(
        child: Icon(
          icon,
          size: 34,
          color: isDark ? Colors.white38 : Colors.black26,
        ),
      ),
    );
  }

  // ================= ACTION BUTTON =================

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= LOADING =================

  Widget _buildLoadingState(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 14),
          Text(
            "Loading notes...",
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ================= EMPTY =================

  Widget _buildEmptyState({required bool isDark}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.note_alt_outlined,
                size: 44,
                color: isDark ? Colors.white54 : Colors.black38,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              "No Notes Found",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              "Create your first note to get started.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.white60 : Colors.black54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= ERROR =================

  Widget _buildErrorState({
    required bool isDark,
    required String? errorMessage,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.red.withOpacity(0.15)
                    : Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 42,
                color: isDark ? Colors.redAccent.shade100 : Colors.red,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Something went wrong",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              errorMessage ?? "Unknown error occurred",
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? Colors.white60 : Colors.black54,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 18),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isloading = true;
                  errorMessage = null;
                });

                getNotes();
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
