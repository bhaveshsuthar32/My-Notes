// import 'package:flutter/material.dart';
// import 'package:my_notebook/theme/theme_provider.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';
// import 'package:provider/provider.dart';

// class ViewNotes extends StatefulWidget {
//   final Map<String, dynamic> note;

//   const ViewNotes({
//     super.key,
//     required this.note,
//   });

//   @override
//   State<ViewNotes> createState() => _ViewNotesState();
// }

// class _ViewNotesState extends State<ViewNotes> {
//   final PageController pageController = PageController();

//   List<_NotePage> pages = [];

//   int currentPage = 0;

//   bool get isDark =>
//       Provider.of<ThemeProvider>(context).isDarkMode;

//   Color get backgroundColor =>
//       isDark
//           ? const Color(0xFF121212)
//           : const Color(0xFFF5F5F5);

//   Color get paperColor =>
//       isDark
//           ? const Color(0xFF1E1E1E)
//           : Colors.white;

//   Color get primaryTextColor =>
//       isDark
//           ? Colors.white
//           : const Color(0xFF1F2937);

//   Color get secondaryTextColor =>
//       isDark
//           ? Colors.white70
//           : const Color(0xFF4B5563);

//   @override
//   void initState() {
//     super.initState();

//     pages = _createPages();
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }

//   // ============================================================
//   // CREATE PAGES
//   // ============================================================

//   List<_NotePage> _createPages() {
//     final List<_NotePage> result = [];

//     final List<dynamic> subtitleList =
//         _asList(widget.note["subtitle"]);

//     final List<dynamic> contentList =
//         _asList(widget.note["content"]);

//     final List<dynamic> imageList =
//         _asList(widget.note["images"]);

//     final List<dynamic> orderList =
//         _asList(widget.note["contentOrder"]);

//     // If contentOrder exists, use it.
//     if (orderList.isNotEmpty) {
//       for (final item in orderList) {
//         if (item is! Map) {
//           continue;
//         }

//         final String id =
//             item["id"]?.toString() ?? "";

//         final String type =
//             item["type"]?.toString() ?? "";

//         final dynamic block =
//             _findBlock(
//           id: id,
//           type: type,
//           subtitles: subtitleList,
//           contents: contentList,
//           images: imageList,
//         );

//         if (block == null) {
//           continue;
//         }

//         if (type == "image") {
//           final String? imageUrl =
//               _getImageUrl(block);

//           if (imageUrl != null) {
//             result.add(
//               _NotePage(
//                 type: "image",
//                 value: imageUrl,
//               ),
//             );
//           }
//         } else {
//           final String text =
//               _getTextValue(block);

//           if (text.isNotEmpty) {
//             result.addAll(
//               _splitTextBlock(
//                 text: text,
//                 type: type,
//               ),
//             );
//           }
//         }
//       }
//     } else {
//       // Fallback if contentOrder is empty.

//       for (final item in subtitleList) {
//         final String text = _getTextValue(item);

//         if (text.isNotEmpty) {
//           final String type =
//               item is Map
//                   ? item["type"]?.toString() ?? "subtitle"
//                   : "subtitle";

//           result.addAll(
//             _splitTextBlock(
//               text: text,
//               type: type,
//             ),
//           );
//         }
//       }

//       for (final item in contentList) {
//         final String text = _getTextValue(item);

//         if (text.isNotEmpty) {
//           result.addAll(
//             _splitTextBlock(
//               text: text,
//               type: "content",
//             ),
//           );
//         }
//       }

//       for (final item in imageList) {
//         final String? imageUrl =
//             _getImageUrl(item);

//         if (imageUrl != null) {
//           result.add(
//             _NotePage(
//               type: "image",
//               value: imageUrl,
//             ),
//           );
//         }
//       }
//     }

//     if (result.isEmpty) {
//       result.add(
//         const _NotePage(
//           type: "empty",
//           value: "",
//         ),
//       );
//     }

//     return result;
//   }

//   // ============================================================
//   // LIST HELPER
//   // ============================================================

//   List<dynamic> _asList(dynamic value) {
//     if (value is List) {
//       return value;
//     }

//     return [];
//   }

//   // ============================================================
//   // FIND BLOCK
//   // ============================================================

//   dynamic _findBlock({
//     required String id,
//     required String type,
//     required List<dynamic> subtitles,
//     required List<dynamic> contents,
//     required List<dynamic> images,
//   }) {
//     if (type == "heading" || type == "subtitle") {
//       for (final item in subtitles) {
//         if (item is Map &&
//             item["id"]?.toString() == id) {
//           return item;
//         }
//       }
//     }

//     if (type == "content") {
//       for (final item in contents) {
//         if (item is Map &&
//             item["id"]?.toString() == id) {
//           return item;
//         }
//       }
//     }

//     if (type == "image") {
//       for (final item in images) {
//         if (item is Map &&
//             item["id"]?.toString() == id) {
//           return item;
//         }
//       }
//     }

//     return null;
//   }

//   // ============================================================
//   // GET TEXT
//   // ============================================================

//   String _getTextValue(dynamic item) {
//     if (item is Map) {
//       return item["value"]?.toString().trim() ?? "";
//     }

//     return item?.toString().trim() ?? "";
//   }

//   // ============================================================
//   // GET IMAGE URL
//   // ============================================================

//   String? _getImageUrl(dynamic item) {
//     if (item is Map) {
//       final value = item["value"];

//       if (value != null &&
//           value.toString().trim().isNotEmpty) {
//         return value.toString();
//       }
//     }

//     return null;
//   }

//   // ============================================================
//   // SPLIT LONG TEXT
//   // ============================================================

//   List<_NotePage> _splitTextBlock({
//     required String text,
//     required String type,
//   }) {
//     final List<_NotePage> result = [];

//     // Approximate characters that can fit comfortably
//     // on one book page.
//     const int maxCharacters = 850;

//     if (text.length <= maxCharacters) {
//       result.add(
//         _NotePage(
//           type: type,
//           value: text,
//         ),
//       );

//       return result;
//     }

//     String remaining = text;

//     while (remaining.length > maxCharacters) {
//       int splitIndex =
//           remaining.lastIndexOf(
//         " ",
//         maxCharacters,
//       );

//       if (splitIndex <= 0) {
//         splitIndex = maxCharacters;
//       }

//       final String part =
//           remaining.substring(0, splitIndex).trim();

//       result.add(
//         _NotePage(
//           type: type,
//           value: part,
//         ),
//       );

//       remaining =
//           remaining.substring(splitIndex).trim();
//     }

//     if (remaining.isNotEmpty) {
//       result.add(
//         _NotePage(
//           type: type,
//           value: remaining,
//         ),
//       );
//     }

//     return result;
//   }

//   // ============================================================
//   // BUILD
//   // ============================================================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,

//       appBar: Header(),

//       drawer: Drawerbar(),

//       body: Column(
//         children: [
//           // ================= TOP BAR =================

//           _buildTopBar(),

//           // ================= BOOK =================

//           Expanded(
//             child: PageView.builder(
//               controller: pageController,
//               itemCount: pages.length,

//               onPageChanged: (index) {
//                 setState(() {
//                   currentPage = index;
//                 });
//               },

//               itemBuilder: (context, index) {
//                 return _buildBookPage(
//                   pages[index],
//                 );
//               },
//             ),
//           ),

//           // ================= BOTTOM BAR =================

//           _buildBottomBar(),
//         ],
//       ),
//     );
//   }

//   // ============================================================
//   // TOP BAR
//   // ============================================================

//   Widget _buildTopBar() {
//     final String title =
//         widget.note["title"]?.toString() ??
//             "Untitled Note";

//     return Container(
//       padding: const EdgeInsets.fromLTRB(
//         18,
//         14,
//         18,
//         14,
//       ),

//       decoration: BoxDecoration(
//         color: paperColor,

//         border: Border(
//           bottom: BorderSide(
//             color: isDark
//                 ? Colors.grey.shade800
//                 : Colors.grey.shade200,
//           ),
//         ),
//       ),

//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,

//               style: TextStyle(
//                 color: primaryTextColor,
//                 fontSize: 19,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),

//           const SizedBox(width: 10),

//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10,
//               vertical: 6,
//             ),

//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.white.withOpacity(0.08)
//                   : Colors.black.withOpacity(0.05),

//               borderRadius:
//                   BorderRadius.circular(20),
//             ),

//             child: Text(
//               "${currentPage + 1}/${pages.length}",

//               style: TextStyle(
//                 color: secondaryTextColor,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ============================================================
//   // BOOK PAGE
//   // ============================================================

//   Widget _buildBookPage(_NotePage page) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(
//         18,
//         18,
//         18,
//         12,
//       ),

//       child: Container(
//         width: double.infinity,

//         padding: const EdgeInsets.all(22),

//         decoration: BoxDecoration(
//           color: paperColor,

//           borderRadius:
//               BorderRadius.circular(16),

//           border: Border.all(
//             color: isDark
//                 ? Colors.grey.shade800
//                 : Colors.grey.shade200,
//           ),

//           boxShadow: [
//             BoxShadow(
//               color: isDark
//                   ? Colors.black.withOpacity(0.25)
//                   : Colors.black.withOpacity(0.06),

//               blurRadius: 14,

//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),

//         child: _buildPageContent(page),
//       ),
//     );
//   }

//   // ============================================================
//   // PAGE CONTENT
//   // ============================================================

//   Widget _buildPageContent(_NotePage page) {
//     if (page.type == "image") {
//       return _buildImagePage(
//         page.value,
//       );
//     }

//     if (page.type == "heading") {
//       return SingleChildScrollView(
//         child: Text(
//           page.value,

//           style: TextStyle(
//             color: primaryTextColor,
//             fontSize: 28,
//             fontWeight: FontWeight.w800,
//             height: 1.35,
//           ),
//         ),
//       );
//     }

//     if (page.type == "subtitle") {
//       return SingleChildScrollView(
//         child: Text(
//           page.value,

//           style: TextStyle(
//             color: primaryTextColor,
//             fontSize: 21,
//             fontWeight: FontWeight.w600,
//             height: 1.5,
//           ),
//         ),
//       );
//     }

//     if (page.type == "content") {
//       return SingleChildScrollView(
//         child: Text(
//           page.value,

//           style: TextStyle(
//             color: primaryTextColor,
//             fontSize: 17,
//             height: 1.75,
//           ),
//         ),
//       );
//     }

//     return Center(
//       child: Text(
//         "No content available",
//         style: TextStyle(
//           color: secondaryTextColor,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // IMAGE PAGE
//   // ============================================================

//   Widget _buildImagePage(String imageUrl) {
//     return Center(
//       child: InteractiveViewer(
//         minScale: 1,
//         maxScale: 4,

//         child: ClipRRect(
//           borderRadius:
//               BorderRadius.circular(12),

//           child: Image.network(
//             imageUrl,

//             width: double.infinity,

//             fit: BoxFit.contain,

//             loadingBuilder:
//                 (context, child, progress) {
//               if (progress == null) {
//                 return child;
//               }

//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             },

//             errorBuilder:
//                 (context, error, stackTrace) {
//               return Container(
//                 height: 250,

//                 decoration: BoxDecoration(
//                   color: isDark
//                       ? Colors.grey.shade800
//                       : Colors.grey.shade100,

//                   borderRadius:
//                       BorderRadius.circular(12),
//                 ),

//                 child: Center(
//                   child: Icon(
//                     Icons
//                         .image_not_supported_outlined,

//                     size: 55,

//                     color: isDark
//                         ? Colors.white38
//                         : Colors.black26,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   // ============================================================
//   // BOTTOM BAR
//   // ============================================================

//   Widget _buildBottomBar() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(
//         18,
//         8,
//         18,
//         14,
//       ),

//       decoration: BoxDecoration(
//         color: paperColor,

//         border: Border(
//           top: BorderSide(
//             color: isDark
//                 ? Colors.grey.shade800
//                 : Colors.grey.shade200,
//           ),
//         ),
//       ),

//       child: Row(
//         mainAxisAlignment:
//             MainAxisAlignment.center,

//         children: [
//           IconButton(
//             onPressed: currentPage > 0
//                 ? () {
//                     pageController.previousPage(
//                       duration:
//                           const Duration(
//                         milliseconds: 300,
//                       ),
//                       curve:
//                           Curves.easeInOut,
//                     );
//                   }
//                 : null,

//             icon: const Icon(
//               Icons.chevron_left,
//               size: 30,
//             ),
//           ),

//           const SizedBox(width: 12),

//           Text(
//             "Page ${currentPage + 1} of ${pages.length}",

//             style: TextStyle(
//               color: secondaryTextColor,
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//             ),
//           ),

//           const SizedBox(width: 12),

//           IconButton(
//             onPressed:
//                 currentPage < pages.length - 1
//                     ? () {
//                         pageController.nextPage(
//                           duration:
//                               const Duration(
//                             milliseconds: 300,
//                           ),
//                           curve:
//                               Curves.easeInOut,
//                         );
//                       }
//                     : null,

//             icon: const Icon(
//               Icons.chevron_right,
//               size: 30,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ================================================================
// // NOTE PAGE MODEL
// // ================================================================

// class _NotePage {
//   final String type;
//   final String value;

//   const _NotePage({
//     required this.type,
//     required this.value,
//   });
// }



// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:my_notebook/theme/theme_provider.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';
// import 'package:provider/provider.dart';

// class ViewNotes extends StatefulWidget {
//   final Map<String, dynamic> note;

//   const ViewNotes({
//     super.key,
//     required this.note,
//   });

//   @override
//   State<ViewNotes> createState() => _ViewNotesState();
// }

// class _ViewNotesState extends State<ViewNotes> {
//   final PageController pageController = PageController();

//   List<_NoteBlockData> allBlocks = [];
//   List<List<_NoteBlockData>> pages = [];

//   int currentPage = 0;

//   bool get isDark =>
//       Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

//   Color get backgroundColor =>
//       isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);

//   Color get paperColor =>
//       isDark ? const Color(0xFF1E1E1E) : Colors.white;

//   Color get primaryTextColor =>
//       isDark ? Colors.white : const Color(0xFF1F2937);

//   Color get secondaryTextColor =>
//       isDark ? Colors.white70 : const Color(0xFF4B5563);

//   @override
//   void initState() {
//     super.initState();
//     _prepareNote();
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }

//   // Prepare note
//   void _prepareNote() {
//     allBlocks = _createBlocks();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!mounted) return;

//       _createPages();

//       setState(() {});
//     });
//   }

//   // Convert data to list
//   List<dynamic> _asList(dynamic data) {
//     if (data == null) return [];

//     if (data is List) {
//       return data;
//     }

//     if (data is String) {
//       try {
//         final decoded = jsonDecode(data);

//         if (decoded is List) {
//           return decoded;
//         }
//       } catch (_) {
//         return [];
//       }
//     }

//     return [];
//   }

//   // Create ordered blocks
//   List<_NoteBlockData> _createBlocks() {
//     final List<dynamic> subtitles =
//         _asList(widget.note["subtitle"]);

//     final List<dynamic> contents =
//         _asList(widget.note["content"]);

//     final List<dynamic> images =
//         _asList(widget.note["images"]);

//     final List<dynamic> contentOrder =
//         _asList(widget.note["contentOrder"]);

//     final List<_NoteBlockData> result = [];

//     // Use content order
//     if (contentOrder.isNotEmpty) {
//       for (final orderItem in contentOrder) {
//         if (orderItem is! Map) continue;

//         final String id =
//             orderItem["id"]?.toString() ?? "";

//         final String type =
//             orderItem["type"]?.toString().toLowerCase() ?? "";

//         if (id.isEmpty) continue;

//         // Heading / subtitle
//         if (type == "heading" || type == "subtitle") {
//           final item = _findById(subtitles, id);

//           if (item != null) {
//             result.add(
//               _NoteBlockData(
//                 id: id,
//                 type: type,
//                 value: _getValue(item),
//               ),
//             );
//           }
//         }

//         // Paragraph / content
//         else if (type == "content" ||
//             type == "paragraph") {
//           final item = _findById(contents, id);

//           if (item != null) {
//             result.add(
//               _NoteBlockData(
//                 id: id,
//                 type: "content",
//                 value: _getValue(item),
//               ),
//             );
//           }
//         }

//         // Image
//         else if (type == "image") {
//           final item = _findById(images, id);

//           if (item != null) {
//             result.add(
//               _NoteBlockData(
//                 id: id,
//                 type: "image",
//                 value: _getValue(item),
//               ),
//             );
//           }
//         }
//       }
//     }

//     // Fallback
//     if (result.isEmpty) {
//       for (final item in subtitles) {
//         if (item is Map) {
//           final String type =
//               item["type"]?.toString().toLowerCase() ?? "subtitle";

//           result.add(
//             _NoteBlockData(
//               id: item["id"]?.toString() ?? "",
//               type: type,
//               value: _getValue(item),
//             ),
//           );
//         }
//       }

//       for (final item in contents) {
//         if (item is Map) {
//           result.add(
//             _NoteBlockData(
//               id: item["id"]?.toString() ?? "",
//               type: "content",
//               value: _getValue(item),
//             ),
//           );
//         }
//       }

//       for (final item in images) {
//         if (item is Map) {
//           result.add(
//             _NoteBlockData(
//               id: item["id"]?.toString() ?? "",
//               type: "image",
//               value: _getValue(item),
//             ),
//           );
//         }
//       }
//     }

//     return result;
//   }

//   // Find item
//   dynamic _findById(List<dynamic> list, String id) {
//     for (final item in list) {
//       if (item is Map) {
//         if (item["id"]?.toString() == id) {
//           return item;
//         }
//       }
//     }

//     return null;
//   }

//   // Get value
//   String _getValue(dynamic item) {
//     if (item is Map) {
//       return item["value"]?.toString() ?? "";
//     }

//     return item?.toString() ?? "";
//   }

//   // Create pages
//   void _createPages() {
//     pages.clear();

//     if (allBlocks.isEmpty) {
//       return;
//     }

//     final double screenHeight =
//         MediaQuery.of(context).size.height;

//     // Page height = approximately 2x mobile screen
//     final double pageHeight =
//         screenHeight * 2;

//     double usedHeight = 0;

//     List<_NoteBlockData> currentPage = [];

//     for (final block in allBlocks) {
//       final double blockHeight =
//           _estimateBlockHeight(block, pageHeight);

//       if (currentPage.isNotEmpty &&
//           usedHeight + blockHeight > pageHeight) {
//         pages.add(currentPage);

//         currentPage = [];
//         usedHeight = 0;
//       }

//       currentPage.add(block);
//       usedHeight += blockHeight;
//     }

//     if (currentPage.isNotEmpty) {
//       pages.add(currentPage);
//     }
//   }

//   // Estimate block height
//   double _estimateBlockHeight(
//     _NoteBlockData block,
//     double pageHeight,
//   ) {
//     if (block.type == "image") {
//       return 230;
//     }

//     final String text = block.value;

//     if (text.isEmpty) {
//       return 60;
//     }

//     final int characters =
//         text.length;

//     if (block.type == "heading") {
//       return 90 +
//           (characters / 35).ceil() * 30;
//     }

//     if (block.type == "subtitle") {
//       return 75 +
//           (characters / 45).ceil() * 25;
//     }

//     return 70 +
//         (characters / 55).ceil() * 25;
//   }

//   // Next page
//   void _nextPage() {
//     if (currentPage < pages.length - 1) {
//       pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   // Previous page
//   void _previousPage() {
//     if (currentPage > 0) {
//       pageController.previousPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: const Header(),
//       drawer: const Drawerbar(),
//       body: Column(
//         children: [
//           _buildTopBar(),
//           Expanded(
//             child: pages.isEmpty
//                 ? _buildEmptyState()
//                 : PageView.builder(
//                     controller: pageController,
//                     itemCount: pages.length,
//                     onPageChanged: (index) {
//                       setState(() {
//                         currentPage = index;
//                       });
//                     },
//                     itemBuilder: (context, index) {
//                       return _buildBookPage(
//                         pages[index],
//                       );
//                     },
//                   ),
//           ),
//           _buildBottomBar(),
//         ],
//       ),
//     );
//   }

//   // Top bar
//   Widget _buildTopBar() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 12,
//       ),
//       decoration: BoxDecoration(
//         color: paperColor,
//         border: Border(
//           bottom: BorderSide(
//             color: isDark
//                 ? Colors.white10
//                 : Colors.black12,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               widget.note["title"]?.toString() ??
//                   "Note",
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 color: primaryTextColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           if (pages.isNotEmpty)
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 5,
//               ),
//               decoration: BoxDecoration(
//                 color: isDark
//                     ? Colors.white10
//                     : Colors.black.withOpacity(0.05),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 "${currentPage + 1}/${pages.length}",
//                 style: TextStyle(
//                   color: secondaryTextColor,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   // Book page
//   Widget _buildBookPage(
//     List<_NoteBlockData> pageBlocks,
//   ) {
//     final double screenHeight =
//         MediaQuery.of(context).size.height;

//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 14,
//         vertical: 14,
//       ),
//       child: Container(
//         width: double.infinity,

//         // Double mobile screen height
//         constraints: BoxConstraints(
//           minHeight: screenHeight * 2,
//         ),

//         padding: const EdgeInsets.fromLTRB(
//           22,
//           28,
//           22,
//           40,
//         ),

//         decoration: BoxDecoration(
//           color: paperColor,
//           borderRadius: BorderRadius.circular(14),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(
//                 isDark ? 0.25 : 0.08,
//               ),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),

//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,
//           children: [
//             for (int i = 0;
//                 i < pageBlocks.length;
//                 i++) ...[
//               _buildBlock(pageBlocks[i]),

//               if (i != pageBlocks.length - 1)
//                 const SizedBox(height: 24),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   // Dynamic block
//   Widget _buildBlock(
//     _NoteBlockData block,
//   ) {
//     switch (block.type) {
//       case "heading":
//         return _buildHeading(block.value);

//       case "subtitle":
//         return _buildSubtitle(block.value);

//       case "content":
//       case "paragraph":
//         return _buildParagraph(block.value);

//       case "image":
//         return _buildImage(block.value);

//       default:
//         return _buildParagraph(block.value);
//     }
//   }

//   // Heading
//   Widget _buildHeading(String text) {
//     if (text.trim().isEmpty) {
//       return const SizedBox();
//     }

//     return Text(
//       text,
//       style: TextStyle(
//         color: primaryTextColor,
//         fontSize: 26,
//         fontWeight: FontWeight.bold,
//         height: 1.3,
//       ),
//     );
//   }

//   // Subtitle
//   Widget _buildSubtitle(String text) {
//     if (text.trim().isEmpty) {
//       return const SizedBox();
//     }

//     return Text(
//       text,
//       style: TextStyle(
//         color: secondaryTextColor,
//         fontSize: 19,
//         fontWeight: FontWeight.w600,
//         height: 1.5,
//       ),
//     );
//   }

//   // Paragraph
//   Widget _buildParagraph(String text) {
//     if (text.trim().isEmpty) {
//       return const SizedBox();
//     }

//     return Text(
//       text,
//       style: TextStyle(
//         color: primaryTextColor,
//         fontSize: 16,
//         height: 1.8,
//       ),
//     );
//   }

//   // Image
//   Widget _buildImage(String imageUrl) {
//     if (imageUrl.trim().isEmpty) {
//       return Container(
//         height: 160,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: isDark
//               ? Colors.white10
//               : Colors.black.withOpacity(0.04),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(
//           "Image not available",
//           style: TextStyle(
//             color: secondaryTextColor,
//           ),
//         ),
//       );
//     }

//     return Center(
//       child: Container(
//         width: 220,
//         height: 180,
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: isDark
//               ? const Color(0xFF292929)
//               : const Color(0xFFF8F8F8),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isDark
//                 ? Colors.white12
//                 : Colors.black12,
//           ),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.network(
//             imageUrl,
//             width: 200,
//             height: 160,
//             fit: BoxFit.contain,
//             loadingBuilder:
//                 (context, child, loadingProgress) {
//               if (loadingProgress == null) {
//                 return child;
//               }

//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//             errorBuilder:
//                 (context, error, stackTrace) {
//               return Center(
//                 child: Icon(
//                   Icons.broken_image_outlined,
//                   size: 40,
//                   color: secondaryTextColor,
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   // Empty state
//   Widget _buildEmptyState() {
//     return Center(
//       child: Text(
//         "No content available",
//         style: TextStyle(
//           color: secondaryTextColor,
//           fontSize: 15,
//         ),
//       ),
//     );
//   }

//   // Bottom bar
//   Widget _buildBottomBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 10,
//       ),
//       decoration: BoxDecoration(
//         color: paperColor,
//         border: Border(
//           top: BorderSide(
//             color: isDark
//                 ? Colors.white10
//                 : Colors.black12,
//           ),
//         ),
//       ),
//       child: SafeArea(
//         top: false,
//         child: Row(
//           mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               onPressed:
//                   currentPage > 0
//                       ? _previousPage
//                       : null,
//               icon: const Icon(
//                 Icons.chevron_left,
//                 size: 30,
//               ),
//               color: primaryTextColor,
//               disabledColor:
//                   secondaryTextColor.withOpacity(0.3),
//             ),

//             Text(
//               pages.isEmpty
//                   ? "Page 0 of 0"
//                   : "Page ${currentPage + 1} of ${pages.length}",
//               style: TextStyle(
//                 color: secondaryTextColor,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),

//             IconButton(
//               onPressed:
//                   currentPage < pages.length - 1
//                       ? _nextPage
//                       : null,
//               icon: const Icon(
//                 Icons.chevron_right,
//                 size: 30,
//               ),
//               color: primaryTextColor,
//               disabledColor:
//                   secondaryTextColor.withOpacity(0.3),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _NoteBlockData {
//   final String id;
//   final String type;
//   final String value;

//   _NoteBlockData({
//     required this.id,
//     required this.type,
//     required this.value,
//   });
// }












import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:my_notebook/service/api_service.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/theme/theme_provider.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';
import 'package:provider/provider.dart';

class ViewNotes extends StatefulWidget {
  final Map<String, dynamic> note;

  const ViewNotes({
    super.key,
    required this.note,
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

  bool get isDark =>
      Provider.of<ThemeProvider>(
        context,
        listen: false,
      ).isDarkMode;

  Color get backgroundColor =>
      isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF5F5F5);

  Color get paperColor =>
      isDark
          ? const Color(0xFF1E1E1E)
          : Colors.white;

  Color get primaryTextColor =>
      isDark
          ? Colors.white
          : const Color(0xFF1F2937);

  Color get secondaryTextColor =>
      isDark
          ? Colors.white70
          : const Color(0xFF4B5563);

  Color get borderColor =>
      isDark
          ? Colors.white12
          : Colors.grey.shade300;

  @override
  void initState() {
    super.initState();

    allBlocks = _createBlocks();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _loadSavedLayout();

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
        final dynamic decoded = jsonDecode(data);

        if (decoded is List) {
          return decoded;
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
        final dynamic decoded = jsonDecode(data);

        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } catch (_) {
        return null;
      }
    }

    return null;
  }

  // ============================================================
  // CREATE BLOCKS FROM NOTE DATA
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

    // ------------------------------------------------------------
    // Use contentOrder
    // ------------------------------------------------------------

    if (contentOrder.isNotEmpty) {
      for (final orderItem in contentOrder) {
        if (orderItem is! Map) {
          continue;
        }

        final String id =
            orderItem["id"]?.toString() ?? "";

        final String type =
            orderItem["type"]
                    ?.toString()
                    .toLowerCase() ??
                "";

        if (id.isEmpty) {
          continue;
        }

        // Heading / Subtitle
        if (type == "heading" ||
            type == "subtitle") {
          final dynamic item =
              _findById(subtitles, id);

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

        // Content
        if (type == "content") {
          final dynamic item =
              _findById(contents, id);

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

        // Image
        if (type == "image") {
          final dynamic item =
              _findById(images, id);

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
      }
    }

    // ------------------------------------------------------------
    // Fallback if contentOrder is empty
    // ------------------------------------------------------------

    if (result.isEmpty) {
      for (final item in subtitles) {
        if (item is! Map) {
          continue;
        }

        final String id =
            item["id"]?.toString() ?? "";

        final String type =
            item["type"]
                    ?.toString()
                    .toLowerCase() ??
                "subtitle";

        if (id.isEmpty) {
          continue;
        }

        result.add(
          _NoteBlockData(
            id: id,
            type: type,
            value: _getValue(item),
          ),
        );
      }

      for (final item in contents) {
        if (item is! Map) {
          continue;
        }

        final String id =
            item["id"]?.toString() ?? "";

        if (id.isEmpty) {
          continue;
        }

        result.add(
          _NoteBlockData(
            id: id,
            type: "content",
            value: _getValue(item),
          ),
        );
      }

      for (final item in images) {
        if (item is! Map) {
          continue;
        }

        final String id =
            item["id"]?.toString() ?? "";

        if (id.isEmpty) {
          continue;
        }

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
      return item["value"]?.toString() ?? "";
    }

    return item?.toString() ?? "";
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

    final dynamic pagesData =
        layout["pages"];

    if (pagesData is! List ||
        pagesData.isEmpty) {
      _createDefaultPages();
      return;
    }

    final List<List<_NoteBlockData>>
        loadedPages = [];

    final Set<String> usedIds = {};

    // ------------------------------------------------------------
    // Load saved pages
    // ------------------------------------------------------------

    for (final pageData in pagesData) {
      if (pageData is! Map) {
        continue;
      }

      final dynamic itemsData =
          pageData["items"];

      if (itemsData is! List) {
        continue;
      }

      final List<_NoteBlockData>
          pageBlocks = [];

      for (final item in itemsData) {
        if (item is! Map) {
          continue;
        }

        final String id =
            item["id"]?.toString() ?? "";

        if (id.isEmpty) {
          continue;
        }

        final _NoteBlockData? originalBlock =
            _findBlockById(id);

        if (originalBlock == null) {
          continue;
        }

        final Map<String, dynamic>
            savedProperties =
            Map<String, dynamic>.from(item);

        final _NoteBlockData block =
            _NoteBlockData(
          id: originalBlock.id,
          type: originalBlock.type,
          value: originalBlock.value,
          layoutData: savedProperties,
        );

        pageBlocks.add(block);
        usedIds.add(id);
      }

      if (pageBlocks.isNotEmpty) {
        loadedPages.add(pageBlocks);
      }
    }

    // ------------------------------------------------------------
    // Add new/missing blocks
    // ------------------------------------------------------------

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
  // DEFAULT PAGE CREATION
  // ============================================================

  void _createDefaultPages() {
    pages.clear();

    if (allBlocks.isEmpty) {
      return;
    }

    const double estimatedPageHeight = 850;

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
        final int length =
            block.value.length;

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
        return 230;

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

    final int? noteId =
        int.tryParse(
      widget.note["id"]?.toString() ?? "",
    );

    if (noteId == null) {
      _showMessage(
        "Note ID not found",
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      final Map<String, dynamic> layout =
          {
        "version": 1,
        "pages": List.generate(
          pages.length,
          (pageIndex) {
            return {
              "page": pageIndex + 1,
              "items": List.generate(
                pages[pageIndex].length,
                (itemIndex) {
                  final _NoteBlockData block =
                      pages[pageIndex][itemIndex];

                  final Map<String, dynamic>
                      item =
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

      final Map<String, dynamic> response =
          await ApiServices()
              .updateNotesLayoutAPI(
        notesId: noteId,
        layout: layout,
      );

      if (!mounted) {
        return;
      }

      // Update local note object also
      widget.note["layout"] = layout;

      setState(() {
        isCustomizeMode = false;
        isSaving = false;
      });

      _showMessage(
        response["message"]?.toString() ??
            "Layout saved successfully",
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        isSaving = false;
      });

      _showMessage(
        "Layout save nahi hua: $error",
      );
    }
  }

  // ============================================================
  // REORDER
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
      final _NoteBlockData block =
          pages[pageIndex].removeAt(
        oldIndex,
      );

      pages[pageIndex].insert(
        newIndex,
        block,
      );
    });
  }

  // ============================================================
  // PAGE NAVIGATION
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
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: const Drawerbar(),
      appBar: const Header(),

      body: Column(
        children: [
          _buildTopBar(),

          Expanded(
            child: pages.isEmpty
                ? _buildEmptyState()
                : PageView.builder(
                    controller: pageController,
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

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    final String title =
        widget.note["title"]
                ?.toString() ??
            "Note";

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
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
            child: Text(
              title,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 20,
                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: 10),

          if (isCustomizeMode) ...[
            TextButton.icon(
              onPressed:
                  isSaving
                      ? null
                      : () {
                          _loadSavedLayout();

                          setState(() {
                            isCustomizeMode =
                                false;
                          });
                        },
              icon: const Icon(
                Icons.close,
                size: 19,
              ),
              label:
                  const Text("Cancel"),
            ),

            const SizedBox(width: 4),

            ElevatedButton.icon(
              onPressed:
                  isSaving
                      ? null
                      : _saveLayout,
              icon: isSaving
                  ? const SizedBox(
                      width: 17,
                      height: 17,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.save_outlined,
                      size: 18,
                    ),
              label: Text(
                isSaving
                    ? "Saving..."
                    : "Save",
              ),
            ),
          ] else ...[
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
        ],
      ),
    );
  }

  // ============================================================
  // NORMAL PAGE
  // ============================================================

  Widget _buildNormalPage(
    int pageIndex,
  ) {
    final List<_NoteBlockData>
        pageBlocks =
        pages[pageIndex];

    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.all(18),
        child: Center(
          child: Container(
            width: double.infinity,
            constraints:
                const BoxConstraints(
              maxWidth: 850,
            ),
            padding:
                const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: paperColor,
              borderRadius:
                  BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withValues(
                    alpha: isDark
                        ? 0.25
                        : 0.08,
                  ),
                  blurRadius: 12,
                  offset:
                      const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .stretch,
              children: [
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
    final List<_NoteBlockData>
        pageBlocks =
        pages[pageIndex];

    return Container(
      color: backgroundColor,
      child: Center(
        child: Container(
          width: double.infinity,
          constraints:
              const BoxConstraints(
            maxWidth: 850,
          ),
          margin:
              const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: paperColor,
            borderRadius:
                BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(
                  alpha:
                      isDark ? 0.25 : 0.08,
                ),
                blurRadius: 12,
                offset:
                    const Offset(0, 4),
              ),
            ],
          ),
          child:
              ReorderableListView.builder(
            padding:
                const EdgeInsets.all(20),
            buildDefaultDragHandles:
                false,
            itemCount:
                pageBlocks.length,
            onReorder:
                (oldIndex, newIndex) {
              _reorderBlock(
                pageIndex,
                oldIndex,
                newIndex,
              );
            },
            itemBuilder:
                (context, index) {
              final _NoteBlockData block =
                  pageBlocks[index];

              return Container(
                key: ValueKey(
                  block.id,
                ),
                margin:
                    const EdgeInsets.only(
                  bottom: 14,
                ),
                padding:
                    const EdgeInsets.all(12),
                decoration:
                    BoxDecoration(
                  color: isDark
                      ? const Color(
                          0xFF252525,
                        )
                      : const Color(
                          0xFFF9FAFB,
                        ),
                  border: Border.all(
                    color: isDark
                        ? Colors.white24
                        : Colors.grey
                            .shade300,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Expanded(
                      child:
                          _buildBlock(
                        block,
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    ReorderableDragStartListener(
                      index: index,
                      child: Container(
                        padding:
                            const EdgeInsets
                                .all(8),
                        decoration:
                            BoxDecoration(
                          color: isDark
                              ? Colors.white10
                              : Colors.black
                                  .withValues(
                                  alpha: 0.04,
                                ),
                          borderRadius:
                              BorderRadius
                                  .circular(
                            8,
                          ),
                        ),
                        child: Icon(
                          Icons
                              .drag_indicator,
                          color:
                              secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
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
            fontSize: 26,
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
            fontSize: 19,
            fontWeight:
                FontWeight.w500,
            height: 1.4,
          ),
        );

      case "content":
        return Text(
          block.value,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 16,
            height: 1.8,
          ),
        );

      case "image":
        return _buildImage(block);

      default:
        return Text(
          block.value,
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 16,
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
          220,
        );

    final double height =
        _getDoubleLayoutValue(
          block,
          "height",
          180,
        );

    final Alignment alignment =
        _getImageAlignment(block);

    return Align(
      alignment: alignment,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(10),
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
            if (loadingProgress ==
                null) {
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
    double width = 220,
    double height = 180,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade800
            : Colors.grey.shade100,
        borderRadius:
            BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(
          Icons
              .image_not_supported_outlined,
          size: 40,
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
    final dynamic value =
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
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: paperColor,
        border: Border(
          top: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed:
                currentPage > 0
                    ? _previousPage
                    : null,
            icon: const Icon(
              Icons.chevron_left,
            ),
          ),

          const SizedBox(width: 10),

          Text(
            pages.isEmpty
                ? "0 / 0"
                : "${currentPage + 1} / ${pages.length}",
            style: TextStyle(
              color: primaryTextColor,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(width: 10),

          IconButton(
            onPressed:
                currentPage <
                        pages.length - 1
                    ? _nextPage
                    : null,
            icon: const Icon(
              Icons.chevron_right,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize:
            MainAxisSize.min,
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
}

// ============================================================
// NOTE BLOCK MODEL
// ============================================================

class _NoteBlockData {
  final String id;
  final String type;
  final String value;

  // Extra layout properties are preserved here.
  final Map<String, dynamic> layoutData;

  _NoteBlockData({
    required this.id,
    required this.type,
    required this.value,
    Map<String, dynamic>? layoutData,
  }) : layoutData =
            layoutData ?? {};
}