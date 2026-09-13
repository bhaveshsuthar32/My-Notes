import 'package:flutter/material.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';

class TopicsForm extends StatefulWidget {
  const TopicsForm({super.key});

  @override
  State<TopicsForm> createState() => _TopicsFormState();
}

class _TopicsFormState extends State<TopicsForm> {
  final formKey = GlobalKey<FormState>();

  final topicController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  String status = "Active";

  @override
  void dispose() {
    topicController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  Future<void> addTopic() async {
    try {
      final res = await ApiServices().addTopicAPI(
        topicController.text.trim(),
        descriptionController.text.trim(),
        imageController.text.trim(),
        "Active",
      );

      print(res);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Topic added successfully")));
    } catch (e) {
      print(e);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? const Color(0xFF0F172A)
        : const Color(0xFFF5F7FA);

    final cardColor = isDark ? const Color(0xFF172554) : Colors.white;

    final textColor = isDark ? Colors.white : Colors.black87;

    final secondaryColor = isDark ? Colors.white70 : Colors.black54;

    final inputColor = isDark ? const Color(0xFF1E3A5F) : Colors.grey.shade100;

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: Header(),

      drawer: Drawerbar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // Page Title
                Text(
                  "Create Topic",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Add a new topic to your notebook",
                  style: TextStyle(color: secondaryColor, fontSize: 14),
                ),

                const SizedBox(height: 25),

                // Form Card
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(8),

                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black26 : Colors.black12,
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Form(
                    key: formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // Topic Name
                        Text(
                          "Topic Name",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextFormField(
                          controller: topicController,

                          style: TextStyle(color: textColor),

                          decoration: InputDecoration(
                            hintText: "Enter topic name",
                            hintStyle: TextStyle(color: secondaryColor),

                            prefixIcon: Icon(
                              Icons.topic_outlined,
                              color: isDark
                                  ? Colors.lightBlue[200]
                                  : Colors.blue,
                            ),

                            filled: true,
                            fillColor: inputColor,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter topic name";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Description
                        Text(
                          "Description",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextFormField(
                          controller: descriptionController,

                          maxLines: 5,

                          style: TextStyle(color: textColor),

                          decoration: InputDecoration(
                            hintText: "Enter topic description",
                            hintStyle: TextStyle(color: secondaryColor),

                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 75),

                              child: Icon(
                                Icons.description_outlined,
                                color: isDark
                                    ? Colors.lightBlue[200]
                                    : Colors.blue,
                              ),
                            ),

                            filled: true,
                            fillColor: inputColor,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter description";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Status
                        Text(
                          "Status",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 8),

                        DropdownButtonFormField<String>(
                          value: status,

                          style: TextStyle(color: textColor),

                          dropdownColor: cardColor,

                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.toggle_on_outlined,
                              color: isDark
                                  ? Colors.lightBlue[200]
                                  : Colors.blue,
                            ),

                            filled: true,
                            fillColor: inputColor,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),

                          items: const [
                            DropdownMenuItem(
                              value: "Active",
                              child: Text("Active"),
                            ),
                            DropdownMenuItem(
                              value: "Inactive",
                              child: Text("Inactive"),
                            ),
                          ],

                          onChanged: (value) {
                            setState(() {
                              status = value!;
                            });
                          },
                        ),

                        const SizedBox(height: 20),

                        // Image URL
                        Text(
                          "Cover Image URL",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // TextFormField(
                        //   controller: imageController,

                        //   style: TextStyle(
                        //     color: textColor,
                        //   ),

                        //   decoration: InputDecoration(
                        //     hintText:
                        //         "Enter image URL",
                        //     hintStyle: TextStyle(
                        //       color: secondaryColor,
                        //     ),

                        //     prefixIcon: Icon(
                        //       Icons.image_outlined,
                        //       color: isDark
                        //           ? Colors.lightBlue[200]
                        //           : Colors.blue,
                        //     ),

                        //     filled: true,
                        //     fillColor: inputColor,

                        //     border: OutlineInputBorder(
                        //       borderRadius:
                        //           BorderRadius.circular(8),
                        //       borderSide:
                        //           BorderSide.none,
                        //     ),
                        //   ),
                        // ),
                        // TextFormField(
                        //   controller: imageController,
                        //   style: TextStyle(color: textColor),
                        //   decoration: InputDecoration(
                        //     hintText: "Enter image URL",
                        //     hintStyle: TextStyle(color: secondaryColor),
                        //     prefixIcon: Icon(
                        //       Icons.image_outlined,
                        //       color: isDark
                        //           ? Colors.lightBlue[200]
                        //           : Colors.blue,
                        //     ),
                        //     filled: true,
                        //     fillColor: inputColor,
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //       borderSide: BorderSide.none,
                        //     ),
                        //   ),

                        //   // URL type karte hi preview update hoga
                        //   onChanged: (value) {
                        //     setState(() {});
                        //   },
                        // ),

                        // const SizedBox(height: 12),

                        // // Image preview
                        // Container(
                        //   height: 150,
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8),
                        //     color: inputColor,
                        //   ),
                        //   child: imageController.text.trim().isNotEmpty
                        //       ? Image.network(
                        //           imageController.text.trim(),
                        //           fit: BoxFit.cover,
                        //           errorBuilder: (context, error, stackTrace) {
                        //             return const Icon(Icons.image, size: 50);
                        //           },
                        //         )
                        //       : const Icon(Icons.image, size: 50),
                        // ),


// ---------------------


TextFormField(
  controller: imageController,
  style: TextStyle(color: textColor),
  keyboardType: TextInputType.url,

  decoration: InputDecoration(
    hintText: "Enter image URL",
    hintStyle: TextStyle(color: secondaryColor),

    prefixIcon: Icon(
      Icons.image_outlined,
      color: isDark ? Colors.lightBlue[200] : Colors.blue,
    ),

    filled: true,
    fillColor: inputColor,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
  ),

  // URL type karte hi preview update hoga
  onChanged: (value) {
    setState(() {});
  },
),

const SizedBox(height: 12),

// Image preview
Container(
  height: 180,
  width: double.infinity,
  clipBehavior: Clip.antiAlias,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: inputColor,
  ),
  child: imageController.text.trim().isNotEmpty
      ? Image.network(
          imageController.text.trim(),
          fit: BoxFit.cover,

          // Image load hone tak
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },

          // URL galat hone par
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image,
                size: 50,
              ),
            );
          },
        )
      : const Center(
          child: Icon(
            Icons.image,
            size: 50,
          ),
        ),
),






























// ----------------------



                        const SizedBox(height: 30),

                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },

                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(0, 50),

                                  side: BorderSide(
                                    color: isDark
                                        ? Colors.lightBlue.shade200
                                        : Colors.blue,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),

                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.lightBlue.shade200
                                        : Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: addTopic,

                                icon: const Icon(Icons.save_outlined),

                                label: const Text("Save Topic"),

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,

                                  foregroundColor: Colors.white,

                                  minimumSize: const Size(0, 50),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
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

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
