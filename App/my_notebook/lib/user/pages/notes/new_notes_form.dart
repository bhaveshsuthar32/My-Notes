// import 'package:flutter/material.dart';

// class New_Notes extends StatefulWidget {
//   const New_Notes({super.key});

//   @override
//   State<New_Notes> createState() => _New_NotesState();
// }

// class _New_NotesState extends State<New_Notes> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [

//           Text("new note"),
//         ],
//       ),
//     ) ;
//   }
// }








// import 'package:flutter/material.dart';

// class NewNotes extends StatefulWidget {
//   const NewNotes({super.key});

//   @override
//   State<NewNotes> createState() => _NewNotesState();
// }

// class _NewNotesState extends State<NewNotes> {
//   final _formKey = GlobalKey<FormState>();

//   final titleController = TextEditingController();
//   final subtitleController = TextEditingController();
//   final contentController = TextEditingController();

//   String? selectedTopic;
//   String status = "Active";

//   final List<String> topics = [
//     "Flutter",
//     "Node.js",
//     "Java",
//     "English",
//   ];

//   final List<String> statusList = [
//     "Active",
//     "Inactive",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Create New Note"),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(18),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [

//                 /// Title
                
//                 TextFormField(
//                   controller: titleController,
//                   decoration: const InputDecoration(
//                     labelText: "Title",
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.title),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 /// Subtitle
//                 TextFormField(
//                   controller: subtitleController,
//                   decoration: const InputDecoration(
//                     labelText: "Subtitle",
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.subtitles),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 /// Content
//                 TextFormField(
//                   controller: contentController,
//                   maxLines: 8,
//                   decoration: const InputDecoration(
//                     labelText: "Content",
//                     alignLabelWithHint: true,
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.description),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 /// Topic Dropdown
//                 DropdownButtonFormField<String>(
//                   value: selectedTopic,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Topic",
//                     prefixIcon: Icon(Icons.category),
//                   ),
//                   items: topics.map((topic) {
//                     return DropdownMenuItem(
//                       value: topic,
//                       child: Text(topic),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedTopic = value;
//                     });
//                   },
//                 ),

//                 const SizedBox(height: 16),

//                 /// Status Dropdown
//                 DropdownButtonFormField<String>(
//                   value: status,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: "Status",
//                     prefixIcon: Icon(Icons.toggle_on),
//                   ),
//                   items: statusList.map((value) {
//                     return DropdownMenuItem(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       status = value!;
//                     });
//                   },
//                 ),

//                 const SizedBox(height: 20),

//                 /// Image Picker UI
//                 Container(
//                   width: double.infinity,
//                   height: 140,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: InkWell(
//                     onTap: () {
//                       // TODO: Pick Images
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Icon(
//                           Icons.add_a_photo,
//                           size: 40,
//                           color: Colors.grey,
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           "Select Images",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 SizedBox(
//                   width: width,
//                   height: 50,
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       // TODO Save API
//                     },
//                     icon: const Icon(Icons.save),
//                     label: const Text(
//                       "Save Note",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_notebook/services/api_services.dart';

// class NewNotes extends StatefulWidget {
//   const NewNotes({super.key});

//   @override
//   State<NewNotes> createState() => _NewNotesState();
// }

// class _NewNotesState extends State<NewNotes> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final TextEditingController titleController =
//       TextEditingController();

//   final TextEditingController subtitleController =
//       TextEditingController();

//   final TextEditingController contentController =
//       TextEditingController();

//   final ImagePicker imagePicker = ImagePicker();

//   // Dynamic topics from database
//   List<Map<String, dynamic>> topics = [];

//   int? selectedTopicId;

//   String selectedStatus = "active";

//   bool isLoadingTopics = true;
//   bool isSaving = false;

//   // Gallery images
//   final List<File> selectedImages = [];

//   // Image URLs
//   final List<String> imageUrls = [];

//   @override
//   void initState() {
//     super.initState();

//     fetchTopics();
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     subtitleController.dispose();
//     contentController.dispose();

//     super.dispose();
//   }

//   // ============================================================
//   // FETCH TOPICS
//   // ============================================================

//   Future<void> fetchTopics() async {
//     try {
//       final result = await ApiServices().getTopicsAPI();

//       if (!mounted) return;

//       setState(() {
//         topics = List<Map<String, dynamic>>.from(result);
//         isLoadingTopics = false;
//       });
//     } catch (error) {
//       if (!mounted) return;

//       setState(() {
//         isLoadingTopics = false;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             "Topics load nahi ho paaye: $error",
//           ),
//         ),
//       );
//     }
//   }

//   // ============================================================
//   // GALLERY IMAGE
//   // ============================================================

//   Future<void> addGalleryImage() async {
//     try {
//       final XFile? pickedImage =
//           await imagePicker.pickImage(
//         source: ImageSource.gallery,
//       );

//       if (pickedImage == null) {
//         return;
//       }

//       if (!mounted) return;

//       setState(() {
//         selectedImages.add(
//           File(pickedImage.path),
//         );
//       });
//     } catch (error) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Gallery image select nahi ho payi",
//           ),
//         ),
//       );
//     }
//   }

//   // ============================================================
//   // IMAGE URL
//   // ============================================================

//   Future<void> addImageUrl() async {
//     final String? enteredUrl = await showDialog<String>(
//       context: context,
//       builder: (dialogContext) {
//         return _ImageUrlDialog();
//       },
//     );

//     if (enteredUrl == null ||
//         enteredUrl.trim().isEmpty) {
//       return;
//     }

//     if (!mounted) return;

//     setState(() {
//       imageUrls.add(
//         enteredUrl.trim(),
//       );
//     });
//   }

//   // ============================================================
//   // IMAGE OPTIONS
//   // ============================================================

//   void showImageOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (bottomSheetContext) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(
//                   Icons.photo_library,
//                 ),
//                 title: const Text(
//                   "Choose from Gallery",
//                 ),
//                 onTap: () {
//                   Navigator.pop(
//                     bottomSheetContext,
//                   );

//                   addGalleryImage();
//                 },
//               ),

//               ListTile(
//                 leading: const Icon(
//                   Icons.link,
//                 ),
//                 title: const Text(
//                   "Add Image URL",
//                 ),
//                 onTap: () {
//                   Navigator.pop(
//                     bottomSheetContext,
//                   );

//                   addImageUrl();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // ============================================================
//   // REMOVE GALLERY IMAGE
//   // ============================================================

//   void removeGalleryImage(int index) {
//     if (index < 0 ||
//         index >= selectedImages.length) {
//       return;
//     }

//     setState(() {
//       selectedImages.removeAt(index);
//     });
//   }

//   // ============================================================
//   // REMOVE URL IMAGE
//   // ============================================================

//   void removeImageUrl(int index) {
//     if (index < 0 ||
//         index >= imageUrls.length) {
//       return;
//     }

//     setState(() {
//       imageUrls.removeAt(index);
//     });
//   }

//   // ============================================================
//   // SAVE NOTE
//   // ============================================================

//   Future<void> saveNote() async {
//     FocusScope.of(context).unfocus();

//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     if (selectedTopicId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please select a topic",
//           ),
//         ),
//       );

//       return;
//     }

//     if (!mounted) return;

//     setState(() {
//       isSaving = true;
//     });

//     try {
//       await ApiServices().addNotesAPI(
//         title: titleController.text.trim(),
//         subtitle: subtitleController.text.trim(),
//         content: contentController.text.trim(),

//         // IMPORTANT:
//         // Your service parameter should be topicId
//         topicid: selectedTopicId!,

//         status: selectedStatus,

//         // Gallery images
//         images: selectedImages,

//         // URL images
//         imageUrls: imageUrls,
//       );

//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Note created successfully",
//           ),
//         ),
//       );

//       Navigator.pop(context);
//     } catch (error) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             "Note save nahi ho payi: $error",
//           ),
//         ),
//       );
//     } finally {
//       if (!mounted) return;

//       setState(() {
//         isSaving = false;
//       });
//     }
//   }

//   // ============================================================
//   // TEXT FIELD
//   // ============================================================

//   Widget buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     int maxLines = 1,
//     TextInputType keyboardType =
//         TextInputType.text,
//   }) {
//     return TextFormField(
//       controller: controller,
//       maxLines: maxLines,
//       keyboardType: keyboardType,

//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,

//         border: OutlineInputBorder(
//           borderRadius:
//               BorderRadius.circular(12),
//         ),
//       ),

//       validator: (value) {
//         if (value == null ||
//             value.trim().isEmpty) {
//           return "$label is required";
//         }

//         return null;
//       },
//     );
//   }

//   // ============================================================
//   // TOPIC DROPDOWN
//   // ============================================================

//   Widget buildTopicDropdown() {
//     if (isLoadingTopics) {
//       return const Center(
//         child: Padding(
//           padding: EdgeInsets.all(12),
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     if (topics.isEmpty) {
//       return const Text(
//         "No topics available",
//         style: TextStyle(
//           color: Colors.red,
//         ),
//       );
//     }

//     return DropdownButtonFormField<int>(
//       value: selectedTopicId,

//       decoration: InputDecoration(
//         labelText: "Select Topic",

//         border: OutlineInputBorder(
//           borderRadius:
//               BorderRadius.circular(12),
//         ),
//       ),

//       items: topics.map((topic) {
//         return DropdownMenuItem<int>(
//           value: topic["id"] is int
//               ? topic["id"]
//               : int.tryParse(
//                   topic["id"].toString(),
//                 ),

//           child: Text(
//             topic["name"].toString(),
//           ),
//         );
//       }).toList(),

//       onChanged: (value) {
//         setState(() {
//           selectedTopicId = value;
//         });
//       },

//       validator: (value) {
//         if (value == null) {
//           return "Please select a topic";
//         }

//         return null;
//       },
//     );
//   }

//   // ============================================================
//   // IMAGES SECTION
//   // ============================================================

//   Widget buildImagesSection() {
//     return Column(
//       crossAxisAlignment:
//           CrossAxisAlignment.start,

//       children: [
//         const Text(
//           "Images",
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),

//         const SizedBox(height: 12),

//         Wrap(
//           spacing: 12,
//           runSpacing: 12,

//           children: [
//             // ==================================================
//             // GALLERY IMAGES
//             // ==================================================

//             ...selectedImages
//                 .asMap()
//                 .entries
//                 .map((entry) {
//               final int index =
//                   entry.key;

//               final File image =
//                   entry.value;

//               return Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         BorderRadius.circular(
//                       12,
//                     ),

//                     child: Image.file(
//                       image,
//                       width: 110,
//                       height: 110,
//                       fit: BoxFit.cover,
//                     ),
//                   ),

//                   Positioned(
//                     top: 4,
//                     right: 4,

//                     child: InkWell(
//                       onTap: () {
//                         removeGalleryImage(
//                           index,
//                         );
//                       },

//                       child: Container(
//                         padding:
//                             const EdgeInsets.all(
//                           3,
//                         ),

//                         decoration:
//                             const BoxDecoration(
//                           color: Colors.red,
//                           shape:
//                               BoxShape.circle,
//                         ),

//                         child: const Icon(
//                           Icons.close,
//                           size: 18,
//                           color:
//                               Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }),

//             // ==================================================
//             // URL IMAGES
//             // ==================================================

//             ...imageUrls
//                 .asMap()
//                 .entries
//                 .map((entry) {
//               final int index =
//                   entry.key;

//               final String url =
//                   entry.value;

//               return Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         BorderRadius.circular(
//                       12,
//                     ),

//                     child: Image.network(
//                       url,
//                       width: 110,
//                       height: 110,
//                       fit: BoxFit.cover,

//                       errorBuilder:
//                           (
//                         context,
//                         error,
//                         stackTrace,
//                       ) {
//                         return Container(
//                           width: 110,
//                           height: 110,

//                           decoration:
//                               BoxDecoration(
//                             color: Colors
//                                 .grey
//                                 .shade300,

//                             borderRadius:
//                                 BorderRadius
//                                     .circular(
//                               12,
//                             ),
//                           ),

//                           child:
//                               const Icon(
//                             Icons
//                                 .broken_image,
//                             size: 35,
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   Positioned(
//                     top: 4,
//                     right: 4,

//                     child: InkWell(
//                       onTap: () {
//                         removeImageUrl(
//                           index,
//                         );
//                       },

//                       child: Container(
//                         padding:
//                             const EdgeInsets.all(
//                           3,
//                         ),

//                         decoration:
//                             const BoxDecoration(
//                           color: Colors.red,
//                           shape:
//                               BoxShape.circle,
//                         ),

//                         child: const Icon(
//                           Icons.close,
//                           size: 18,
//                           color:
//                               Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }),

//             // ==================================================
//             // ADD MORE BUTTON
//             // ==================================================

//             InkWell(
//               onTap: showImageOptions,

//               borderRadius:
//                   BorderRadius.circular(12),

//               child: Container(
//                 width: 110,
//                 height: 110,

//                 decoration:
//                     BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey,
//                     width: 1.5,
//                   ),

//                   borderRadius:
//                       BorderRadius.circular(
//                     12,
//                   ),
//                 ),

//                 child: const Column(
//                   mainAxisAlignment:
//                       MainAxisAlignment
//                           .center,

//                   children: [
//                     Icon(
//                       Icons.add,
//                       size: 32,
//                     ),

//                     SizedBox(height: 5),

//                     Text(
//                       "Add More",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   // ============================================================
//   // BUILD
//   // ============================================================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "New Note",
//         ),
//       ),

//       body: Center(
//         child: SingleChildScrollView(
//           padding:
//               const EdgeInsets.all(20),

//           child: ConstrainedBox(
//             constraints:
//                 const BoxConstraints(
//               maxWidth: 850,
//             ),

//             child: Form(
//               key: _formKey,

//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment
//                         .stretch,

//                 children: [
//                   // ==================================================
//                   // TITLE
//                   // ==================================================

//                   buildTextField(
//                     controller:
//                         titleController,

//                     label: "Title",

//                     hint:
//                         "Enter note title",
//                   ),

//                   const SizedBox(
//                     height: 16,
//                   ),

//                   // ==================================================
//                   // SUBTITLE
//                   // ==================================================

//                   buildTextField(
//                     controller:
//                         subtitleController,

//                     label: "Subtitle",

//                     hint:
//                         "Enter note subtitle",
//                   ),

//                   const SizedBox(
//                     height: 16,
//                   ),

//                   // ==================================================
//                   // CONTENT
//                   // ==================================================

//                   buildTextField(
//                     controller:
//                         contentController,

//                     label: "Content",

//                     hint:
//                         "Enter note content",

//                     maxLines: 8,
//                   ),

//                   const SizedBox(
//                     height: 16,
//                   ),

//                   // ==================================================
//                   // TOPIC
//                   // ==================================================

//                   buildTopicDropdown(),

//                   const SizedBox(
//                     height: 16,
//                   ),

//                   // ==================================================
//                   // STATUS
//                   // ==================================================

//                   DropdownButtonFormField<
//                       String>(
//                     value:
//                         selectedStatus,

//                     decoration:
//                         InputDecoration(
//                       labelText:
//                           "Status",

//                       border:
//                           OutlineInputBorder(
//                         borderRadius:
//                             BorderRadius
//                                 .circular(
//                           12,
//                         ),
//                       ),
//                     ),

//                     items: const [
//                       DropdownMenuItem(
//                         value: "active",
//                         child:
//                             Text("Active"),
//                       ),

//                       DropdownMenuItem(
//                         value: "inactive",
//                         child:
//                             Text(
//                           "Inactive",
//                         ),
//                       ),
//                     ],

//                     onChanged:
//                         (value) {
//                       if (value ==
//                           null) {
//                         return;
//                       }

//                       setState(() {
//                         selectedStatus =
//                             value;
//                       });
//                     },
//                   ),

//                   const SizedBox(
//                     height: 20,
//                   ),

//                   // ==================================================
//                   // IMAGES
//                   // ==================================================

//                   buildImagesSection(),

//                   const SizedBox(
//                     height: 28,
//                   ),

//                   // ==================================================
//                   // SAVE BUTTON
//                   // ==================================================

//                   SizedBox(
//                     height: 52,

//                     child:
//                         ElevatedButton(
//                       onPressed:
//                           isSaving
//                               ? null
//                               : saveNote,

//                       child: isSaving
//                           ? const SizedBox(
//                               height: 24,
//                               width: 24,

//                               child:
//                                   CircularProgressIndicator(),
//                             )
//                           : const Text(
//                               "Save Note",

//                               style:
//                                   TextStyle(
//                                 fontSize:
//                                     16,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// // ================================================================
// // IMAGE URL DIALOG
// // ================================================================

// class _ImageUrlDialog extends StatefulWidget {
//   const _ImageUrlDialog();

//   @override
//   State<_ImageUrlDialog> createState() =>
//       _ImageUrlDialogState();
// }

// class _ImageUrlDialogState
//     extends State<_ImageUrlDialog> {
//   final TextEditingController
//       urlController =
//       TextEditingController();

//   @override
//   void dispose() {
//     urlController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return AlertDialog(
//       title: const Text(
//         "Add Image URL",
//       ),

//       content: TextField(
//         controller: urlController,

//         keyboardType:
//             TextInputType.url,

//         decoration:
//             const InputDecoration(
//           hintText:
//               "https://example.com/image.jpg",

//           border:
//               OutlineInputBorder(),
//         ),
//       ),

//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(
//               context,
//             );
//           },

//           child: const Text(
//             "Cancel",
//           ),
//         ),

//         ElevatedButton(
//           onPressed: () {
//             final String url =
//                 urlController.text
//                     .trim();

//             if (url.isEmpty) {
//               return;
//             }

//             Navigator.pop(
//               context,
//               url,
//             );
//           },

//           child: const Text(
//             "Add",
//           ),
//         ),
//       ],
//     );
//   }
// }




import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notebook/services/api_services.dart';

class NoteBlock {
  final String id;
  final String type;
  final TextEditingController controller;

  File? imageFile;
  String? imageUrl;

  NoteBlock({
    required this.id,
    required this.type,
    String value = "",
  }) : controller = TextEditingController(text: value);

  void dispose() {
    controller.dispose();
  }
}

class NewNotes extends StatefulWidget {
  const NewNotes({super.key});

  @override
  State<NewNotes> createState() => _NewNotesState();
}

class _NewNotesState extends State<NewNotes> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  final TextEditingController titleController =
      TextEditingController();

  final ImagePicker imagePicker =
      ImagePicker();

  final List<NoteBlock> blocks = [];

  List<Map<String, dynamic>> topics = [];

  int? selectedTopicId;

  String selectedStatus = "active";

  bool isLoadingTopics = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    fetchTopics();
  }

  @override
  void dispose() {
    titleController.dispose();

    for (final block in blocks) {
      block.dispose();
    }

    super.dispose();
  }

  // Fetch topics

  Future<void> fetchTopics() async {
    try {
      final result =
          await ApiServices().getTopicsAPI();

      if (!mounted) return;

      setState(() {
        topics =
            List<Map<String, dynamic>>.from(
          result,
        );

        isLoadingTopics = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoadingTopics = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Topics load nahi ho paaye: $error",
          ),
        ),
      );
    }
  }

  // Add text field

  void addTextBlock(String type) {
    final String id =
        "${type}_${DateTime.now().microsecondsSinceEpoch}";

    setState(() {
      blocks.add(
        NoteBlock(
          id: id,
          type: type,
        ),
      );
    });
  }

  // Add image field

  void addImageBlock() {
    final String id =
        "image_${DateTime.now().microsecondsSinceEpoch}";

    setState(() {
      blocks.add(
        NoteBlock(
          id: id,
          type: "image",
        ),
      );
    });
  }

  // Add field options

  void showAddFieldOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.title,
                ),
                title: const Text(
                  "Heading",
                ),
                onTap: () {
                  Navigator.pop(context);

                  addTextBlock(
                    "heading",
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.subtitles,
                ),
                title: const Text(
                  "Subtitle",
                ),
                onTap: () {
                  Navigator.pop(context);

                  addTextBlock(
                    "subtitle",
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.notes,
                ),
                title: const Text(
                  "Paragraph",
                ),
                onTap: () {
                  Navigator.pop(context);

                  addTextBlock(
                    "content",
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.image,
                ),
                title: const Text(
                  "Image",
                ),
                onTap: () {
                  Navigator.pop(context);

                  addImageBlock();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Image options

  void showImageOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                ),
                title: const Text(
                  "Choose from Gallery",
                ),
                onTap: () {
                  Navigator.pop(context);

                  pickImage(index);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.link,
                ),
                title: const Text(
                  "Add Image URL",
                ),
                onTap: () {
                  Navigator.pop(context);

                  addImageUrl(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Pick image

  Future<void> pickImage(int index) async {
    try {
      final XFile? pickedImage =
          await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImage == null) {
        return;
      }

      if (!mounted) return;

      setState(() {
        blocks[index].imageFile =
            File(pickedImage.path);

        blocks[index].imageUrl = null;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Image select nahi ho payi: $error",
          ),
        ),
      );
    }
  }

  // Add image URL

  Future<void> addImageUrl(int index) async {
    final String? url =
        await showDialog<String>(
      context: context,
      builder: (context) {
        return const ImageUrlDialog();
      },
    );

    if (url == null ||
        url.trim().isEmpty) {
      return;
    }

    if (!mounted) return;

    setState(() {
      blocks[index].imageUrl =
          url.trim();

      blocks[index].imageFile = null;
    });
  }

  // Remove block

  void removeBlock(int index) {
    blocks[index].dispose();

    setState(() {
      blocks.removeAt(index);
    });
  }

  // Reorder

  void reorderBlock(
    int oldIndex,
    int newIndex,
  ) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      final NoteBlock block =
          blocks.removeAt(oldIndex);

      blocks.insert(
        newIndex,
        block,
      );
    });
  }

  // Save note

  Future<void> saveNote() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedTopicId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select a topic",
          ),
        ),
      );

      return;
    }

    if (blocks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please add at least one field",
          ),
        ),
      );

      return;
    }

    for (final block in blocks) {
      if (block.type != "image" &&
          block.controller.text
              .trim()
              .isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${getBlockTitle(block.type)} is required",
            ),
          ),
        );

        return;
      }

      if (block.type == "image" &&
          block.imageFile == null &&
          (block.imageUrl == null ||
              block.imageUrl!.trim().isEmpty)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Please select or add an image",
            ),
          ),
        );

        return;
      }
    }

    setState(() {
      isSaving = true;
    });

    try {
      final List<Map<String, dynamic>>
          subtitles = [];

      final List<Map<String, dynamic>>
          contents = [];

      final List<Map<String, dynamic>>
          images = [];

      final List<Map<String, dynamic>>
          contentOrder = [];

      final List<File> imageFiles = [];

      for (final block in blocks) {
        if (block.type == "heading") {
          subtitles.add({
            "id": block.id,
            "value":
                block.controller.text.trim(),
            "type": "heading",
          });

          contentOrder.add({
            "id": block.id,
            "type": "heading",
          });
        }

        if (block.type == "subtitle") {
          subtitles.add({
            "id": block.id,
            "value":
                block.controller.text.trim(),
            "type": "subtitle",
          });

          contentOrder.add({
            "id": block.id,
            "type": "subtitle",
          });
        }

        if (block.type == "content") {
          contents.add({
            "id": block.id,
            "value":
                block.controller.text.trim(),
          });

          contentOrder.add({
            "id": block.id,
            "type": "content",
          });
        }

        if (block.type == "image") {
          if (block.imageFile != null) {
            imageFiles.add(
              block.imageFile!,
            );

            images.add({
              "id": block.id,
              "value": null,
            });
          } else {
            images.add({
              "id": block.id,
              "value": block.imageUrl,
            });
          }

          contentOrder.add({
            "id": block.id,
            "type": "image",
          });
        }
      }

      await ApiServices().addNotesAPI(
        title:
            titleController.text.trim(),
        topicid: selectedTopicId!,
        status: selectedStatus,
        subtitles: subtitles,
        contents: contents,
        images: images,
        contentOrder: contentOrder,
        imageFiles: imageFiles,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Note created successfully",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Note save nahi ho payi: $error",
          ),
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });
    }
  }

  // Block title

  String getBlockTitle(String type) {
    switch (type) {
      case "heading":
        return "Heading";

      case "subtitle":
        return "Subtitle";

      case "content":
        return "Paragraph";

      default:
        return "Field";
    }
  }

  // Text block

  Widget buildTextBlock(int index) {
    final NoteBlock block =
        blocks[index];

    int maxLines = 8;

    if (block.type == "heading") {
      maxLines = 2;
    }

    if (block.type == "subtitle") {
      maxLines = 3;
    }

    return Container(
      key: ValueKey(block.id),
      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),
      padding:
          const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Padding(
            padding:
                EdgeInsets.only(
              top: 12,
            ),
            child: Icon(
              Icons.drag_handle,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextFormField(
              controller:
                  block.controller,
              maxLines: maxLines,
              decoration:
                  InputDecoration(
                labelText:
                    getBlockTitle(
                  block.type,
                ),
                hintText:
                    "Enter ${getBlockTitle(block.type).toLowerCase()}",
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          IconButton(
            onPressed: () {
              removeBlock(index);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // Image block

  Widget buildImageBlock(int index) {
    final NoteBlock block =
        blocks[index];

    Widget imageWidget;

    if (block.imageFile != null) {
      imageWidget = Image.file(
        block.imageFile!,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (block.imageUrl != null &&
        block.imageUrl!.isNotEmpty) {
      imageWidget = Image.network(
        block.imageUrl!,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder:
            (
          context,
          error,
          stackTrace,
        ) {
          return const SizedBox(
            height: 180,
            child: Center(
              child: Icon(
                Icons.broken_image,
                size: 50,
              ),
            ),
          );
        },
      );
    } else {
      imageWidget =
          const SizedBox(
        height: 180,
        child: Center(
          child: Icon(
            Icons
                .add_photo_alternate,
            size: 55,
          ),
        ),
      );
    }

    return Container(
      key: ValueKey(block.id),
      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),
      padding:
          const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.drag_handle,
              ),
              const SizedBox(
                width: 8,
              ),
              const Expanded(
                child: Text(
                  "Image",
                  style:
                      TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  removeBlock(index);
                },
                icon:
                    const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              12,
            ),
            child: Container(
              width:
                  double.infinity,
              color:
                  Colors.grey.shade200,
              child:
                  imageWidget,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width:
                double.infinity,
            child:
                OutlinedButton.icon(
              onPressed: () {
                showImageOptions(
                  index,
                );
              },
              icon:
                  const Icon(
                Icons.image,
              ),
              label:
                  const Text(
                "Select Image",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dynamic fields

  Widget buildBlocksSection() {
    if (blocks.isEmpty) {
      return Container(
        padding:
            const EdgeInsets.all(20),
        decoration:
            BoxDecoration(
          border: Border.all(
            color:
                Colors.grey.shade300,
          ),
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),
        child:
            const Center(
          child: Text(
            "No fields added yet",
          ),
        ),
      );
    }

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemCount: blocks.length,
      onReorder:
          reorderBlock,
      itemBuilder:
          (context, index) {
        final NoteBlock block =
            blocks[index];

        if (block.type ==
            "image") {
          return buildImageBlock(
            index,
          );
        }

        return buildTextBlock(
          index,
        );
      },
    );
  }

  // Topic dropdown

  Widget buildTopicDropdown() {
    if (isLoadingTopics) {
      return const Center(
        child: Padding(
          padding:
              EdgeInsets.all(12),
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (topics.isEmpty) {
      return const Text(
        "No topics available",
        style: TextStyle(
          color: Colors.red,
        ),
      );
    }

    return DropdownButtonFormField<int>(
      value:
          selectedTopicId,
      decoration:
          InputDecoration(
        labelText:
            "Select Topic",
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius
                  .circular(12),
        ),
      ),
      items:
          topics.map((topic) {
        final int? topicId =
            topic["id"] is int
                ? topic["id"]
                : int.tryParse(
                    topic["id"]
                        .toString(),
                  );

        return DropdownMenuItem<
            int>(
          value: topicId,
          child: Text(
            topic["name"]
                .toString(),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedTopicId =
              value;
        });
      },
      validator: (value) {
        if (value == null) {
          return
              "Please select a topic";
        }

        return null;
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(
          "New Note",
        ),
      ),
      body: Center(
        child:
            SingleChildScrollView(
          padding:
              const EdgeInsets.all(
            20,
          ),
          child:
              ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 850,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .stretch,
                children: [
                  // Title

                  TextFormField(
                    controller:
                        titleController,
                    decoration:
                        InputDecoration(
                      labelText:
                          "Title",
                      hintText:
                          "Enter note title",
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          12,
                        ),
                      ),
                    ),
                    validator:
                        (value) {
                      if (value ==
                              null ||
                          value
                              .trim()
                              .isEmpty) {
                        return
                            "Title is required";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // Topic

                  buildTopicDropdown(),

                  const SizedBox(
                    height: 16,
                  ),

                  // Status

                  DropdownButtonFormField<
                      String>(
                    value:
                        selectedStatus,
                    decoration:
                        InputDecoration(
                      labelText:
                          "Status",
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          12,
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value:
                            "active",
                        child:
                            Text(
                          "Active",
                        ),
                      ),
                      DropdownMenuItem(
                        value:
                            "inactive",
                        child:
                            Text(
                          "Inactive",
                        ),
                      ),
                    ],
                    onChanged:
                        (value) {
                      if (value ==
                          null) {
                        return;
                      }

                      setState(() {
                        selectedStatus =
                            value;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  // Add field

                  Row(
                    children: [
                      const Expanded(
                        child:
                            Text(
                          "Note Fields",
                          style:
                              TextStyle(
                            fontSize:
                                18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),
                      ElevatedButton
                          .icon(
                        onPressed:
                            showAddFieldOptions,
                        icon:
                            const Icon(
                          Icons.add,
                        ),
                        label:
                            const Text(
                          "Add Field",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // Fields

                  buildBlocksSection(),

                  const SizedBox(
                    height: 24,
                  ),

                  // Save

                  SizedBox(
                    height: 52,
                    child:
                        ElevatedButton(
                      onPressed:
                          isSaving
                              ? null
                              : saveNote,
                      child: isSaving
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child:
                                  CircularProgressIndicator(),
                            )
                          : const Text(
                              "Save Note",
                              style:
                                  TextStyle(
                                fontSize:
                                    16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageUrlDialog
    extends StatefulWidget {
  const ImageUrlDialog({
    super.key,
  });

  @override
  State<ImageUrlDialog> createState() =>
      _ImageUrlDialogState();
}

class _ImageUrlDialogState
    extends State<ImageUrlDialog> {
  final TextEditingController
      urlController =
      TextEditingController();

  @override
  void dispose() {
    urlController.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      title:
          const Text(
        "Add Image URL",
      ),
      content:
          TextField(
        controller:
            urlController,
        keyboardType:
            TextInputType.url,
        decoration:
            const InputDecoration(
          hintText:
              "https://example.com/image.jpg",
          border:
              OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          child:
              const Text(
            "Cancel",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final String url =
                urlController.text
                    .trim();

            if (url.isEmpty) {
              return;
            }

            Navigator.pop(
              context,
              url,
            );
          },
          child:
              const Text(
            "Add",
          ),
        ),
      ],
    );
  }
}
