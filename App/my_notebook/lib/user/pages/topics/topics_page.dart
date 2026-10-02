// import 'package:flutter/material.dart';
// import 'package:my_notebook/services/api_services.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';

// class TopicsPage extends StatefulWidget {
//   const TopicsPage({super.key});

//   @override
//   State<TopicsPage> createState() => _TopicsPageState();
// }

// class _TopicsPageState extends State<TopicsPage> {
//   List<dynamic> topics = [];

//   bool isloading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getTopics();
//   }

//   Future<void> getTopics() async {
//     try {
//       final data = await ApiServices().getTopicsAPI();
//       setState(() {
//         topics = data;
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
//     return Scaffold(
//       appBar: Header(),
//       drawer: Drawerbar(),

//       body: errorMessage != null
//           ? Center(
//               child: Text(
//                 errorMessage!,
//                 textAlign: TextAlign.center,

//                 style: TextStyle(
//                   // color: isDark
//                   //     ? Colors.white
//                   //     : Colors.black,
//                 ),
//               ),
//             )
//           : isloading
//           ? const Center(child: CircularProgressIndicator())
//           : topics.isEmpty
//           ? Center(
//               child: Text(
//                 "No Notes Found",

//                 style: TextStyle(
//                   // color: isDark
//                   //     ? Colors.white
//                   //     : Colors.black,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             )
//           : ListView.builder(
            
//             itemBuilder: (context, index) {
//               final topic = topics[index];

//               return Container(
//                 child: Padding(padding: const EdgeInsets.all(22),

//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,

//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         topic['coverimage'].toString()
//                       )),

//                     Expanded(
//                       flex: 7,
//                       child: Column(
//                       children: [
//                         Text(
//                           topic['name'].toString(),
//                         ),
//                         Text(
//                           topic['description'].toString(),
//                         ),

//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,

//                           children: [
//                             Text("edit"),
//                             Text("delete")
//                           ],
//                         )
//                       ],
//                     ))
//                   ],
//                 ),
                
//                 ),
//               );
//             }),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:my_notebook/theme/theme_provider.dart';
// import 'package:my_notebook/user/pages/topics/topic_form.dart';
// import 'package:provider/provider.dart';

// import 'package:my_notebook/services/api_services.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';

// class TopicsPage extends StatefulWidget {
//   const TopicsPage({super.key});

//   @override
//   State<TopicsPage> createState() => _TopicsPageState();
// }

// class _TopicsPageState extends State<TopicsPage> {
//   List<dynamic> topics = [];

//   bool isloading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     getTopics();
//   }

//   Future<void> getTopics() async {
//     try {
//       final data = await ApiServices().getTopicsAPI();

//       setState(() {
//         topics = data;
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
//     final isDark = themeProvider.isDarkMode;

//     final cardColor = isDark
//         ? Colors.grey.shade900
//         : Colors.white;

//     final titleColor = isDark
//         ? Colors.white
//         : Colors.black87;

//     final descriptionColor = isDark
//         ? Colors.white70
//         : Colors.black54;

//     return Scaffold(
//       appBar: Header(),

//       drawer: Drawerbar(),

//       body: errorMessage != null
//           ? Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Text(
//                   errorMessage!,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: isDark ? Colors.red[200] : Colors.red,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             )
//           : isloading
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : topics.isEmpty
//                   ? Center(
//                       child: Text(
//                         "No Topics Found",
//                         style: TextStyle(
//                           color: titleColor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [

//                         // TOP TEXT
//                         Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Text(
//                             "My Topics",
//                             style: TextStyle(
//                               color: titleColor,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),

//                         // TOPIC LIST
//                         Expanded(
//                           child: ListView.builder(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                             ),
//                             itemCount: topics.length,
//                             itemBuilder: (context, index) {
//                               final topic = topics[index];

//                               return Container(
//                                 margin: const EdgeInsets.only(bottom: 16),

//                                 decoration: BoxDecoration(
//                                   color: cardColor,
//                                   borderRadius: BorderRadius.circular(16),

//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: isDark
//                                           ? Colors.black26
//                                           : Colors.black12,
//                                       blurRadius: 10,
//                                       offset: const Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),

//                                 child: Padding(
//                                   padding: const EdgeInsets.all(14),

//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,

//                                     children: [

//                                       // IMAGE
//                                       Expanded(
//                                         flex: 3,
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(12),

//                                           child: topic['coverImage'] != null
//                                               ? Image.network(
//                                                   topic['coverImage'].toString(),
//                                                   height: 110,
//                                                   fit: BoxFit.cover,

//                                                   errorBuilder:
//                                                       (context, error, stackTrace) {
//                                                     return Container(
//                                                       height: 110,
//                                                       color: isDark
//                                                           ? Colors.blueGrey[900]
//                                                           : Colors.grey[200],

//                                                       child: Icon(
//                                                         Icons.image_not_supported,
//                                                         color: isDark
//                                                             ? Colors.white54
//                                                             : Colors.grey,
//                                                         size: 35,
//                                                       ),
//                                                     );
//                                                   },
//                                                 )
//                                               : Container(
//                                                   height: 110,
//                                                   color: isDark
//                                                       ? Colors.blueGrey[900]
//                                                       : Colors.grey[200],

//                                                   child: const Icon(
//                                                     Icons.image,
//                                                     size: 35,
//                                                   ),
//                                                 ),
//                                         ),
//                                       ),

//                                       const SizedBox(width: 14),

//                                       // RIGHT SIDE
//                                       Expanded(
//                                         flex: 7,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,

//                                           children: [

//                                             // TITLE
//                                             Text(
//                                               topic['name'].toString(),
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,

//                                               style: TextStyle(
//                                                 color: titleColor,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),

//                                             const SizedBox(height: 6),

//                                             // DESCRIPTION
//                                             Text(
//                                               topic['description'].toString(),
//                                               maxLines: 3,
//                                               overflow: TextOverflow.ellipsis,

//                                               style: TextStyle(
//                                                 color: descriptionColor,
//                                                 fontSize: 14,
//                                                 height: 1.4,
//                                               ),
//                                             ),

//                                             const SizedBox(height: 12),

//                                             // BUTTONS
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,

//                                               children: [

//                                                 // EDIT
//                                                 IconButton(
//                                                   tooltip: "Edit",

//                                                   onPressed: () {},

//                                                   icon: Icon(
//                                                     Icons.edit_outlined,
//                                                     color: isDark
//                                                         ? Colors.lightBlue[200]
//                                                         : Colors.blue,
//                                                   ),
//                                                 ),

//                                                 // DELETE
//                                                 IconButton(
//                                                   tooltip: "Delete",

//                                                   onPressed: () {},

//                                                   icon: Icon(
//                                                     Icons.delete_outline,
//                                                     color: isDark
//                                                         ? Colors.red[300]
//                                                         : Colors.red,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),

//       // FLOATING ACTION BUTTON
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const TopicsForm(),
//             ),
//           );
//         },

//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


// // 



import 'package:flutter/material.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/user/pages/topics/topic_form.dart';

class TopicsPage extends StatefulWidget {
  const TopicsPage({super.key});

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  List<dynamic> topics = [];

  bool isloading = true;
  String? errorMessage;

  final TextEditingController searchController = TextEditingController();

  String searchText = "";

  @override
  void initState() {
    super.initState();
    getTopics();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =========================================================
  // GET TOPICS
  // =========================================================

  Future<void> getTopics() async {
    try {
      setState(() {
        isloading = true;
        errorMessage = null;
      });

      final data = await ApiServices().getTopicsAPI();

      if (!mounted) return;

      setState(() {
        topics = data;
        isloading = false;
        errorMessage = null;
      });
    } catch (e) {
      debugPrint("TOPICS API ERROR: $e");

      if (!mounted) return;

      setState(() {
        isloading = false;
        errorMessage = e.toString();
      });
    }
  }

  // =========================================================
  // FILTER TOPICS
  // =========================================================

  List<dynamic> get filteredTopics {
    if (searchText.trim().isEmpty) {
      return topics;
    }

    final query = searchText.toLowerCase().trim();

    return topics.where((topic) {
      final name = topic['name']?.toString().toLowerCase() ?? "";
      final description =
          topic['description']?.toString().toLowerCase() ?? "";

      return name.contains(query) || description.contains(query);
    }).toList();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: RefreshIndicator(
        color: const Color(0xFF5B5CEB),
        onRefresh: getTopics,
        child: _buildBody(context),
      ),
    );
  }

  // =========================================================
  // BODY
  // =========================================================

  Widget _buildBody(BuildContext context) {
    if (isloading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF5B5CEB),
        ),
      );
    }

    if (errorMessage != null) {
      return _buildError(context);
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= TITLE =================

          _buildTitle(context),

          const SizedBox(height: 16),

          // ================= SEARCH =================

          _buildSearchBar(context),

          const SizedBox(height: 22),

          // ================= TOPIC HEADER =================

          _buildTopicHeader(context),

          const SizedBox(height: 12),

          // ================= TOPICS =================

          if (filteredTopics.isEmpty)
            _buildEmptyState(context)
          else
            _buildTopicList(context),
        ],
      ),
    );
  }

  // =========================================================
  // TITLE
  // =========================================================

  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Topics",
                style: TextStyle(
                  color: theme.textTheme.titleLarge?.color,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "Organize your notes by topics",
                style: TextStyle(
                  color: theme.textTheme.bodySmall?.color,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),

        // ADD TOPIC BUTTON
        _addTopicButton(context),
      ],
    );
  }

  // =========================================================
  // ADD TOPIC BUTTON
  // =========================================================

  Widget _addTopicButton(BuildContext context) {
    return Material(
      color: const Color(0xFF5B5CEB),
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: _openCreateTopic,
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5B5CEB).withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // SEARCH
  // =========================================================

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF24242F)
            : const Color(0xFFF4F4FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? const Color(0xFF343440)
              : const Color(0xFFE7E7F0),
        ),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
        style: TextStyle(
          color: theme.textTheme.bodyLarge?.color,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search topics...",
          hintStyle: TextStyle(
            color: isDark
                ? const Color(0xFF92929F)
                : const Color(0xFF8C8C9B),
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: isDark
                ? const Color(0xFFAAAAB8)
                : const Color(0xFF68687A),
            size: 21,
          ),
          suffixIcon: searchText.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    searchController.clear();

                    setState(() {
                      searchText = "";
                    });
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: isDark
                        ? const Color(0xFFAAAAB8)
                        : const Color(0xFF777787),
                    size: 19,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // TOPIC HEADER
  // =========================================================

  Widget _buildTopicHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            "${filteredTopics.length} Topics",
            style: TextStyle(
              color: theme.textTheme.titleMedium?.color,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Text(
          "Latest",
          style: TextStyle(
            color: theme.textTheme.bodySmall?.color,
            fontSize: 11.5,
          ),
        ),

        const SizedBox(width: 4),

        Icon(
          Icons.keyboard_arrow_down_rounded,
          color: theme.textTheme.bodySmall?.color,
          size: 18,
        ),
      ],
    );
  }

  // =========================================================
  // TOPIC LIST
  // =========================================================

  Widget _buildTopicList(BuildContext context) {
    return Column(
      children: filteredTopics.map((topic) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _topicCard(
            context,
            topic,
          ),
        );
      }).toList(),
    );
  }

  // =========================================================
  // TOPIC CARD
  // =========================================================

  Widget _topicCard(
    BuildContext context,
    dynamic topic,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String name =
        topic['name']?.toString() ?? "Untitled Topic";

    final String description =
        topic['description']?.toString() ?? "No description available";

    final String? image =
        topic['coverImage']?.toString();

    final String status =
        topic['status']?.toString() ?? "active";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Topic detail page
        },
        borderRadius: BorderRadius.circular(17),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: isDark
                  ? const Color(0xFF30303C)
                  : const Color(0xFFE8E8F0),
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.035),
                  blurRadius: 9,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // IMAGE
              // =================================================

              _topicImage(
                context,
                image,
              ),

              const SizedBox(width: 12),

              // =================================================
              // CONTENT
              // =================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE + MENU
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:
                                  theme.textTheme.titleMedium?.color,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(width: 4),

                        SizedBox(
                          width: 26,
                          height: 26,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              _showTopicMenu(
                                context,
                                topic,
                              );
                            },
                            icon: Icon(
                              Icons.more_vert_rounded,
                              color: isDark
                                  ? const Color(0xFF9A9AA8)
                                  : const Color(0xFF81818F),
                              size: 19,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // DESCRIPTION
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark
                            ? const Color(0xFFAAAAB7)
                            : const Color(0xFF777785),
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 9),

                    // BOTTOM INFO
                    Row(
                      children: [
                        // STATUS
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: status.toLowerCase() == "active"
                                ? (isDark
                                    ? const Color(0xFF163F31)
                                    : const Color(0xFFE5F7EF))
                                : (isDark
                                    ? const Color(0xFF39321B)
                                    : const Color(0xFFFFF3D9)),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color:
                                  status.toLowerCase() == "active"
                                      ? const Color(0xFF159566)
                                      : const Color(0xFFB17A00),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Icon(
                          Icons.note_alt_outlined,
                          size: 13,
                          color: isDark
                              ? const Color(0xFF858592)
                              : const Color(0xFF9292A0),
                        ),

                        const SizedBox(width: 3),

                        Text(
                          "Notes",
                          style: TextStyle(
                            color: isDark
                                ? const Color(0xFF858592)
                                : const Color(0xFF9292A0),
                            fontSize: 9.5,
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
      ),
    );
  }

  // =========================================================
  // TOPIC IMAGE
  // =========================================================

  Widget _topicImage(
    BuildContext context,
    String? image,
  ) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: SizedBox(
        width: 80,
        height: 90,
        child: image != null &&
                image.isNotEmpty &&
                image != "null"
            ? Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return _imagePlaceholder(isDark);
                },
                loadingBuilder: (
                  context,
                  child,
                  loadingProgress,
                ) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return _imageLoading(isDark);
                },
              )
            : _imagePlaceholder(isDark),
      ),
    );
  }

  // =========================================================
  // IMAGE PLACEHOLDER
  // =========================================================

  Widget _imagePlaceholder(bool isDark) {
    return Container(
      color: isDark
          ? const Color(0xFF292844)
          : const Color(0xFFEDEBFF),
      child: const Center(
        child: Icon(
          Icons.menu_book_rounded,
          color: Color(0xFF5B5CEB),
          size: 34,
        ),
      ),
    );
  }

  // =========================================================
  // IMAGE LOADING
  // =========================================================

  Widget _imageLoading(bool isDark) {
    return Container(
      color: isDark
          ? const Color(0xFF292844)
          : const Color(0xFFF1F1FA),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Color(0xFF5B5CEB),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // TOPIC MENU
  // =========================================================

  void _showTopicMenu(
    BuildContext context,
    dynamic topic,
  ) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // HANDLE
                Container(
                  width: 38,
                  height: 4,
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                ListTile(
                  leading: const Icon(
                    Icons.visibility_outlined,
                    color: Color(0xFF5B5CEB),
                  ),
                  title: const Text("View Topic"),
                  onTap: () {
                    Navigator.pop(context);

                    // View topic
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF5B5CEB),
                  ),
                  title: const Text("Edit Topic"),
                  onTap: () {
                    Navigator.pop(context);

                    // Edit topic
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ),
                  title: const Text("Delete Topic"),
                  onTap: () {
                    Navigator.pop(context);

                    // Delete topic
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 45,
      ),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF292844)
                  : const Color(0xFFEDEBFF),
              borderRadius: BorderRadius.circular(23),
            ),
            child: const Icon(
              Icons.folder_open_rounded,
              color: Color(0xFF5B5CEB),
              size: 34,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            searchText.isNotEmpty
                ? "No topics found"
                : "No topics yet",
            style: TextStyle(
              color: theme.textTheme.titleMedium?.color,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            searchText.isNotEmpty
                ? "Try searching with a different name."
                : "Create your first topic to organize your notes.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.textTheme.bodySmall?.color,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),

          if (searchText.isEmpty) ...[
            const SizedBox(height: 18),

            ElevatedButton.icon(
              onPressed: _openCreateTopic,
              icon: const Icon(
                Icons.add_rounded,
                size: 19,
              ),
              label: const Text("Create Topic"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B5CEB),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 11,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // =========================================================
  // ERROR
  // =========================================================

  Widget _buildError(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(25),
      children: [
        const SizedBox(height: 100),

        Icon(
          Icons.error_outline_rounded,
          color: Colors.red.shade400,
          size: 50,
        ),

        const SizedBox(height: 15),

        Text(
          "Something went wrong",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.textTheme.titleMedium?.color,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          errorMessage ?? "Unable to load topics.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.textTheme.bodySmall?.color,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 18),

        Center(
          child: ElevatedButton(
            onPressed: getTopics,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5B5CEB),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Try Again"),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // CREATE TOPIC
  // =========================================================

  void _openCreateTopic() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TopicsForm(),
      ),
    );

    // Form se wapas aane ke baad
    // topics refresh ho jayenge.
    getTopics();
  }
}