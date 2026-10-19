import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/theme/theme_provider.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';
import 'package:my_notebook/user/components/bottom_nav.dart';
import 'package:provider/provider.dart';

class ViewNotes extends StatefulWidget {
  final Map<String, dynamic> note;
  final ValueChanged<int>? onPageSelected;

  const ViewNotes({
    super.key,
    required this.note,
    this.onPageSelected,
  });

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  final PageController pageController = PageController();

  List<_NoteBlockData> allBlocks = [];
  List<List<_NoteBlockData>> pages = [];

  int currentPage = 0;

  bool isCustomizeMode = false;
  bool isSaving = false;
  bool isLoading = true;

  // ============================================================
  // THEME
  // ============================================================

  bool get isDark {
    return Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).isDarkMode;
  }

  Color get backgroundColor =>
      isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F7);

  Color get paperColor =>
      isDark ? const Color(0xFF1E1E1E) : Colors.white;

  Color get cardColor =>
      isDark ? const Color(0xFF252525) : const Color(0xFFF9FAFB);

  Color get primaryTextColor =>
      isDark ? Colors.white : const Color(0xFF1F2937);

  Color get secondaryTextColor =>
      isDark ? Colors.white70 : const Color(0xFF4B5563);

  Color get borderColor =>
      isDark ? Colors.white12 : Colors.grey.shade300;

  static const Color primaryColor = Color(0xFF5B5CEB);

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();
    _loadNoteDetails();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOAD NOTE DETAILS
  // ============================================================

  Future<void> _loadNoteDetails() async {
    try {
      final int? noteId = int.tryParse(
        widget.note["id"]?.toString() ?? "",
      );

      if (noteId == null) {
        allBlocks = _createBlocks();
        _createDefaultPages();

        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }

        return;
      }

      // Keep the list-page data first. The details endpoint may omit `layout`
      // in some responses, so don't overwrite a saved layout with null/missing data.
      final Map<String, dynamic> previousNote =
          Map<String, dynamic>.from(widget.note);

      final freshNote = await ApiServices().getNoteDetailsAPI(
        notesId: noteId,
      );

      if (!mounted) return;

      final dynamic freshLayout = freshNote["layout"];
      final dynamic previousLayout = previousNote["layout"];

      widget.note
        ..clear()
        ..addAll(previousNote)
        ..addAll(freshNote);

      // Prefer the latest layout from the details API; otherwise preserve the
      // layout already present on the note passed from NotesPage.
      if (freshLayout == null && previousLayout != null) {
        widget.note["layout"] = previousLayout;
      }

      allBlocks = _createBlocks();

      _loadSavedLayout();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint("VIEW NOTE LOAD ERROR: $e");

      if (!mounted) return;

      allBlocks = _createBlocks();

      _loadSavedLayout();

      setState(() {
        isLoading = false;
      });

      _showMessage(
        "Latest note data load nahi hua.",
      );
    }
  }

  // ============================================================
  // DATA HELPERS
  // ============================================================

  List<dynamic> _asList(dynamic data) {
    if (data == null) {
      return [];
    }

    if (data is List) {
      return data;
    }

    if (data is String) {
      try {
        final decoded = jsonDecode(data);

        if (decoded is List) {
          return decoded;
        }

        if (decoded is Map && decoded["data"] is List) {
          return decoded["data"] as List<dynamic>;
        }
      } catch (_) {
        return [];
      }
    }

    return [];
  }

  Map<String, dynamic>? _asMap(dynamic data) {
    if (data == null) {
      return null;
    }

    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    if (data is String) {
      try {
        final decoded = jsonDecode(data);

        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } catch (_) {
        return null;
      }
    }

    return null;
  }

  dynamic _findById(
    List<dynamic> list,
    String id,
  ) {
    for (final item in list) {
      if (item is Map) {
        if (item["id"]?.toString() == id) {
          return item;
        }
      }
    }

    return null;
  }

  String _getValue(dynamic item) {
    if (item is Map) {
      return item["value"]?.toString() ??
          item["text"]?.toString() ??
          item["content"]?.toString() ??
          item["url"]?.toString() ??
          item["imageUrl"]?.toString() ??
          "";
    }

    return item?.toString() ?? "";
  }

  // ============================================================
  // CREATE BLOCKS
  // ============================================================

  List<_NoteBlockData> _createBlocks() {
    final List<dynamic> subtitles =
        _asList(widget.note["subtitle"]);

    final List<dynamic> contents =
        _asList(widget.note["content"]);

    final List<dynamic> images =
        _asList(widget.note["images"]);

    final List<dynamic> contentOrder =
        _asList(widget.note["contentOrder"]);

    final List<_NoteBlockData> result = [];

    // ----------------------------------------------------------
    // USE CONTENT ORDER
    // ----------------------------------------------------------

    if (contentOrder.isNotEmpty) {
      for (final orderItem in contentOrder) {
        if (orderItem is! Map) {
          continue;
        }

        final String id =
            orderItem["id"]?.toString() ?? "";

        String type =
            orderItem["type"]?.toString().toLowerCase().trim() ?? "";

        if (id.isEmpty) {
          continue;
        }

        // Some older contentOrder entries don't include a type. Infer it
        // from the matching source array so text blocks aren't silently lost.
        if (type.isEmpty) {
          if (_findById(subtitles, id) != null) {
            type = "subtitle";
          } else if (_findById(contents, id) != null) {
            type = "content";
          } else if (_findById(images, id) != null) {
            type = "image";
          }
        }

        // Heading / Subtitle
        if (type == "heading" || type == "subtitle") {
          final item = _findById(
            subtitles,
            id,
          );

          if (item != null) {
            result.add(
              _NoteBlockData(
                id: id,
                type: type,
                value: _getValue(item),
              ),
            );
          }

          continue;
        }

        // Content / Paragraph
        if (type == "content" || type == "paragraph") {
          final item = _findById(
            contents,
            id,
          );

          if (item != null) {
            result.add(
              _NoteBlockData(
                id: id,
                type: "content",
                value: _getValue(item),
              ),
            );
          }

          continue;
        }

        // Image
        if (type == "image") {
          final item = _findById(
            images,
            id,
          );

          if (item != null) {
            result.add(
              _NoteBlockData(
                id: id,
                type: "image",
                value: _getValue(item),
              ),
            );
          }
        }
      }
    }

    // ----------------------------------------------------------
    // FALLBACK
    // ----------------------------------------------------------

    if (result.isEmpty) {
      for (final item in subtitles) {
        if (item is! Map) continue;

        final String id =
            item["id"]?.toString() ?? "";

        if (id.isEmpty) continue;

        final String type =
            item["type"]?.toString().toLowerCase() ??
                "subtitle";

        result.add(
          _NoteBlockData(
            id: id,
            type: type,
            value: _getValue(item),
          ),
        );
      }

      for (final item in contents) {
        if (item is! Map) continue;

        final String id =
            item["id"]?.toString() ?? "";

        if (id.isEmpty) continue;

        result.add(
          _NoteBlockData(
            id: id,
            type: "content",
            value: _getValue(item),
          ),
        );
      }

      for (final item in images) {
        if (item is! Map) continue;

        final String id =
            item["id"]?.toString() ?? "";

        if (id.isEmpty) continue;

        result.add(
          _NoteBlockData(
            id: id,
            type: "image",
            value: _getValue(item),
          ),
        );
      }
    }

    return result;
  }

  // ============================================================
  // LOAD SAVED LAYOUT
  // ============================================================

  void _loadSavedLayout() {
    final Map<String, dynamic>? layout =
        _asMap(widget.note["layout"]);

    if (layout == null) {
      _createDefaultPages();
      return;
    }

    final dynamic pagesData = layout["pages"];

    if (pagesData is! List || pagesData.isEmpty) {
      _createDefaultPages();
      return;
    }

    final List<List<_NoteBlockData>> loadedPages = [];
    final Set<String> usedIds = {};

    for (final pageData in pagesData) {
      if (pageData is! Map) {
        continue;
      }

      final dynamic itemsData = pageData["items"];

      final List<_NoteBlockData> pageBlocks = [];

      if (itemsData is List) {
        for (final item in itemsData) {
          if (item is! Map) {
            continue;
          }

          final String id =
              item["id"]?.toString() ?? "";

          if (id.isEmpty) {
            continue;
          }

          final originalBlock =
              _findBlockById(id);

          if (originalBlock == null) {
            continue;
          }

          final Map<String, dynamic> savedProperties =
              Map<String, dynamic>.from(item);

          final block = _NoteBlockData(
            id: originalBlock.id,
            type: originalBlock.type,
            value: originalBlock.value,
            layoutData: savedProperties,
          );

          pageBlocks.add(block);
          usedIds.add(id);
        }
      }

      loadedPages.add(pageBlocks);
    }

    // Add blocks that are not present in saved layout.
    for (final block in allBlocks) {
      if (!usedIds.contains(block.id)) {
        if (loadedPages.isEmpty) {
          loadedPages.add([]);
        }

        loadedPages.last.add(block);
      }
    }

    if (loadedPages.isEmpty) {
      _createDefaultPages();
    } else {
      pages = loadedPages;
    }

    if (currentPage >= pages.length) {
      currentPage =
          pages.isEmpty ? 0 : pages.length - 1;
    }
  }

  _NoteBlockData? _findBlockById(
    String id,
  ) {
    for (final block in allBlocks) {
      if (block.id == id) {
        return block;
      }
    }

    return null;
  }

  // ============================================================
  // DEFAULT PAGES
  // ============================================================

  void _createDefaultPages() {
    pages.clear();

    if (allBlocks.isEmpty) {
      return;
    }

    // Increased page size.
    const double estimatedPageHeight = 1050;

    List<_NoteBlockData> currentPage = [];

    double currentHeight = 0;

    for (final block in allBlocks) {
      final double blockHeight =
          _estimateBlockHeight(block);

      if (currentPage.isNotEmpty &&
          currentHeight + blockHeight >
              estimatedPageHeight) {
        pages.add(currentPage);

        currentPage = [];
        currentHeight = 0;
      }

      currentPage.add(block);
      currentHeight += blockHeight;
    }

    if (currentPage.isNotEmpty) {
      pages.add(currentPage);
    }
  }

  double _estimateBlockHeight(
    _NoteBlockData block,
  ) {
    switch (block.type) {
      case "heading":
        return 70;

      case "subtitle":
        return 80;

      case "content":
        final int length = block.value.length;

        if (length > 500) {
          return 300;
        }

        if (length > 250) {
          return 220;
        }

        if (length > 100) {
          return 160;
        }

        return 100;

      case "image":
        return 250;

      default:
        return 100;
    }
  }

  // ============================================================
  // SAVE LAYOUT
  // ============================================================

  Future<void> _saveLayout() async {
    if (isSaving) {
      return;
    }

    final int? noteId = int.tryParse(
      widget.note["id"]?.toString() ?? "",
    );

    if (noteId == null) {
      _showMessage("Note ID not found");
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      final Map<String, dynamic> layout = {
        "version": 1,
        "pages": List.generate(
          pages.length,
          (pageIndex) {
            return {
              "page": pageIndex + 1,
              "items": List.generate(
                pages[pageIndex].length,
                (itemIndex) {
                  final block =
                      pages[pageIndex][itemIndex];

                  final Map<String, dynamic> item =
                      Map<String, dynamic>.from(
                    block.layoutData,
                  );

                  item["id"] = block.id;
                  item["type"] = block.type;
                  item["order"] = itemIndex + 1;

                  return item;
                },
              ),
            };
          },
        ),
      };

      debugPrint(
        "========== SAVING LAYOUT ==========",
      );

      debugPrint(
        jsonEncode(layout),
      );

      final response =
          await ApiServices().updateNotesLayoutAPI(
        notesId: noteId,
        layout: layout,
      );

      if (!mounted) return;

      widget.note["layout"] = layout;

      setState(() {
        isCustomizeMode = false;
        isSaving = false;
      });

      _showMessage(
        response["message"]?.toString() ??
            "Layout saved successfully",
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      _showMessage(
        "Layout save nahi hua: $e",
      );
    }
  }

  // ============================================================
  // REORDER WITHIN SAME PAGE
  // ============================================================

  void _reorderBlock(
    int pageIndex,
    int oldIndex,
    int newIndex,
  ) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    if (oldIndex < 0 ||
        oldIndex >= pages[pageIndex].length) {
      return;
    }

    if (newIndex < 0 ||
        newIndex > pages[pageIndex].length) {
      return;
    }

    setState(() {
      final block =
          pages[pageIndex].removeAt(oldIndex);

      pages[pageIndex].insert(
        newIndex,
        block,
      );
    });
  }

  // ============================================================
  // MOVE BLOCK TO ANOTHER PAGE
  // ============================================================

  void _moveBlockToPage({
    required int fromPage,
    required int blockIndex,
    required int toPage,
  }) {
    if (fromPage < 0 ||
        fromPage >= pages.length) {
      return;
    }

    if (toPage < 0 ||
        toPage >= pages.length) {
      return;
    }

    if (blockIndex < 0 ||
        blockIndex >= pages[fromPage].length) {
      return;
    }

    if (fromPage == toPage) {
      return;
    }

    final block =
        pages[fromPage][blockIndex];

    setState(() {
      pages[fromPage].removeAt(blockIndex);

      pages[toPage].add(block);

      currentPage = toPage;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      pageController.animateToPage(
        toPage,
        duration:
            const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });

    _showMessage(
      "${_getBlockTypeName(block.type)} moved to Page ${toPage + 1}",
    );
  }

  // ============================================================
  // MOVE TO PAGE DIALOG
  // ============================================================

  void _showMoveToPageDialog({
    required int currentPageIndex,
    required int blockIndex,
  }) {
    if (currentPageIndex < 0 ||
        currentPageIndex >= pages.length) {
      return;
    }

    if (blockIndex < 0 ||
        blockIndex >=
            pages[currentPageIndex].length) {
      return;
    }

    final block =
        pages[currentPageIndex][blockIndex];

    int selectedPage = currentPageIndex;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(
                    Icons.drive_file_move_outlined,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text("Move Block"),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    _getBlockTypeName(
                      block.type,
                    ),
                    style: TextStyle(
                      color: primaryTextColor,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _shortenText(
                      block.value,
                      80,
                    ),
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: selectedPage,
                    decoration:
                        const InputDecoration(
                      labelText: "Move to page",
                      border:
                          OutlineInputBorder(),
                    ),
                    items: List.generate(
                      pages.length,
                      (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            "Page ${index + 1}",
                          ),
                        );
                      },
                    ),
                    onChanged: (value) {
                      if (value == null) return;

                      setDialogState(() {
                        selectedPage = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton.icon(
                  onPressed:
                      selectedPage == currentPageIndex
                          ? null
                          : () {
                              Navigator.pop(
                                dialogContext,
                              );

                              _moveBlockToPage(
                                fromPage:
                                    currentPageIndex,
                                blockIndex:
                                    blockIndex,
                                toPage:
                                    selectedPage,
                              );
                            },
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 18,
                  ),
                  label: const Text("Move"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ============================================================
  // NEXT / PREVIOUS
  // ============================================================

  Future<void> _nextPage() async {
    if (currentPage >= pages.length - 1) {
      return;
    }

    await pageController.nextPage(
      duration:
          const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _previousPage() async {
    if (currentPage <= 0) {
      return;
    }

    await pageController.previousPage(
      duration:
          const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // ============================================================
  // GO TO PAGE
  // ============================================================

  Future<void> _goToPage(int pageNumber) async {
    if (pages.isEmpty || pageNumber < 1 || pageNumber > pages.length) {
      _showMessage('Page not found. Enter a page number from 1 to ${pages.length}.');
      return;
    }

    final int targetIndex = pageNumber - 1;

    if (targetIndex == currentPage) {
      _showMessage('You are already on Page $pageNumber.');
      return;
    }

    if (!pageController.hasClients) {
      _showMessage('Unable to open Page $pageNumber. Please try again.');
      return;
    }

    await pageController.animateToPage(
      targetIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );

    if (mounted) {
      _showMessage('Moved to Page $pageNumber.');
    }
  }

  Future<void> _showGoToPageDialog() async {
    if (pages.isEmpty) return;

    final int? selectedPage = await showDialog<int>(
      context: context,
      builder: (_) => _GoToPageDialog(totalPages: pages.length),
    );

    if (!mounted || selectedPage == null) return;
    await _goToPage(selectedPage);
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: backgroundColor,
        drawer: Drawerbar(onPageSelected: widget.onPageSelected),
        appBar: const Header(),
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: const Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: Drawerbar(onPageSelected: widget.onPageSelected),
      appBar: const Header(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Column(
        children: [
          _buildTopBar(),

          Expanded(
            child: pages.isEmpty
                ? _buildEmptyState()
                : PageView.builder(
                    controller:
                        pageController,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder:
                        (context, pageIndex) {
                      return isCustomizeMode
                          ? _buildCustomizePage(
                              pageIndex,
                            )
                          : _buildNormalPage(
                              pageIndex,
                            );
                    },
                  ),
          ),

          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavBar(
      currentIndex: 2,
      onTap: (index) {
        // ViewNotes is a pushed route. Close it before switching
        // the tab on RootPage, so the selected tab stays visible.
        Navigator.of(context).pop();
        widget.onPageSelected?.call(index);
      },
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    final title =
        widget.note["title"]?.toString() ??
            "Note";

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: paperColor,
        border: Border(
          bottom: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 19,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isCustomizeMode
                      ? "Customize layout"
                      : "View note",
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          if (isCustomizeMode)
            ..._buildCustomizeActions()
          else
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  isCustomizeMode = true;
                });
              },
              icon: const Icon(
                Icons.tune,
                size: 18,
              ),
              label:
                  const Text("Customize"),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildCustomizeActions() {
    return [
      TextButton.icon(
        onPressed:
            isSaving
                ? null
                : () {
                    _loadSavedLayout();

                    setState(() {
                      isCustomizeMode = false;
                    });
                  },
        icon: const Icon(
          Icons.close,
          size: 18,
        ),
        label: const Text("Cancel"),
      ),

      const SizedBox(width: 3),

      ElevatedButton.icon(
        onPressed:
            isSaving ? null : _saveLayout,
        icon: isSaving
            ? const SizedBox(
                width: 16,
                height: 16,
                child:
                    CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(
                Icons.save_outlined,
                size: 18,
              ),
        label: Text(
          isSaving ? "Saving" : "Save",
        ),
      ),
    ];
  }

  // ============================================================
  // NORMAL PAGE
  // ============================================================

  Widget _buildNormalPage(
    int pageIndex,
  ) {
    final pageBlocks = pages[pageIndex];

    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.all(14),
        child: Center(
          child: Container(
            width: double.infinity,
            constraints:
                const BoxConstraints(
              maxWidth: 850,
            ),
            padding:
                const EdgeInsets.fromLTRB(
              28,
              30,
              28,
              40,
            ),
            decoration: BoxDecoration(
              color: paperColor,
              borderRadius:
                  BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(
                    isDark ? 0.25 : 0.07,
                  ),
                  blurRadius: 12,
                  offset:
                      const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                if (pageBlocks.isEmpty)
                  _buildEmptyPage(),

                for (final block
                    in pageBlocks)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child:
                        _buildBlock(block),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CUSTOMIZE PAGE
  // ============================================================

  Widget _buildCustomizePage(
    int pageIndex,
  ) {
    final pageBlocks = pages[pageIndex];

    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.all(14),
        child: Center(
          child: Container(
            width: double.infinity,
            constraints:
                const BoxConstraints(
              maxWidth: 850,
            ),
            decoration: BoxDecoration(
              color: paperColor,
              borderRadius:
                  BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(
                    isDark ? 0.25 : 0.07,
                  ),
                  blurRadius: 12,
                  offset:
                      const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildCustomizePageHeader(
                  pageIndex,
                ),

                if (pageBlocks.isEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.all(
                      30,
                    ),
                    child:
                        _buildEmptyPage(),
                  )
                else
                  ReorderableListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.fromLTRB(
                      18,
                      8,
                      18,
                      24,
                    ),
                    buildDefaultDragHandles:
                        false,
                    itemCount:
                        pageBlocks.length,
                    onReorder:
                        (oldIndex,
                            newIndex) {
                      _reorderBlock(
                        pageIndex,
                        oldIndex,
                        newIndex,
                      );
                    },
                    itemBuilder:
                        (context, index) {
                      final block =
                          pageBlocks[index];

                      return _buildCustomizeBlock(
                        key: ValueKey(
                          block.id,
                        ),
                        block: block,
                        pageIndex: pageIndex,
                        blockIndex: index,
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CUSTOMIZE PAGE HEADER
  // ============================================================

  Widget _buildCustomizePageHeader(
    int pageIndex,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF292844)
            : const Color(0xFFF0F0FF),
        borderRadius:
            const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.layers_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Customize Page",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontWeight:
                        FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Drag blocks up/down or move them to another page",
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          SizedBox(
            width: 105,
            child: DropdownButtonFormField<int>(
              value: pageIndex,
              isDense: true,
              decoration:
                  const InputDecoration(
                labelText: "Page",
                border:
                    OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
              ),
              items: List.generate(
                pages.length,
                (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                      "${index + 1}",
                    ),
                  );
                },
              ),
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                pageController.animateToPage(
                  value,
                  duration:
                      const Duration(
                    milliseconds: 300,
                  ),
                  curve:
                      Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CUSTOMIZE BLOCK
  // ============================================================

  Widget _buildCustomizeBlock({
    required Key key,
    required _NoteBlockData block,
    required int pageIndex,
    required int blockIndex,
  }) {
    return Container(
      key: key,
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      padding:
          const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(
          color: borderColor,
        ),
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration:
                          BoxDecoration(
                        color: isDark
                            ? Colors.white10
                            : const Color(
                                0xFFEAEAFF,
                              ),
                        borderRadius:
                            BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: Text(
                        _getBlockTypeName(
                          block.type,
                        ),
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 11,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "Page ${pageIndex + 1}",
                      style: TextStyle(
                        color:
                            secondaryTextColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                _buildBlock(block),

                const SizedBox(height: 10),

                Align(
                  alignment:
                      Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showMoveToPageDialog(
                        currentPageIndex:
                            pageIndex,
                        blockIndex:
                            blockIndex,
                      );
                    },
                    icon: const Icon(
                      Icons
                          .drive_file_move_outlined,
                      size: 17,
                    ),
                    label:
                        const Text(
                      "Move to Page",
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          ReorderableDragStartListener(
            index: blockIndex,
            child: Container(
              padding:
                  const EdgeInsets.all(9),
              decoration:
                  BoxDecoration(
                color: isDark
                    ? Colors.white10
                    : Colors.black
                        .withOpacity(0.04),
                borderRadius:
                    BorderRadius.circular(9),
              ),
              child: Icon(
                Icons.drag_indicator,
                color:
                    secondaryTextColor,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BLOCK
  // ============================================================

  Widget _buildBlock(
    _NoteBlockData block,
  ) {
    switch (block.type) {
      case "heading":
        return Text(
          block.value,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 24,
            fontWeight:
                FontWeight.w700,
            height: 1.25,
          ),
        );

      case "subtitle":
        return Text(
          block.value,
          style: TextStyle(
            color: secondaryTextColor,
            fontSize: 18,
            fontWeight:
                FontWeight.w500,
            height: 1.2,
          ),
        );

      case "content":
        return Text(
          block.value,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 15,
            height: 1.2,
          ),
        );

      case "image":
        return _buildImage(block);

      default:
        return Text(
          block.value,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 15,
          ),
        );
    }
  }

  // ============================================================
  // IMAGE
  // ============================================================

  Widget _buildImage(
    _NoteBlockData block,
  ) {
    if (block.value.trim().isEmpty) {
      return _buildImagePlaceholder();
    }

    final double width =
        _getDoubleLayoutValue(
      block,
      "width",
      300,
    );

    final double height =
        _getDoubleLayoutValue(
      block,
      "height",
      210,
    );

    final alignment =
        _getImageAlignment(block);

    return Align(
      alignment: alignment,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(12),
        child: Image.network(
          block.value,
          width: width,
          height: height,
          fit: BoxFit.contain,
          errorBuilder:
              (context, error, stackTrace) {
            return _buildImagePlaceholder(
              width: width,
              height: height,
            );
          },
          loadingBuilder:
              (
            context,
            child,
            loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child;
            }

            return SizedBox(
              width: width,
              height: height,
              child: const Center(
                child:
                    CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder({
    double width = 320,
    double height = 220,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade800
            : Colors.grey.shade100,
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          Icons
              .image_not_supported_outlined,
          size: 45,
          color: isDark
              ? Colors.white38
              : Colors.black26,
        ),
      ),
    );
  }

  double _getDoubleLayoutValue(
    _NoteBlockData block,
    String key,
    double defaultValue,
  ) {
    final value =
        block.layoutData[key];

    if (value is num) {
      return value.toDouble();
    }

    if (value != null) {
      return double.tryParse(
            value.toString(),
          ) ??
          defaultValue;
    }

    return defaultValue;
  }

  Alignment _getImageAlignment(
    _NoteBlockData block,
  ) {
    final String alignment =
        block.layoutData["alignment"]
                ?.toString()
                .toLowerCase() ??
            "center";

    switch (alignment) {
      case "left":
        return Alignment.centerLeft;

      case "right":
        return Alignment.centerRight;

      case "center":
      default:
        return Alignment.center;
    }
  }

  // ============================================================
  // BOTTOM BAR
  // ============================================================

  Widget _buildBottomBar() {
    final bool hasPages = pages.isNotEmpty;
    final bool canGoPrevious = hasPages && currentPage > 0;
    final bool canGoNext = hasPages && currentPage < pages.length - 1;

    return Container(
      height: 44,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: paperColor,
        border: Border(
          top: BorderSide(color: borderColor, width: 0.7),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            tooltip: 'Previous page',
            onPressed: canGoPrevious ? _previousPage : null,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 34, height: 34),
            icon: const Icon(Icons.chevron_left_rounded, size: 27),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: hasPages ? _showGoToPageDialog : null,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                constraints: const BoxConstraints(minHeight: 30),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF292844)
                      : const Color(0xFFEDEBFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.white12 : const Color(0xFFDCD8FF),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      hasPages ? '${currentPage + 1} / ${pages.length}' : '0 / 0',
                      style: TextStyle(
                        color: primaryTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: secondaryTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Next page',
            onPressed: canGoNext ? _nextPage : null,
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 34, height: 34),
            icon: const Icon(Icons.chevron_right_rounded, size: 27),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY PAGE
  // ============================================================

  Widget _buildEmptyPage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons
              .insert_drive_file_outlined,
          size: 48,
          color: secondaryTextColor,
        ),
        const SizedBox(height: 10),
        Text(
          "This page is empty",
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 15,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 60,
            color: secondaryTextColor,
          ),
          const SizedBox(height: 12),
          Text(
            "No content found",
            style: TextStyle(
              color: primaryTextColor,
              fontSize: 18,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  String _getBlockTypeName(
    String type,
  ) {
    switch (type) {
      case "heading":
        return "Heading";

      case "subtitle":
        return "Subtitle";

      case "content":
        return "Paragraph";

      case "image":
        return "Image";

      default:
        return "Block";
    }
  }

  String _shortenText(
    String text,
    int maxLength,
  ) {
    final clean = text.trim();

    if (clean.length <= maxLength) {
      return clean.isEmpty
          ? "No content"
          : clean;
    }

    return "${clean.substring(0, maxLength)}...";
  }
}

// ============================================================
// GO TO PAGE DIALOG
// The controller belongs to this dialog State and is disposed only
// when Flutter actually removes the dialog widget from the tree.
// ============================================================

class _GoToPageDialog extends StatefulWidget {
  final int totalPages;

  const _GoToPageDialog({required this.totalPages});

  @override
  State<_GoToPageDialog> createState() => _GoToPageDialogState();
}

class _GoToPageDialogState extends State<_GoToPageDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _validationError;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final raw = _controller.text.trim();
    final pageNumber = int.tryParse(raw);

    if (raw.isEmpty || pageNumber == null) {
      setState(() => _validationError = 'Please enter a page number.');
      return;
    }

    if (pageNumber < 1 || pageNumber > widget.totalPages) {
      setState(() {
        _validationError =
            'Page not found. Enter a number from 1 to ${widget.totalPages}.';
      });
      return;
    }

    Navigator.of(context).pop(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.find_in_page_outlined, color: _ViewNotesState.primaryColor),
          SizedBox(width: 10),
          Text('Go to page'),
        ],
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.go,
        onChanged: (_) {
          if (_validationError != null) {
            setState(() => _validationError = null);
          }
        },
        onSubmitted: (_) => _submit(),
        decoration: InputDecoration(
          labelText: 'Page number',
          hintText: '1 - ${widget.totalPages}',
          errorText: _validationError,
          border: const OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Go'),
        ),
      ],
    );
  }
}

// ============================================================
// NOTE BLOCK MODEL
// ============================================================

class _NoteBlockData {
  final String id;
  final String type;
  final String value;

  final Map<String, dynamic> layoutData;

  _NoteBlockData({
    required this.id,
    required this.type,
    required this.value,
    Map<String, dynamic>? layoutData,
  }) : layoutData = layoutData ?? {};
}

