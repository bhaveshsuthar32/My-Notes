// import 'package:flutter/material.dart';
// import 'package:my_notebook/services/api_services.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';

// class TopicsForm extends StatefulWidget {
//   const TopicsForm({super.key});

//   @override
//   State<TopicsForm> createState() => _TopicsFormState();
// }

// class _TopicsFormState extends State<TopicsForm> {
//   final formKey = GlobalKey<FormState>();

//   final topicController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final imageController = TextEditingController();

//   String status = "Active";

//   @override
//   void dispose() {
//     topicController.dispose();
//     descriptionController.dispose();
//     imageController.dispose();
//     super.dispose();
//   }

//   Future<void> addTopic() async {
//     try {
//       print("Image URL: ${imageController.text}");

//       final res = await ApiServices().addTopicAPI(
//         topicController.text.trim(),
//         descriptionController.text.trim(),
//         imageController.text.trim(),
//         "Active",
//       );

//       print(res);

//       if (!mounted) return;

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Topic added successfully")));
//     } catch (e) {
//       print(e);

//       if (!mounted) return;

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     final backgroundColor = isDark
//         ? const Color(0xFF0F172A)
//         : const Color(0xFFF5F7FA);

//     final cardColor = isDark ? const Color(0xFF172554) : Colors.white;

//     final textColor = isDark ? Colors.white : Colors.black87;

//     final secondaryColor = isDark ? Colors.white70 : Colors.black54;

//     final inputColor = isDark ? const Color(0xFF1E3A5F) : Colors.grey.shade100;

//     return Scaffold(
//       backgroundColor: backgroundColor,

//       appBar: Header(),

//       drawer: Drawerbar(),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),

//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 700),

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,

//               children: [
//                 // Page Title
//                 Text(
//                   "Create Topic",
//                   style: TextStyle(
//                     color: textColor,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   "Add a new topic to your notebook",
//                   style: TextStyle(color: secondaryColor, fontSize: 14),
//                 ),

//                 const SizedBox(height: 25),

//                 // Form Card
//                 Container(
//                   width: double.infinity,

//                   padding: const EdgeInsets.all(24),

//                   decoration: BoxDecoration(
//                     color: cardColor,
//                     borderRadius: BorderRadius.circular(8),

//                     boxShadow: [
//                       BoxShadow(
//                         color: isDark ? Colors.black26 : Colors.black12,
//                         blurRadius: 12,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),

//                   child: Form(
//                     key: formKey,

//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,

//                       children: [
//                         // Topic Name
//                         Text(
//                           "Topic Name",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         TextFormField(
//                           controller: topicController,

//                           style: TextStyle(color: textColor),

//                           decoration: InputDecoration(
//                             hintText: "Enter topic name",
//                             hintStyle: TextStyle(color: secondaryColor),

//                             prefixIcon: Icon(
//                               Icons.topic_outlined,
//                               color: isDark
//                                   ? Colors.lightBlue[200]
//                                   : Colors.blue,
//                             ),

//                             filled: true,
//                             fillColor: inputColor,

//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return "Please enter topic name";
//                             }

//                             return null;
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // Description
//                         Text(
//                           "Description",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         TextFormField(
//                           controller: descriptionController,

//                           maxLines: 5,

//                           style: TextStyle(color: textColor),

//                           decoration: InputDecoration(
//                             hintText: "Enter topic description",
//                             hintStyle: TextStyle(color: secondaryColor),

//                             prefixIcon: Padding(
//                               padding: const EdgeInsets.only(bottom: 75),

//                               child: Icon(
//                                 Icons.description_outlined,
//                                 color: isDark
//                                     ? Colors.lightBlue[200]
//                                     : Colors.blue,
//                               ),
//                             ),

//                             filled: true,
//                             fillColor: inputColor,

//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return "Please enter description";
//                             }

//                             return null;
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // Status
//                         Text(
//                           "Status",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         DropdownButtonFormField<String>(
//                           value: status,

//                           style: TextStyle(color: textColor),

//                           dropdownColor: cardColor,

//                           decoration: InputDecoration(
//                             prefixIcon: Icon(
//                               Icons.toggle_on_outlined,
//                               color: isDark
//                                   ? Colors.lightBlue[200]
//                                   : Colors.blue,
//                             ),

//                             filled: true,
//                             fillColor: inputColor,

//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           items: const [
//                             DropdownMenuItem(
//                               value: "Active",
//                               child: Text("Active"),
//                             ),
//                             DropdownMenuItem(
//                               value: "Inactive",
//                               child: Text("Inactive"),
//                             ),
//                           ],

//                           onChanged: (value) {
//                             setState(() {
//                               status = value!;
//                             });
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // Image URL
//                         Text(
//                           "Cover Image URL",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         // TextFormField(
//                         //   controller: imageController,

//                         //   style: TextStyle(
//                         //     color: textColor,
//                         //   ),

//                         //   decoration: InputDecoration(
//                         //     hintText:
//                         //         "Enter image URL",
//                         //     hintStyle: TextStyle(
//                         //       color: secondaryColor,
//                         //     ),

//                         //     prefixIcon: Icon(
//                         //       Icons.image_outlined,
//                         //       color: isDark
//                         //           ? Colors.lightBlue[200]
//                         //           : Colors.blue,
//                         //     ),

//                         //     filled: true,
//                         //     fillColor: inputColor,

//                         //     border: OutlineInputBorder(
//                         //       borderRadius:
//                         //           BorderRadius.circular(8),
//                         //       borderSide:
//                         //           BorderSide.none,
//                         //     ),
//                         //   ),
//                         // ),
//                         // TextFormField(
//                         //   controller: imageController,
//                         //   style: TextStyle(color: textColor),
//                         //   decoration: InputDecoration(
//                         //     hintText: "Enter image URL",
//                         //     hintStyle: TextStyle(color: secondaryColor),
//                         //     prefixIcon: Icon(
//                         //       Icons.image_outlined,
//                         //       color: isDark
//                         //           ? Colors.lightBlue[200]
//                         //           : Colors.blue,
//                         //     ),
//                         //     filled: true,
//                         //     fillColor: inputColor,
//                         //     border: OutlineInputBorder(
//                         //       borderRadius: BorderRadius.circular(8),
//                         //       borderSide: BorderSide.none,
//                         //     ),
//                         //   ),

//                         //   // URL type karte hi preview update hoga
//                         //   onChanged: (value) {
//                         //     setState(() {});
//                         //   },
//                         // ),

//                         // const SizedBox(height: 12),

//                         // // Image preview
//                         // Container(
//                         //   height: 150,
//                         //   width: double.infinity,
//                         //   decoration: BoxDecoration(
//                         //     borderRadius: BorderRadius.circular(8),
//                         //     color: inputColor,
//                         //   ),
//                         //   child: imageController.text.trim().isNotEmpty
//                         //       ? Image.network(
//                         //           imageController.text.trim(),
//                         //           fit: BoxFit.cover,
//                         //           errorBuilder: (context, error, stackTrace) {
//                         //             return const Icon(Icons.image, size: 50);
//                         //           },
//                         //         )
//                         //       : const Icon(Icons.image, size: 50),
//                         // ),

//                         // ---------------------
//                         TextFormField(
//                           controller: imageController,
//                           style: TextStyle(color: textColor),
//                           keyboardType: TextInputType.url,

//                           decoration: InputDecoration(
//                             hintText: "Enter image URL",
//                             hintStyle: TextStyle(color: secondaryColor),

//                             prefixIcon: Icon(
//                               Icons.image_outlined,
//                               color: isDark
//                                   ? Colors.lightBlue[200]
//                                   : Colors.blue,
//                             ),

//                             filled: true,
//                             fillColor: inputColor,

//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           // URL type karte hi preview update hoga
//                           onChanged: (value) {
//                             setState(() {});
//                           },
//                         ),

//                         const SizedBox(height: 12),

//                         // Image preview
//                         Container(
//                           height: 180,
//                           width: double.infinity,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: inputColor,
//                           ),
//                           child: imageController.text.trim().isNotEmpty
//                               ? Image.network(
//                                   imageController.text.trim(),
//                                   fit: BoxFit.cover,

//                                   // Image load hone tak
//                                   loadingBuilder:
//                                       (context, child, loadingProgress) {
//                                         if (loadingProgress == null) {
//                                           return child;
//                                         }

//                                         return const Center(
//                                           child: CircularProgressIndicator(),
//                                         );
//                                       },

//                                   // URL galat hone par
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return const Center(
//                                       child: Icon(Icons.broken_image, size: 50),
//                                     );
//                                   },
//                                 )
//                               : const Center(
//                                   child: Icon(Icons.image, size: 50),
//                                 ),
//                         ),

//                         // ----------------------
//                         const SizedBox(height: 30),

//                         // Buttons
//                         Row(
//                           children: [
//                             Expanded(
//                               child: OutlinedButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },

//                                 style: OutlinedButton.styleFrom(
//                                   minimumSize: const Size(0, 50),

//                                   side: BorderSide(
//                                     color: isDark
//                                         ? Colors.lightBlue.shade200
//                                         : Colors.blue,
//                                   ),

//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),

//                                 child: Text(
//                                   "Cancel",
//                                   style: TextStyle(
//                                     color: isDark
//                                         ? Colors.lightBlue.shade200
//                                         : Colors.blue,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(width: 15),

//                             Expanded(
//                               child: ElevatedButton.icon(
//                                 onPressed: addTopic,

//                                 icon: const Icon(Icons.save_outlined),

//                                 label: const Text("Save Topic"),

//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue,

//                                   foregroundColor: Colors.white,

//                                   minimumSize: const Size(0, 50),

//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 25),
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
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';

// class TopicsForm extends StatefulWidget {
//   const TopicsForm({super.key});

//   @override
//   State<TopicsForm> createState() => _TopicsFormState();
// }

// class _TopicsFormState extends State<TopicsForm> {
//   final formKey = GlobalKey<FormState>();

//   final topicController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final imageController = TextEditingController();

//   final ImagePicker imagePicker = ImagePicker();

//   String status = "Active";

//   File? selectedImage;

//   bool isSaving = false;

//   @override
//   void dispose() {
//     topicController.dispose();
//     descriptionController.dispose();
//     imageController.dispose();

//     super.dispose();
//   }

//   // Image options show karna
//   void showImageOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.link),
//                 title: const Text("Add Image URL"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   showUrlDialog();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text("Select Image from Gallery"),
//                 onTap: () {
//                   Navigator.pop(context);
//                   pickImage();
//                 },
//               ),
//               if (selectedImage != null ||
//                   imageController.text.trim().isNotEmpty)
//                 ListTile(
//                   leading: const Icon(Icons.delete, color: Colors.red),
//                   title: const Text("Remove Image"),
//                   onTap: () {
//                     Navigator.pop(context);

//                     setState(() {
//                       selectedImage = null;
//                       imageController.clear();
//                     });
//                   },
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // URL enter karne ka dialog
//   void showUrlDialog() {
//     final urlController = TextEditingController(
//       text: imageController.text,
//     );

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Add Image URL"),
//           content: TextField(
//             controller: urlController,
//             keyboardType: TextInputType.url,
//             decoration: const InputDecoration(
//               hintText: "https://example.com/image.jpg",
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final url = urlController.text.trim();

//                 if (url.isEmpty) {
//                   return;
//                 }

//                 setState(() {
//                   selectedImage = null;
//                   imageController.text = url;
//                 });

//                 Navigator.pop(context);
//               },
//               child: const Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Gallery se image select karna
//   Future<void> pickImage() async {
//     try {
//       final XFile? image = await imagePicker.pickImage(
//         source: ImageSource.gallery,
//       );

//       if (image == null) {
//         return;
//       }

//       setState(() {
//         selectedImage = File(image.path);

//         // URL clear karna, kyunki ab file select hui hai
//         imageController.clear();
//       });
//     } catch (e) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Image select error: $e"),
//         ),
//       );
//     }
//   }

//   // Topic save karna
//   Future<void> addTopic() async {
//     if (!formKey.currentState!.validate()) {
//       return;
//     }

//     if (selectedImage == null &&
//         imageController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Please select an image or add image URL"),
//         ),
//       );

//       return;
//     }

//     setState(() {
//       isSaving = true;
//     });

//     try {
//       final response = await ApiServices().addTopicAPI(
//         name: topicController.text.trim(),
//         description: descriptionController.text.trim(),
//         status: status,
//         imageUrl: imageController.text.trim(),
//         imageFile: selectedImage,
//       );

//       print(response);

//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Topic added successfully"),
//         ),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       print(e);

//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Error: $e"),
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           isSaving = false;
//         });
//       }
//     }
//   }

//   // Image preview
//   Widget imagePreview(bool isDark, Color inputColor) {
//     if (selectedImage != null) {
//       return Image.file(
//         selectedImage!,
//         width: double.infinity,
//         height: 180,
//         fit: BoxFit.cover,
//       );
//     }

//     if (imageController.text.trim().isNotEmpty) {
//       return Image.network(
//         imageController.text.trim(),
//         width: double.infinity,
//         height: 180,
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) {
//             return child;
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//         errorBuilder: (context, error, stackTrace) {
//           return const Center(
//             child: Icon(
//               Icons.broken_image,
//               size: 50,
//             ),
//           );
//         },
//       );
//     }

//     return const Center(
//       child: Icon(
//         Icons.image_outlined,
//         size: 50,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     final backgroundColor = isDark
//         ? const Color(0xFF0F172A)
//         : const Color(0xFFF5F7FA);

//     final cardColor = isDark
//         ? const Color(0xFF172554)
//         : Colors.white;

//     final textColor = isDark
//         ? Colors.white
//         : Colors.black87;

//     final secondaryColor = isDark
//         ? Colors.white70
//         : Colors.black54;

//     final inputColor = isDark
//         ? const Color(0xFF1E3A5F)
//         : Colors.grey.shade100;

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: Header(),
//       drawer: Drawerbar(),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),

//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               maxWidth: 700,
//             ),

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Create Topic",
//                   style: TextStyle(
//                     color: textColor,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   "Add a new topic to your notebook",
//                   style: TextStyle(
//                     color: secondaryColor,
//                     fontSize: 14,
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(24),

//                   decoration: BoxDecoration(
//                     color: cardColor,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: isDark
//                             ? Colors.black26
//                             : Colors.black12,
//                         blurRadius: 12,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),

//                   child: Form(
//                     key: formKey,

//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Topic name
//                         Text(
//                           "Topic Name",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         TextFormField(
//                           controller: topicController,
//                           style: TextStyle(color: textColor),

//                           decoration: InputDecoration(
//                             hintText: "Enter topic name",
//                             hintStyle: TextStyle(
//                               color: secondaryColor,
//                             ),
//                             prefixIcon: Icon(
//                               Icons.topic_outlined,
//                               color: Colors.blue,
//                             ),
//                             filled: true,
//                             fillColor: inputColor,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           validator: (value) {
//                             if (value == null ||
//                                 value.trim().isEmpty) {
//                               return "Please enter topic name";
//                             }

//                             return null;
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // Description
//                         Text(
//                           "Description",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         TextFormField(
//                           controller: descriptionController,
//                           maxLines: 5,
//                           style: TextStyle(color: textColor),

//                           decoration: InputDecoration(
//                             hintText: "Enter topic description",
//                             hintStyle: TextStyle(
//                               color: secondaryColor,
//                             ),
//                             prefixIcon: const Padding(
//                               padding: EdgeInsets.only(bottom: 75),
//                               child: Icon(
//                                 Icons.description_outlined,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             filled: true,
//                             fillColor: inputColor,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           validator: (value) {
//                             if (value == null ||
//                                 value.trim().isEmpty) {
//                               return "Please enter description";
//                             }

//                             return null;
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // Status
//                         Text(
//                           "Status",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         DropdownButtonFormField<String>(
//                           value: status,
//                           style: TextStyle(color: textColor),
//                           dropdownColor: cardColor,

//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(
//                               Icons.toggle_on_outlined,
//                               color: Colors.blue,
//                             ),
//                             filled: true,
//                             fillColor: inputColor,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           items: const [
//                             DropdownMenuItem(
//                               value: "Active",
//                               child: Text("Active"),
//                             ),
//                             DropdownMenuItem(
//                               value: "Inactive",
//                               child: Text("Inactive"),
//                             ),
//                           ],

//                           onChanged: (value) {
//                             setState(() {
//                               status = value!;
//                             });
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // Cover image
//                         Text(
//                           "Cover Image",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         GestureDetector(
//                           onTap: showImageOptions,

//                           child: Container(
//                             height: 180,
//                             width: double.infinity,
//                             clipBehavior: Clip.antiAlias,

//                             decoration: BoxDecoration(
//                               color: inputColor,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: Colors.blue,
//                                 width: 1,
//                               ),
//                             ),

//                             child: imagePreview(
//                               isDark,
//                               inputColor,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 10),

//                         SizedBox(
//                           width: double.infinity,

//                           child: OutlinedButton.icon(
//                             onPressed: showImageOptions,
//                             icon: const Icon(Icons.add_photo_alternate),
//                             label: const Text(
//                               "Add Image URL or Select Gallery Image",
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 30),

//                         // Buttons
//                         Row(
//                           children: [
//                             Expanded(
//                               child: OutlinedButton(
//                                 onPressed: isSaving
//                                     ? null
//                                     : () {
//                                         Navigator.pop(context);
//                                       },

//                                 style: OutlinedButton.styleFrom(
//                                   minimumSize: const Size(0, 50),
//                                   side: const BorderSide(
//                                     color: Colors.blue,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.circular(8),
//                                   ),
//                                 ),

//                                 child: const Text(
//                                   "Cancel",
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(width: 15),

//                             Expanded(
//                               child: ElevatedButton.icon(
//                                 onPressed: isSaving
//                                     ? null
//                                     : addTopic,

//                                 icon: isSaving
//                                     ? const SizedBox(
//                                         height: 18,
//                                         width: 18,
//                                         child:
//                                             CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     : const Icon(Icons.save_outlined),

//                                 label: Text(
//                                   isSaving
//                                       ? "Saving..."
//                                       : "Save Topic",
//                                 ),

//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue,
//                                   foregroundColor: Colors.white,
//                                   minimumSize: const Size(0, 50),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.circular(8),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 25),
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
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';

// class TopicsForm extends StatefulWidget {
//   const TopicsForm({super.key});

//   @override
//   State<TopicsForm> createState() => _TopicsFormState();
// }

// class _TopicsFormState extends State<TopicsForm> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   final TextEditingController topicController =
//       TextEditingController();

//   final TextEditingController descriptionController =
//       TextEditingController();

//   final TextEditingController imageController =
//       TextEditingController();

//   final ImagePicker imagePicker = ImagePicker();

//   String status = "Active";

//   File? selectedImage;

//   bool isSaving = false;

//   @override
//   void dispose() {
//     topicController.dispose();
//     descriptionController.dispose();
//     imageController.dispose();

//     super.dispose();
//   }

//   // --------------------------------------------------
//   // Show image options
//   // --------------------------------------------------

//   void showImageOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (bottomSheetContext) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.link),
//                 title: const Text("Add Image URL"),
//                 onTap: () {
//                   Navigator.pop(bottomSheetContext);
//                   showUrlDialog();
//                 },
//               ),

//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text("Select Image from Gallery"),
//                 onTap: () {
//                   Navigator.pop(bottomSheetContext);
//                   pickImage();
//                 },
//               ),

//               if (selectedImage != null ||
//                   imageController.text.trim().isNotEmpty)
//                 ListTile(
//                   leading: const Icon(
//                     Icons.delete,
//                     color: Colors.red,
//                   ),
//                   title: const Text("Remove Image"),
//                   onTap: () {
//                     Navigator.pop(bottomSheetContext);

//                     setState(() {
//                       selectedImage = null;
//                       imageController.clear();
//                     });
//                   },
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // --------------------------------------------------
//   // Add image URL dialog
//   // --------------------------------------------------

//   void showUrlDialog() {
//     final TextEditingController urlController =
//         TextEditingController(
//       text: imageController.text,
//     );

//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: const Text("Add Image URL"),

//           content: TextField(
//             controller: urlController,
//             keyboardType: TextInputType.url,
//             decoration: const InputDecoration(
//               hintText: "https://example.com/image.jpg",
//               border: OutlineInputBorder(),
//             ),
//           ),

//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext);
//               },
//               child: const Text("Cancel"),
//             ),

//             ElevatedButton(
//               onPressed: () {
//                 final String url = urlController.text.trim();

//                 if (url.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text("Please enter image URL"),
//                     ),
//                   );

//                   return;
//                 }

//                 setState(() {
//                   // URL select hone par gallery file remove hogi
//                   selectedImage = null;

//                   imageController.text = url;
//                 });

//                 Navigator.pop(dialogContext);
//               },
//               child: const Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // --------------------------------------------------
//   // Pick image from gallery
//   // --------------------------------------------------

//   Future<void> pickImage() async {
//     try {
//       final XFile? image = await imagePicker.pickImage(
//         source: ImageSource.gallery,
//       );

//       if (image == null) {
//         return;
//       }

//       if (!mounted) {
//         return;
//       }

//       setState(() {
//         // Gallery image select hone par URL clear hoga
//         selectedImage = File(image.path);

//         imageController.clear();
//       });
//     } catch (error) {
//       if (!mounted) {
//         return;
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Image select error: $error"),
//         ),
//       );
//     }
//   }

//   // --------------------------------------------------
//   // Add topic API call
//   // --------------------------------------------------

//   Future<void> addTopic() async {
//     if (!formKey.currentState!.validate()) {
//       return;
//     }

//     final String imageUrl = imageController.text.trim();

//     // Image URL ya gallery image me se koi ek required hai
//     if (selectedImage == null && imageUrl.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please select an image or add image URL",
//           ),
//         ),
//       );

//       return;
//     }

//     setState(() {
//       isSaving = true;
//     });

//     try {
//       final Map<String, dynamic> response =
//           await ApiServices().addTopicAPI(
//         name: topicController.text.trim(),
//         description: descriptionController.text.trim(),
//         status: status,
//         imageUrl: imageUrl.isEmpty ? null : imageUrl,
//         imageFile: selectedImage,
//       );

//       debugPrint("Add Topic Response: $response");

//       if (!mounted) {
//         return;
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Topic added successfully"),
//         ),
//       );

//       Navigator.pop(context);
//     } catch (error) {
//       debugPrint("Add Topic Error: $error");

//       if (!mounted) {
//         return;
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Error: $error"),
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           isSaving = false;
//         });
//       }
//     }
//   }

//   // --------------------------------------------------
//   // Image preview
//   // --------------------------------------------------

//   Widget imagePreview() {
//     // Gallery image preview
//     if (selectedImage != null) {
//       return Image.file(
//         selectedImage!,
//         width: double.infinity,
//         height: 180,
//         fit: BoxFit.cover,
//       );
//     }

//     // URL image preview
//     if (imageController.text.trim().isNotEmpty) {
//       return Image.network(
//         imageController.text.trim(),
//         width: double.infinity,
//         height: 180,
//         fit: BoxFit.cover,
//         loadingBuilder: (
//           BuildContext context,
//           Widget child,
//           ImageChunkEvent? loadingProgress,
//         ) {
//           if (loadingProgress == null) {
//             return child;
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//         errorBuilder: (
//           BuildContext context,
//           Object error,
//           StackTrace? stackTrace,
//         ) {
//           return const Center(
//             child: Icon(
//               Icons.broken_image,
//               size: 50,
//             ),
//           );
//         },
//       );
//     }

//     // Default preview
//     return const Center(
//       child: Icon(
//         Icons.image_outlined,
//         size: 50,
//       ),
//     );
//   }

//   // --------------------------------------------------
//   // Build UI
//   // --------------------------------------------------

//   @override
//   Widget build(BuildContext context) {
//     final bool isDark =
//         Theme.of(context).brightness == Brightness.dark;

//     final Color backgroundColor = isDark
//         ? const Color(0xFF0F172A)
//         : const Color(0xFFF5F7FA);

//     final Color cardColor = isDark
//         ? const Color(0xFF172554)
//         : Colors.white;

//     final Color textColor = isDark
//         ? Colors.white
//         : Colors.black87;

//     final Color secondaryColor = isDark
//         ? Colors.white70
//         : Colors.black54;

//     final Color inputColor = isDark
//         ? const Color(0xFF1E3A5F)
//         : Colors.grey.shade100;

//     return Scaffold(
//       backgroundColor: backgroundColor,

//       appBar: Header(),

//       drawer: Drawer(),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),

//         child: Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               maxWidth: 700,
//             ),

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Create Topic",
//                   style: TextStyle(
//                     color: textColor,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   "Add a new topic to your notebook",
//                   style: TextStyle(
//                     color: secondaryColor,
//                     fontSize: 14,
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(24),

//                   decoration: BoxDecoration(
//                     color: cardColor,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: isDark
//                             ? Colors.black26
//                             : Colors.black12,
//                         blurRadius: 12,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),

//                   child: Form(
//                     key: formKey,

//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // --------------------------------------------------
//                         // Topic name
//                         // --------------------------------------------------

//                         Text(
//                           "Topic Name",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         TextFormField(
//                           controller: topicController,
//                           style: TextStyle(
//                             color: textColor,
//                           ),

//                           decoration: InputDecoration(
//                             hintText: "Enter topic name",
//                             hintStyle: TextStyle(
//                               color: secondaryColor,
//                             ),
//                             prefixIcon: const Icon(
//                               Icons.topic_outlined,
//                               color: Colors.blue,
//                             ),
//                             filled: true,
//                             fillColor: inputColor,
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           validator: (value) {
//                             if (value == null ||
//                                 value.trim().isEmpty) {
//                               return "Please enter topic name";
//                             }

//                             return null;
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // --------------------------------------------------
//                         // Description
//                         // --------------------------------------------------

//                         Text(
//                           "Description",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         TextFormField(
//                           controller: descriptionController,
//                           maxLines: 5,
//                           style: TextStyle(
//                             color: textColor,
//                           ),

//                           decoration: InputDecoration(
//                             hintText: "Enter topic description",
//                             hintStyle: TextStyle(
//                               color: secondaryColor,
//                             ),
//                             prefixIcon: const Padding(
//                               padding: EdgeInsets.only(
//                                 bottom: 75,
//                               ),
//                               child: Icon(
//                                 Icons.description_outlined,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             filled: true,
//                             fillColor: inputColor,
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           validator: (value) {
//                             if (value == null ||
//                                 value.trim().isEmpty) {
//                               return "Please enter description";
//                             }

//                             return null;
//                           },
//                         ),

//                         const SizedBox(height: 20),

//                         // --------------------------------------------------
//                         // Status
//                         // --------------------------------------------------

//                         Text(
//                           "Status",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         DropdownButtonFormField<String>(
//                           value: status,
//                           style: TextStyle(
//                             color: textColor,
//                           ),
//                           dropdownColor: cardColor,

//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(
//                               Icons.toggle_on_outlined,
//                               color: Colors.blue,
//                             ),
//                             filled: true,
//                             fillColor: inputColor,
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),

//                           items: const [
//                             DropdownMenuItem(
//                               value: "Active",
//                               child: Text("Active"),
//                             ),
//                             DropdownMenuItem(
//                               value: "Inactive",
//                               child: Text("Inactive"),
//                             ),
//                           ],

//                           onChanged: isSaving
//                               ? null
//                               : (value) {
//                                   if (value == null) {
//                                     return;
//                                   }

//                                   setState(() {
//                                     status = value;
//                                   });
//                                 },
//                         ),

//                         const SizedBox(height: 20),

//                         // --------------------------------------------------
//                         // Cover image
//                         // --------------------------------------------------

//                         Text(
//                           "Cover Image",
//                           style: TextStyle(
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         GestureDetector(
//                           onTap: isSaving
//                               ? null
//                               : showImageOptions,

//                           child: Container(
//                             height: 180,
//                             width: double.infinity,
//                             clipBehavior: Clip.antiAlias,

//                             decoration: BoxDecoration(
//                               color: inputColor,
//                               borderRadius:
//                                   BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: Colors.blue,
//                                 width: 1,
//                               ),
//                             ),

//                             child: imagePreview(),
//                           ),
//                         ),

//                         const SizedBox(height: 10),

//                         SizedBox(
//                           width: double.infinity,

//                           child: OutlinedButton.icon(
//                             onPressed: isSaving
//                                 ? null
//                                 : showImageOptions,

//                             icon: const Icon(
//                               Icons.add_photo_alternate,
//                             ),

//                             label: const Text(
//                               "Add Image URL or Select Gallery Image",
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 30),

//                         // --------------------------------------------------
//                         // Action buttons
//                         // --------------------------------------------------

//                         Row(
//                           children: [
//                             Expanded(
//                               child: OutlinedButton(
//                                 onPressed: isSaving
//                                     ? null
//                                     : () {
//                                         Navigator.pop(context);
//                                       },

//                                 style: OutlinedButton.styleFrom(
//                                   minimumSize: const Size(0, 50),
//                                   side: const BorderSide(
//                                     color: Colors.blue,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.circular(8),
//                                   ),
//                                 ),

//                                 child: const Text(
//                                   "Cancel",
//                                   style: TextStyle(
//                                     color: Colors.blue,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(width: 15),

//                             Expanded(
//                               child: ElevatedButton.icon(
//                                 onPressed: isSaving
//                                     ? null
//                                     : addTopic,

//                                 icon: isSaving
//                                     ? const SizedBox(
//                                         height: 18,
//                                         width: 18,
//                                         child:
//                                             CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     : const Icon(
//                                         Icons.save_outlined,
//                                       ),

//                                 label: Text(
//                                   isSaving
//                                       ? "Saving..."
//                                       : "Save Topic",
//                                 ),

//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue,
//                                   foregroundColor: Colors.white,
//                                   minimumSize: const Size(0, 50),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.circular(8),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 25),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }










import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';

class TopicsForm extends StatefulWidget {
  const TopicsForm({super.key});

  @override
  State<TopicsForm> createState() => _TopicsFormState();
}

class _TopicsFormState extends State<TopicsForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController topicController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  final TextEditingController imageController =
      TextEditingController();

  final ImagePicker imagePicker = ImagePicker();

  String status = "Active";

  File? selectedImage;

  bool isSaving = false;

  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryColor = Color(0xFF5B5CEB);

  @override
  void dispose() {
    topicController.dispose();
    descriptionController.dispose();
    imageController.dispose();

    super.dispose();
  }

  // ============================================================
  // IMAGE OPTIONS
  // ============================================================

  void showImageOptions() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor:
          isDark ? const Color(0xFF1B1B24) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF555563)
                        : const Color(0xFFD6D6DE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Add Cover Image",
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose how you want to add your image.",
                    style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color
                          ?.withOpacity(0.65),
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // URL
                _imageOption(
                  context,
                  icon: Icons.link_rounded,
                  title: "Add Image URL",
                  subtitle: "Use an image from the internet",
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    showUrlDialog();
                  },
                ),

                const SizedBox(height: 10),

                // Gallery
                _imageOption(
                  context,
                  icon: Icons.photo_library_outlined,
                  title: "Choose from Gallery",
                  subtitle: "Select an image from your device",
                  onTap: () {
                    Navigator.pop(bottomSheetContext);
                    pickImage();
                  },
                ),

                if (selectedImage != null ||
                    imageController.text.trim().isNotEmpty) ...[
                  const SizedBox(height: 10),

                  _imageOption(
                    context,
                    icon: Icons.delete_outline_rounded,
                    title: "Remove Image",
                    subtitle: "Remove the current cover image",
                    iconColor: Colors.redAccent,
                    onTap: () {
                      Navigator.pop(bottomSheetContext);

                      setState(() {
                        selectedImage = null;
                        imageController.clear();
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // IMAGE OPTION ITEM
  // ============================================================

  Widget _imageOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF24242F)
                : const Color(0xFFF7F7FB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (iconColor ?? primaryColor)
                      .withOpacity(0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? primaryColor,
                  size: 21,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color:
                            theme.textTheme.bodyLarge?.color,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: theme
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(0.60),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: theme
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withOpacity(0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // IMAGE URL DIALOG
  // ============================================================

  void showUrlDialog() {
    final theme = Theme.of(context);

    final TextEditingController urlController =
        TextEditingController(
      text: imageController.text,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Add Image URL",
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: TextField(
            controller: urlController,
            keyboardType: TextInputType.url,
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
            ),
            decoration: InputDecoration(
              hintText: "https://example.com/image.jpg",
              prefixIcon: const Icon(
                Icons.link_rounded,
                color: primaryColor,
              ),
              filled: true,
              fillColor: theme.brightness == Brightness.dark
                  ? const Color(0xFF24242F)
                  : const Color(0xFFF6F6FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            18,
            0,
            18,
            16,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final String url =
                    urlController.text.trim();

                if (url.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Please enter image URL"),
                    ),
                  );
                  return;
                }

                setState(() {
                  selectedImage = null;
                  imageController.text = url;
                });

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Add Image"),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // PICK IMAGE
  // ============================================================

  Future<void> pickImage() async {
    try {
      final XFile? image =
          await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) {
        return;
      }

      if (!mounted) {
        return;
      }

      setState(() {
        selectedImage = File(image.path);
        imageController.clear();
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Image select error: $error",
          ),
        ),
      );
    }
  }

  // ============================================================
  // ADD TOPIC API
  // ============================================================

  Future<void> addTopic() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final String imageUrl =
        imageController.text.trim();

    if (selectedImage == null &&
        imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select an image or add image URL",
          ),
        ),
      );

      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      final Map<String, dynamic> response =
          await ApiServices().addTopicAPI(
        name: topicController.text.trim(),
        description:
            descriptionController.text.trim(),
        status: status,
        imageUrl:
            imageUrl.isEmpty ? null : imageUrl,
        imageFile: selectedImage,
      );

      debugPrint(
        "Add Topic Response: $response",
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Topic added successfully"),
        ),
      );

      Navigator.pop(context);
    } catch (error) {
      debugPrint(
        "Add Topic Error: $error",
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: $error",
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  // ============================================================
  // IMAGE PREVIEW
  // ============================================================

  Widget imagePreview() {
    final theme = Theme.of(context);
    final isDark =
        theme.brightness == Brightness.dark;

    if (selectedImage != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            selectedImage!,
            fit: BoxFit.cover,
          ),

          Positioned(
            top: 12,
            right: 12,
            child: _imageRemoveButton(),
          ),
        ],
      );
    }

    if (imageController.text.trim().isNotEmpty) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageController.text.trim(),
            fit: BoxFit.cover,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) {
                return child;
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            },
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace? stackTrace,
            ) {
              return _emptyImagePreview(
                icon: Icons.broken_image_outlined,
                title: "Unable to load image",
              );
            },
          ),

          Positioned(
            top: 12,
            right: 12,
            child: _imageRemoveButton(),
          ),
        ],
      );
    }

    return _emptyImagePreview(
      icon: Icons.add_photo_alternate_outlined,
      title: "Add cover image",
      subtitle: "URL or gallery",
    );
  }

  // ============================================================
  // EMPTY IMAGE PREVIEW
  // ============================================================

  Widget _emptyImagePreview({
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    final theme = Theme.of(context);
    final isDark =
        theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.10),
              borderRadius:
                  BorderRadius.circular(17),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 27,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: TextStyle(
              color:
                  theme.textTheme.bodyLarge?.color,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: isDark
                    ? Colors.white54
                    : Colors.black45,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // IMAGE REMOVE BUTTON
  // ============================================================

  Widget _imageRemoveButton() {
    return Material(
      color: Colors.black.withOpacity(0.55),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          setState(() {
            selectedImage = null;
            imageController.clear();
          });
        },
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    required Color inputColor,
    required Color secondaryColor,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: secondaryColor,
        fontSize: 13,
      ),
      prefixIcon: Icon(
        icon,
        color: primaryColor,
        size: 20,
      ),
      filled: true,
      fillColor: inputColor,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1.2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
    );
  }

  // ============================================================
  // FIELD TITLE
  // ============================================================

  Widget _fieldTitle(
    String title,
    String? requiredText,
    Color textColor,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (requiredText != null) ...[
          const SizedBox(width: 4),
          Text(
            requiredText,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark =
        theme.brightness == Brightness.dark;

    final Color backgroundColor = isDark
        ? const Color(0xFF111118)
        : const Color(0xFFF7F7FB);

    final Color cardColor = isDark
        ? const Color(0xFF1B1B24)
        : Colors.white;

    final Color inputColor = isDark
        ? const Color(0xFF24242F)
        : const Color(0xFFF6F6FA);

    final Color textColor =
        theme.textTheme.bodyLarge?.color ??
            (isDark
                ? Colors.white
                : const Color(0xFF20202B));

    final Color secondaryColor =
        theme.textTheme.bodyMedium?.color
                ?.withOpacity(0.60) ??
            (isDark
                ? Colors.white60
                : Colors.black54);

    return Scaffold(
      backgroundColor: backgroundColor,

      // Header
      appBar: const Header(),

      // Drawer
      drawer: const Drawerbar(),

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior
                  .onDrag,
          padding: const EdgeInsets.fromLTRB(
            18,
            20,
            18,
            35,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 700,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // ==================================================
                  // PAGE TITLE
                  // ==================================================

                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: primaryColor
                              .withOpacity(0.10),
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.topic_rounded,
                          color: primaryColor,
                          size: 23,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create Topic",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 23,
                                fontWeight:
                                    FontWeight.w800,
                                letterSpacing: -0.4,
                              ),
                            ),

                            const SizedBox(height: 3),

                            Text(
                              "Organize your notes into a new topic",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // FORM CARD
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius:
                          BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xFF2A2A35)
                            : const Color(0xFFEAEAF2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            isDark ? 0.18 : 0.04,
                          ),
                          blurRadius: 25,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // ==================================================
                          // TOPIC NAME
                          // ==================================================

                          _fieldTitle(
                            "Topic Name",
                            "*",
                            textColor,
                          ),

                          const SizedBox(height: 9),

                          TextFormField(
                            controller: topicController,
                            enabled: !isSaving,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 13,
                            ),
                            textInputAction:
                                TextInputAction.next,
                            decoration:
                                _inputDecoration(
                              hint:
                                  "Enter topic name",
                              icon:
                                  Icons.topic_outlined,
                              inputColor:
                                  inputColor,
                              secondaryColor:
                                  secondaryColor,
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return "Please enter topic name";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // ==================================================
                          // DESCRIPTION
                          // ==================================================

                          _fieldTitle(
                            "Description",
                            "*",
                            textColor,
                          ),

                          const SizedBox(height: 9),

                          TextFormField(
                            controller:
                                descriptionController,
                            enabled: !isSaving,
                            maxLines: 4,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 13,
                              height: 1.45,
                            ),
                            decoration:
                                _inputDecoration(
                              hint:
                                  "Write a short description",
                              icon:
                                  Icons.description_outlined,
                              inputColor:
                                  inputColor,
                              secondaryColor:
                                  secondaryColor,
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return "Please enter description";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // ==================================================
                          // STATUS
                          // ==================================================

                          _fieldTitle(
                            "Status",
                            null,
                            textColor,
                          ),

                          const SizedBox(height: 9),

                          Row(
                            children: [
                              Expanded(
                                child:
                                    _statusButton(
                                  title: "Active",
                                  icon:
                                      Icons.check_circle_outline_rounded,
                                  selected:
                                      status ==
                                          "Active",
                                  onTap:
                                      isSaving
                                          ? null
                                          : () {
                                              setState(() {
                                                status =
                                                    "Active";
                                              });
                                            },
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child:
                                    _statusButton(
                                  title: "Inactive",
                                  icon:
                                      Icons.pause_circle_outline_rounded,
                                  selected:
                                      status ==
                                          "Inactive",
                                  onTap:
                                      isSaving
                                          ? null
                                          : () {
                                              setState(() {
                                                status =
                                                    "Inactive";
                                              });
                                            },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ==================================================
                          // COVER IMAGE
                          // ==================================================

                          _fieldTitle(
                            "Cover Image",
                            "*",
                            textColor,
                          ),

                          const SizedBox(height: 9),

                          GestureDetector(
                            onTap: isSaving
                                ? null
                                : showImageOptions,
                            child: Container(
                              width: double.infinity,
                              height: 190,
                              clipBehavior:
                                  Clip.antiAlias,
                              decoration:
                                  BoxDecoration(
                                color: inputColor,
                                borderRadius:
                                    BorderRadius.circular(
                                  17,
                                ),
                                border: Border.all(
                                  color: primaryColor
                                      .withOpacity(
                                    0.35,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child:
                                  imagePreview(),
                            ),
                          ),

                          const SizedBox(height: 10),

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child:
                                OutlinedButton.icon(
                              onPressed: isSaving
                                  ? null
                                  : showImageOptions,
                              icon: const Icon(
                                Icons
                                    .add_photo_alternate_outlined,
                                size: 19,
                              ),
                              label: const Text(
                                "Add Image",
                              ),
                              style:
                                  OutlinedButton.styleFrom(
                                foregroundColor:
                                    primaryColor,
                                side:
                                    const BorderSide(
                                  color: primaryColor,
                                ),
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    13,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // ==================================================
                          // BUTTONS
                          // ==================================================

                          Row(
                            children: [
                              Expanded(
                                child:
                                    OutlinedButton(
                                  onPressed:
                                      isSaving
                                          ? null
                                          : () {
                                              Navigator.pop(
                                                context,
                                              );
                                            },
                                  style:
                                      OutlinedButton
                                          .styleFrom(
                                    foregroundColor:
                                        textColor,
                                    minimumSize:
                                        const Size(
                                      0,
                                      50,
                                    ),
                                    side:
                                        BorderSide(
                                      color: isDark
                                          ? const Color(
                                              0xFF3A3A46,
                                            )
                                          : const Color(
                                              0xFFDCDCE5,
                                            ),
                                    ),
                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        14,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Cancel",
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                flex: 2,
                                child:
                                    ElevatedButton.icon(
                                  onPressed:
                                      isSaving
                                          ? null
                                          : addTopic,
                                  icon: isSaving
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child:
                                              CircularProgressIndicator(
                                            strokeWidth:
                                                2,
                                            color: Colors
                                                .white,
                                          ),
                                        )
                                      : const Icon(
                                          Icons
                                              .check_rounded,
                                          size: 19,
                                        ),
                                  label: Text(
                                    isSaving
                                        ? "Saving..."
                                        : "Create Topic",
                                  ),
                                  style:
                                      ElevatedButton
                                          .styleFrom(
                                    backgroundColor:
                                        primaryColor,
                                    foregroundColor:
                                        Colors.white,
                                    elevation: 0,
                                    minimumSize:
                                        const Size(
                                      0,
                                      50,
                                    ),
                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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

  // ============================================================
  // STATUS BUTTON
  // ============================================================

  Widget _statusButton({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final isDark =
        theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 180),
          height: 50,
          decoration: BoxDecoration(
            color: selected
                ? primaryColor.withOpacity(0.10)
                : isDark
                    ? const Color(0xFF24242F)
                    : const Color(0xFFF6F6FA),
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? primaryColor
                  : isDark
                      ? const Color(0xFF353541)
                      : const Color(0xFFE2E2EA),
              width: selected ? 1.3 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 19,
                color: selected
                    ? primaryColor
                    : theme
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.55),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: selected
                      ? primaryColor
                      : theme
                          .textTheme
                          .bodyLarge
                          ?.color,
                  fontSize: 12.5,
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}