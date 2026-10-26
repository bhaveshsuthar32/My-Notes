import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_notebook/services/api_services.dart';
// import 'package:my_notebook/user/components/bottom_nav.dart';
import 'package:my_notebook/user/pages/notes/new_notes_form.dart';
import 'package:my_notebook/user/pages/notes/view_notes.dart';
// import 'package:my_notebook/user/pages/topics/topics_page.dart';

class NotesPage extends StatefulWidget {
  // const NotesPage({super.key});

  final int? topicId;
  final String? topicName;

  const NotesPage({
    super.key,
    this.topicId,
    this.topicName,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryColor = Color(0xFF5B5CEB);

  // ============================================================
  // DATA
  // ============================================================

  List<dynamic> notes = [];
  List<dynamic> filteredNotes = [];

  bool isLoading = true;
  String? errorMessage;

  final TextEditingController searchController = TextEditingController();

  String selectedFilter = "All";
  String selectedSort = "Latest";

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();
    getNotes();
  }


  @override
void didUpdateWidget(covariant NotesPage oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (oldWidget.topicId != widget.topicId) {
    getNotes();
  }
}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // GET NOTES
  // ============================================================

  // Future<void> getNotes() async {
  //   try {
  //     final data = await ApiServices().getNotesDataList();

  //     if (!mounted) return;

  //     setState(() {
  //       notes = data;
  //       isLoading = false;
  //       errorMessage = null;
  //     });

  //     _applyFilters();
  //   } catch (e) {
  //     debugPrint("NOTES API ERROR: $e");

  //     if (!mounted) return;

  //     setState(() {
  //       isLoading = false;
  //       errorMessage = e.toString();
  //     });
  //   }
  // }


Future<void> getNotes() async {
  setState(() {
    isLoading = true;
    errorMessage = null;
  });

  try {
    final api = ApiServices();

    final List<dynamic> data = widget.topicId == null
        ? await api.getNotesDataList()
        : await api.getNotesByTopicAPI(widget.topicId!);

    if (!mounted) return;

    setState(() {
      notes = data;
      isLoading = false;
      errorMessage = null;
    });

    _applyFilters();
  } catch (e) {
    debugPrint("NOTES API ERROR: $e");

    if (!mounted) return;

    setState(() {
      isLoading = false;
      errorMessage = e.toString();
    });
  }
}



// Future<void> getNotes() async {
//   try {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     final api = ApiServices();

//     final List<dynamic> data = widget.topicId == null
//         ? await api.getNotesDataList()
//         : await api.getNotesByTopicAPI(widget.topicId!);

//     if (!mounted) return;

//     setState(() {
//       notes = data;
//       isLoading = false;
//       errorMessage = null;
//     });

//     _applyFilters();
//   } catch (e) {
//     debugPrint("NOTES API ERROR: $e");

//     if (!mounted) return;

//     setState(() {
//       isLoading = false;
//       errorMessage = e.toString();
//     });
//   }
// }


  // ============================================================
  // SEARCH
  // ============================================================

  void searchNotes(String value) {
    _applyFilters();
  }

  // ============================================================
  // APPLY FILTERS
  // ============================================================

  void _applyFilters() {
    final search = searchController.text.trim().toLowerCase();

    List<dynamic> result = List<dynamic>.from(notes);

    // ----------------------------------------------------------
    // CATEGORY FILTER
    // ----------------------------------------------------------

    if (selectedFilter == "Pinned") {
      result = result.where((note) {
        return _isPinned(note);
      }).toList();
    }

    if (selectedFilter == "Favorites") {
      result = result.where((note) {
        return _isFavorite(note);
      }).toList();
    }

    if (selectedFilter == "Archive") {
      result = result.where((note) {
        return _isArchived(note);
      }).toList();
    }

    // ----------------------------------------------------------
    // SEARCH FILTER
    // ----------------------------------------------------------

    if (search.isNotEmpty) {
      result = result.where((note) {
        final title = note["title"]?.toString().toLowerCase() ?? "";

        final subtitle = note["subtitle"]?.toString().toLowerCase() ?? "";

        final content = getContentPreview(note).toLowerCase();

        return title.contains(search) ||
            subtitle.contains(search) ||
            content.contains(search);
      }).toList();
    }

    // ----------------------------------------------------------
    // SORT
    // ----------------------------------------------------------

    _sortNotes(result);

    if (!mounted) return;

    setState(() {
      filteredNotes = result;
    });
  }

  // ============================================================
  // SORT
  // ============================================================

  void _sortNotes(List<dynamic> list) {
    if (selectedSort == "A-Z") {
      list.sort((a, b) {
        final titleA = a["title"]?.toString().toLowerCase() ?? "";

        final titleB = b["title"]?.toString().toLowerCase() ?? "";

        return titleA.compareTo(titleB);
      });
    }

    if (selectedSort == "Z-A") {
      list.sort((a, b) {
        final titleA = a["title"]?.toString().toLowerCase() ?? "";

        final titleB = b["title"]?.toString().toLowerCase() ?? "";

        return titleB.compareTo(titleA);
      });
    }

    if (selectedSort == "Latest") {
      list.sort((a, b) {
        final dateA = _getDate(a["created_at"]);

        final dateB = _getDate(b["created_at"]);

        return dateB.compareTo(dateA);
      });
    }

    if (selectedSort == "Oldest") {
      list.sort((a, b) {
        final dateA = _getDate(a["created_at"]);

        final dateB = _getDate(b["created_at"]);

        return dateA.compareTo(dateB);
      });
    }
  }

  DateTime _getDate(dynamic value) {
    if (value == null) {
      return DateTime(2000);
    }

    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return DateTime(2000);
    }
  }

  // ============================================================
  // PINNED
  // ============================================================

  bool _isPinned(dynamic note) {
    return note["is_pinned"] == true;
  }

  // ============================================================
  // FAVORITE
  // ============================================================

  bool _isFavorite(dynamic note) {
    return note["is_favorite"] == true;
  }

  // ============================================================
  // ARCHIVED
  // ============================================================

  bool _isArchived(dynamic note) {
    return note["is_archived"] == true;
  }

  // ============================================================
  // GET FIRST IMAGE
  // ============================================================

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

      // If image is stored as object
      if (firstImage is Map && firstImage["value"] != null) {
        final String imageUrl = firstImage["value"].toString();

        if (imageUrl.isNotEmpty && imageUrl != "null") {
          return imageUrl;
        }
      }

      // If image is stored directly as String
      if (firstImage is String) {
        final imageUrl = firstImage.trim();

        if (imageUrl.isNotEmpty) {
          return imageUrl;
        }
      }
    } catch (e) {
      debugPrint("IMAGE ERROR: $e");
    }

    return null;
  }

  // ============================================================
  // CONTENT PREVIEW
  // ============================================================

  String getContentPreview(dynamic note) {
    try {
      final preview = note["preview"];

      if (preview == null) {
        return "No content";
      }

      final text = preview.toString().trim();

      if (text.isEmpty) {
        return "No content";
      }

      return text;
    } catch (e) {
      return "No content";
    }
  }

  // ============================================================
  // ADD NOTE
  // ============================================================

  Future<void> openNewNote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewNotes()),
    );

    if (!mounted) return;

    getNotes();
  }
  // ============================================================
  // FILTER BOTTOM SHEET
  // ============================================================

  void openFilterSheet() {
    String tempSort = selectedSort;

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final isDark = Theme.of(sheetContext).brightness == Brightness.dark;

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white24 : Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Filter & Sort",
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF20202B),
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Sort by",
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _sortOption(
                          title: "Latest",
                          selected: tempSort == "Latest",
                          onTap: () {
                            setSheetState(() {
                              tempSort = "Latest";
                            });
                          },
                        ),
                        _sortOption(
                          title: "Oldest",
                          selected: tempSort == "Oldest",
                          onTap: () {
                            setSheetState(() {
                              tempSort = "Oldest";
                            });
                          },
                        ),
                        _sortOption(
                          title: "A-Z",
                          selected: tempSort == "A-Z",
                          onTap: () {
                            setSheetState(() {
                              tempSort = "A-Z";
                            });
                          },
                        ),
                        _sortOption(
                          title: "Z-A",
                          selected: tempSort == "Z-A",
                          onTap: () {
                            setSheetState(() {
                              tempSort = "Z-A";
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setSheetState(() {
                                tempSort = "Latest";
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            child: const Text("Reset"),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              selectedSort = tempSort;

                              Navigator.pop(sheetContext);

                              _applyFilters();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              minimumSize: const Size(0, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            child: const Text(
                              "Apply",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // SORT OPTION
  // ============================================================

  Widget _sortOption({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? primaryColor : primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : primaryColor,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark
        ? const Color(0xFF111118)
        : const Color(0xFFF7F8FC);

    return Scaffold(
      backgroundColor: backgroundColor,

      // ========================================================
      // BODY
      // ========================================================
      body: SafeArea(
        child: Column(
          children: [Expanded(child: _buildBody(isDark: isDark))],
        ),
      ),

      // ========================================================
      // BOTTOM NAV
      // ========================================================

      // bottomNavigationBar: BottomNavBar(
      //   currentIndex: 0,
      //   onTap: (index) {
      //     if (index == 0) {
      //       Navigator.pop(context);
      //     }
      //   },
      // ),

      //       bottomNavigationBar: BottomNavBar(
      //   currentIndex: 0,
      //   onTap: (index) {
      //     if (index == 0) {
      //       Navigator.pop(context);
      //     }

      //     if (index == 1) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const TopicsPage(),
      //         ),
      //       );
      //     }
      //   },
      // ),

      // ========================================================
      // ADD NOTE BUTTON
      // ========================================================
      floatingActionButton: FloatingActionButton(
        onPressed: openNewNote,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 29),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // ============================================================
  // BODY
  // ============================================================

  Widget _buildBody({required bool isDark}) {
    if (errorMessage != null) {
      return _buildErrorState(isDark: isDark);
    }

    if (isLoading) {
      return _buildLoadingState(isDark);
    }

    return RefreshIndicator(
      color: primaryColor,
      onRefresh: getNotes,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 100),
        children: [
          // ======================================================
          // HEADER
          // ======================================================
          _buildTopHeader(isDark: isDark),

          const SizedBox(height: 20),

          // ======================================================
          // SEARCH + FILTER
          // ======================================================
          Row(
            children: [
              Expanded(child: _buildSearchBar(isDark: isDark)),

              const SizedBox(width: 10),

              _buildFilterButton(isDark: isDark),
            ],
          ),

          const SizedBox(height: 14),

          // ======================================================
          // FILTER CHIPS
          // ======================================================
          _buildFilterChips(isDark: isDark),

          const SizedBox(height: 18),

          // ======================================================
          // NOTES
          // ======================================================
          if (filteredNotes.isEmpty)
            _buildEmptySearch(isDark: isDark)
          else
            ...filteredNotes.map(
              (note) => _buildNoteCard(note: note, isDark: isDark),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // TOP HEADER
  // ============================================================

  Widget _buildTopHeader({required bool isDark}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            // "All Notes",
            widget.topicName ?? "All Notes",
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF171721),
              fontSize: 27,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
            ),
          ),
        ),

        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF22222D) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? const Color(0xFF33333E) : const Color(0xFFE8E8F0),
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: openNewNote,
            icon: Icon(Icons.add_rounded, color: primaryColor, size: 23),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar({required bool isDark}) {
    return TextField(
      controller: searchController,
      onChanged: searchNotes,
      style: TextStyle(
        color: isDark ? Colors.white : const Color(0xFF20202B),
        fontSize: 12.5,
      ),
      decoration: InputDecoration(
        hintText: "Search notes...",
        hintStyle: TextStyle(
          color: isDark ? Colors.white38 : const Color(0xFF8C8C9B),
          fontSize: 12.5,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xFF73738A),
          size: 21,
        ),
        suffixIcon: searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  searchController.clear();
                  searchNotes("");
                  setState(() {});
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: isDark ? Colors.white54 : Colors.black45,
                  size: 18,
                ),
              )
            : null,
        filled: true,
        fillColor: isDark ? const Color(0xFF20202A) : const Color(0xFFF0F1F8),
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.45)),
        ),
      ),
    );
  }

  // ============================================================
  // FILTER BUTTON
  // ============================================================

  Widget _buildFilterButton({required bool isDark}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: openFilterSheet,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 50,
          height: 48,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF20202A) : const Color(0xFFF0F1F8),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selectedSort != "Latest"
                  ? primaryColor.withOpacity(0.5)
                  : Colors.transparent,
            ),
          ),
          child: Icon(
            Icons.filter_list_rounded,
            color: selectedSort != "Latest"
                ? primaryColor
                : isDark
                ? Colors.white70
                : const Color(0xFF555568),
            size: 22,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FILTER CHIPS
  // ============================================================

  Widget _buildFilterChips({required bool isDark}) {
    final filters = ["All", "Pinned", "Favorites", "Archive"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final selected = selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });

                _applyFilters();
              },
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? primaryColor
                      : isDark
                      ? const Color(0xFF252530)
                      : const Color(0xFFEDEEF5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : isDark
                        ? Colors.white70
                        : const Color(0xFF666678),
                    fontSize: 11.5,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================
  // NOTE CARD
  // ============================================================

  //   String getSubtitlePreview(dynamic note) {
  //   try {
  //     final subtitle = note["subtitle"];

  //     if (subtitle == null) {
  //       return "";
  //     }

  //     if (subtitle is List) {
  //       for (final item in subtitle) {
  //         if (item is Map && item["value"] != null) {
  //           final value = item["value"].toString().trim();

  //           if (value.isNotEmpty) {
  //             return value;
  //           }
  //         }
  //       }
  //     }

  //     if (subtitle is String) {
  //       return subtitle.trim();
  //     }

  //     return "";
  //   } catch (e) {
  //     debugPrint("SUBTITLE PREVIEW ERROR: $e");
  //     return "";
  //   }
  // }

  String getSubtitlePreview(dynamic note) {
    try {
      dynamic subtitle = note["subtitle"];

      if (subtitle == null) {
        return "";
      }

      // --------------------------------------------------
      // 1. PostgreSQL JSONB -> List
      // --------------------------------------------------
      if (subtitle is List) {
        for (final item in subtitle) {
          if (item is Map) {
            final value = item["value"];

            if (value != null) {
              final text = value.toString().trim();

              if (text.isNotEmpty && text != "{}" && text != "[]") {
                return text;
              }
            }
          }
        }

        return "";
      }

      // --------------------------------------------------
      // 2. Single Map
      // --------------------------------------------------
      if (subtitle is Map) {
        final value = subtitle["value"];

        if (value != null) {
          final text = value.toString().trim();

          if (text.isNotEmpty && text != "{}" && text != "[]") {
            return text;
          }
        }

        return "";
      }

      // --------------------------------------------------
      // 3. JSON String
      // --------------------------------------------------
      if (subtitle is String) {
        final text = subtitle.trim();

        if (text.isEmpty || text == "{}" || text == "[]") {
          return "";
        }

        // Try JSON decode
        try {
          final decoded = jsonDecode(text);

          // JSON Array
          if (decoded is List) {
            for (final item in decoded) {
              if (item is Map && item["value"] != null) {
                final value = item["value"].toString().trim();

                if (value.isNotEmpty) {
                  return value;
                }
              }
            }

            return "";
          }

          // JSON Object
          if (decoded is Map) {
            final value = decoded["value"];

            if (value != null) {
              return value.toString().trim();
            }

            return "";
          }
        } catch (_) {
          // Normal text
          return text;
        }

        return text;
      }

      return "";
    } catch (e) {
      debugPrint("SUBTITLE PREVIEW ERROR: $e");

      return "";
    }
  }

  Widget _buildNoteCard({required dynamic note, required bool isDark}) {
    final imageUrl = getFirstImageUrl(note);

    final title = note["title"]?.toString().trim().isNotEmpty == true
        ? note["title"].toString()
        : "Untitled Note";

    // final subtitle =
    //     note["subtitle"]
    //             ?.toString()
    //             .trim() ??
    //         "";

    final subtitle = getSubtitlePreview(note);
    // NEW BACKEND PREVIEW
    final content = getContentPreview(note);

    final topic = note["topicName"] ?? note["topic"] ?? note["category"] ?? "";

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C25) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF2B2B36) : const Color(0xFFEAEAF1),
        ),
      ),
      child: Row(
        children: [
          // ======================================================
          // IMAGE
          // ======================================================
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: _getNoteColor(note, isDark),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,

            // child: imageUrl != null
            //     ? Image.network(
            //         imageUrl,
            //         fit: BoxFit.cover,
            //         errorBuilder:
            //             (
            //           context,
            //           error,
            //           stackTrace,
            //         ) {
            //           return _noteIcon(
            //             note,
            //             isDark,
            //           );
            //         },
            //       )
            //     : _noteIcon(
            //         note,
            //         isDark,
            //       ),
            child: _noteIcon(note, isDark),
          ),

          const SizedBox(width: 12),

          // ======================================================
          // CONTENT
          // ======================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF20202B),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle.isNotEmpty ? subtitle : content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDark ? Colors.white60 : const Color(0xFF777786),
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    if (topic.toString().isNotEmpty) ...[
                      Text(
                        topic.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF777786),
                          fontSize: 10,
                        ),
                      ),
                      const Text(
                        "  •  ",
                        style: TextStyle(
                          color: Color(0xFFAAAAAF),
                          fontSize: 10,
                        ),
                      ),
                    ],

                    Text(
                      _formatDate(note["created_at"]),
                      style: TextStyle(
                        color: isDark
                            ? Colors.white38
                            : const Color(0xFF9999A4),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ======================================================
          // MORE
          // ======================================================
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.more_vert_rounded,
              color: isDark ? Colors.white54 : const Color(0xFF9292A0),
              size: 20,
            ),
            onSelected: (value) {
              if (value == "view") {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder:
                //         (context) =>
                //             ViewNotes(
                //       note: Map<
                //           String,
                //           dynamic>.from(
                //         note,
                //       ),
                //     ),
                //   ),
                // );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewNotes(note: Map<String, dynamic>.from(note)),
                  ),
                );
              }

              if (value == "edit") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Edit functionality will be added later"),
                  ),
                );
              }

              if (value == "delete") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Delete functionality will be added later"),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "view",
                child: Row(
                  children: [
                    Icon(Icons.visibility_outlined, size: 18),
                    SizedBox(width: 10),
                    Text("View"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "edit",
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 18),
                    SizedBox(width: 10),
                    Text("Edit"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "delete",
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    SizedBox(width: 10),
                    Text("Delete"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NOTE ICON
  // ============================================================

  Widget _noteIcon(dynamic note, bool isDark) {
    return Center(
      child: Icon(
        Icons.description_rounded,
        color: isDark ? Colors.white70 : primaryColor,
        size: 28,
      ),
    );
  }

  // ============================================================
  // NOTE COLOR
  // ============================================================

  Color _getNoteColor(dynamic note, bool isDark) {
    final index = notes.indexOf(note);

    final colors = [
      const Color(0xFFEDE4FF),
      const Color(0xFFFFE9D1),
      const Color(0xFFDDEBFF),
      const Color(0xFFFFE1E5),
      const Color(0xFFDDF5E9),
      const Color(0xFFE8DEFF),
    ];

    if (isDark) {
      return const Color(0xFF292936);
    }

    return colors[index < 0 ? 0 : index % colors.length];
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatDate(dynamic value) {
    if (value == null) {
      return "";
    }

    try {
      final date = DateTime.parse(value.toString());

      final now = DateTime.now();

      final difference = now.difference(date);

      if (difference.inMinutes < 60) {
        return "${difference.inMinutes} min ago";
      }

      if (difference.inHours < 24) {
        return "${difference.inHours} hours ago";
      }

      if (difference.inDays == 1) {
        return "1 day ago";
      }

      if (difference.inDays < 7) {
        return "${difference.inDays} days ago";
      }

      if (difference.inDays < 30) {
        return "${(difference.inDays / 7).floor()} weeks ago";
      }

      return "${date.day}/${date.month}/${date.year}";
    } catch (_) {
      return "";
    }
  }

  // ============================================================
  // EMPTY SEARCH
  // ============================================================

  Widget _buildEmptySearch({required bool isDark}) {
    String title;

    if (selectedFilter == "All") {
      title = "No notes found";
    } else {
      title = "No $selectedFilter notes";
    }

    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Column(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.note_alt_outlined,
              color: primaryColor,
              size: 36,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            searchController.text.trim().isNotEmpty
                ? "Try another search keyword."
                : "Create your first note to get started.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? Colors.white54 : Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOADING
  // ============================================================

  Widget _buildLoadingState(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: primaryColor),

          const SizedBox(height: 14),

          Text(
            "Loading notes...",
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ERROR
  // ============================================================

  Widget _buildErrorState({required bool isDark}) {
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
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 42,
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
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 18),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });

                getNotes();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text("Try Again"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









