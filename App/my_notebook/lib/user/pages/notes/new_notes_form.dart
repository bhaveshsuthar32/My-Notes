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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController =
      TextEditingController();

  final ImagePicker imagePicker = ImagePicker();

  final List<NoteBlock> blocks = [];

  List<Map<String, dynamic>> topics = [];

  int? selectedTopicId;

  String selectedStatus = "active";

  bool isLoadingTopics = true;
  bool isSaving = false;

  bool get isDark =>
      Theme.of(context).brightness == Brightness.dark;

  Color get backgroundColor =>
      isDark ? const Color(0xFF121212) : const Color(0xFFF7F8FA);

  Color get cardColor =>
      isDark ? const Color(0xFF1E1E1E) : Colors.white;

  Color get fieldColor =>
      isDark ? const Color(0xFF292929) : const Color(0xFFF7F8FA);

  Color get borderColor =>
      isDark ? Colors.grey.shade800 : Colors.grey.shade200;

  Color get secondaryTextColor =>
      isDark ? Colors.grey.shade400 : Colors.grey.shade600;

  Color get primaryTextColor =>
      isDark ? Colors.white : Colors.black87;

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

  Future<void> fetchTopics() async {
    try {
      final result = await ApiServices().getTopicsAPI();

      if (!mounted) return;

      setState(() {
        topics = List<Map<String, dynamic>>.from(result);
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

  void showAddFieldOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    8,
                    20,
                    12,
                  ),
                  child: Text(
                    "Add Field",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        isDark
                            ? Colors.blue.shade900
                            : Colors.blue.shade50,
                    child: Icon(
                      Icons.title,
                      color: isDark
                          ? Colors.blue.shade200
                          : Colors.blue.shade700,
                    ),
                  ),
                  title: Text(
                    "Heading",
                    style: TextStyle(
                      color: primaryTextColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    addTextBlock("heading");
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        isDark
                            ? Colors.purple.shade900
                            : Colors.purple.shade50,
                    child: Icon(
                      Icons.subtitles,
                      color: isDark
                          ? Colors.purple.shade200
                          : Colors.purple.shade700,
                    ),
                  ),
                  title: Text(
                    "Subtitle",
                    style: TextStyle(
                      color: primaryTextColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    addTextBlock("subtitle");
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        isDark
                            ? Colors.orange.shade900
                            : Colors.orange.shade50,
                    child: Icon(
                      Icons.notes,
                      color: isDark
                          ? Colors.orange.shade200
                          : Colors.orange.shade700,
                    ),
                  ),
                  title: Text(
                    "Paragraph",
                    style: TextStyle(
                      color: primaryTextColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    addTextBlock("content");
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        isDark
                            ? Colors.green.shade900
                            : Colors.green.shade50,
                    child: Icon(
                      Icons.image,
                      color: isDark
                          ? Colors.green.shade200
                          : Colors.green.shade700,
                    ),
                  ),
                  title: Text(
                    "Image",
                    style: TextStyle(
                      color: primaryTextColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    addImageBlock();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showImageOptions(int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    8,
                    20,
                    12,
                  ),
                  child: Text(
                    "Select Image",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        isDark
                            ? Colors.blue.shade900
                            : Colors.blue.shade50,
                    child: Icon(
                      Icons.photo_library,
                      color: isDark
                          ? Colors.blue.shade200
                          : Colors.blue.shade700,
                    ),
                  ),
                  title: Text(
                    "Choose from Gallery",
                    style: TextStyle(
                      color: primaryTextColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(index);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        isDark
                            ? Colors.green.shade900
                            : Colors.green.shade50,
                    child: Icon(
                      Icons.link,
                      color: isDark
                          ? Colors.green.shade200
                          : Colors.green.shade700,
                    ),
                  ),
                  title: Text(
                    "Add Image URL",
                    style: TextStyle(
                      color: primaryTextColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    addImageUrl(index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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

  Future<void> addImageUrl(int index) async {
    final String? url =
        await showDialog<String>(
      context: context,
      builder: (context) {
        return const ImageUrlDialog();
      },
    );

    if (url == null || url.trim().isEmpty) {
      return;
    }

    if (!mounted) return;

    setState(() {
      blocks[index].imageUrl = url.trim();
      blocks[index].imageFile = null;
    });
  }

  void removeBlock(int index) {
    blocks[index].dispose();

    setState(() {
      blocks.removeAt(index);
    });
  }

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
          block.controller.text.trim().isEmpty) {
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
        title: titleController.text.trim(),
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
        bottom: 14,
      ),
      padding:
          const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(
                    0.04,
                  ),
                  blurRadius: 8,
                  offset:
                      const Offset(0, 3),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(
              top: 12,
            ),
            child: Icon(
              Icons.drag_indicator,
              color:
                  secondaryTextColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              controller:
                  block.controller,
              maxLines: maxLines,
              style: TextStyle(
                color: primaryTextColor,
              ),
              decoration:
                  InputDecoration(
                labelText:
                    getBlockTitle(
                  block.type,
                ),
                hintText:
                    "Enter ${getBlockTitle(block.type).toLowerCase()}",
                hintStyle: TextStyle(
                  color:
                      secondaryTextColor,
                ),
                labelStyle: TextStyle(
                  color:
                      secondaryTextColor,
                ),
                filled: true,
                fillColor:
                    fieldColor,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                  borderSide:
                      BorderSide.none,
                ),
                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                  borderSide:
                      BorderSide(
                    color:
                        borderColor,
                  ),
                ),
                focusedBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                  borderSide:
                      const BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          IconButton(
            onPressed: () {
              removeBlock(index);
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageBlock(int index) {
    final NoteBlock block =
        blocks[index];

    Widget imageWidget;

    if (block.imageFile != null) {
      imageWidget = Image.file(
        block.imageFile!,
        height: 210,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (block.imageUrl != null &&
        block.imageUrl!.isNotEmpty) {
      imageWidget = Image.network(
        block.imageUrl!,
        height: 210,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder:
            (
          context,
          error,
          stackTrace,
        ) {
          return SizedBox(
            height: 210,
            child: Center(
              child: Icon(
                Icons.broken_image_outlined,
                size: 50,
                color:
                    secondaryTextColor,
              ),
            ),
          );
        },
      );
    } else {
      imageWidget = SizedBox(
        height: 210,
        child: Center(
          child: Icon(
            Icons.add_photo_alternate_outlined,
            size: 55,
            color:
                secondaryTextColor,
          ),
        ),
      );
    }

    return Container(
      key: ValueKey(block.id),
      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),
      padding:
          const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(
                    0.04,
                  ),
                  blurRadius: 8,
                  offset:
                      const Offset(0, 3),
                ),
              ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.drag_indicator,
                color:
                    secondaryTextColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.image_outlined,
                size: 20,
                color:
                    primaryTextColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  "Image",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        primaryTextColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  removeBlock(index);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              14,
            ),
            child: Container(
              width:
                  double.infinity,
              color:
                  fieldColor,
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
                Icons
                    .add_photo_alternate,
              ),
              label:
                  const Text(
                "Select Image",
              ),
              style:
                  OutlinedButton.styleFrom(
                foregroundColor:
                    isDark
                        ? Colors.blue.shade200
                        : Colors.blue,
                side:
                    BorderSide(
                  color:
                      isDark
                          ? Colors.blue.shade700
                          : Colors.blue.shade200,
                ),
                padding:
                    const EdgeInsets
                        .symmetric(
                  vertical: 13,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBlocksSection() {
    if (blocks.isEmpty) {
      return Container(
        padding:
            const EdgeInsets.all(28),
        decoration:
            BoxDecoration(
          color: cardColor,
          borderRadius:
              BorderRadius.circular(
            16,
          ),
          border:
              Border.all(
            color: borderColor,
          ),
        ),
        child:
            Column(
          children: [
            Icon(
              Icons.note_add_outlined,
              size: 45,
              color:
                  secondaryTextColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "No fields added yet",
              style: TextStyle(
                color:
                    secondaryTextColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Add heading, paragraph, subtitle or image",
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                color:
                    secondaryTextColor,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemCount:
          blocks.length,
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
      dropdownColor:
          cardColor,
      style: TextStyle(
        color: primaryTextColor,
      ),
      decoration:
          InputDecoration(
        labelText:
            "Select Topic",
        labelStyle: TextStyle(
          color:
              secondaryTextColor,
        ),
        prefixIcon:
            Icon(
          Icons.topic_outlined,
          color:
              secondaryTextColor,
        ),
        filled: true,
        fillColor:
            fieldColor,
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            14,
          ),
          borderSide:
              BorderSide.none,
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            14,
          ),
          borderSide:
              BorderSide(
            color:
                borderColor,
          ),
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            14,
          ),
          borderSide:
              const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
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

        return DropdownMenuItem<int>(
          value: topicId,
          child: Text(
            topic["name"].toString(),
            style: TextStyle(
              color:
                  primaryTextColor,
            ),
          ),
        );
      }).toList(),
      onChanged:
          (value) {
        setState(() {
          selectedTopicId =
              value;
        });
      },
      validator:
          (value) {
        if (value == null) {
          return
              "Please select a topic";
        }

        return null;
      },
    );
  }

  InputDecoration fieldDecoration({
    required String label,
    required String hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(
        color: secondaryTextColor,
      ),
      hintStyle: TextStyle(
        color: secondaryTextColor,
      ),
      prefixIcon:
          icon == null
              ? null
              : Icon(
                  icon,
                  color:
                      secondaryTextColor,
                ),
      filled: true,
      fillColor: fieldColor,
      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          14,
        ),
        borderSide:
            BorderSide.none,
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          14,
        ),
        borderSide:
            BorderSide(
          color: borderColor,
        ),
      ),
      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          14,
        ),
        borderSide:
            const BorderSide(
          color: Colors.blue,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          backgroundColor,
      appBar:
          AppBar(
        elevation: 0,
        backgroundColor:
            cardColor,
        foregroundColor:
            primaryTextColor,
        centerTitle:
            false,
        title:
            const Text(
          "Add Notes",
          style:
              TextStyle(
            fontSize: 22,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
      body:
          SafeArea(
        child:
            SingleChildScrollView(
          padding:
              const EdgeInsets.all(
            20,
          ),
          child:
              Center(
            child:
                ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 850,
              ),
              child:
                  Form(
                key:
                    _formKey,
                child:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.all(
                        20,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            cardColor,
                        borderRadius:
                            BorderRadius
                                .circular(
                          20,
                        ),
                        border:
                            Border.all(
                          color:
                              borderColor,
                        ),
                        boxShadow:
                            isDark
                                ? []
                                : [
                                    BoxShadow(
                                      color:
                                          Colors.black.withOpacity(
                                        0.04,
                                      ),
                                      blurRadius:
                                          12,
                                      offset:
                                          const Offset(
                                        0,
                                        4,
                                      ),
                                    ),
                                  ],
                      ),
                      child:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .stretch,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.all(
                                  10,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color:
                                      isDark
                                          ? Colors.blue.shade900
                                          : Colors.blue.shade50,
                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                child:
                                    Icon(
                                  Icons.edit_note,
                                  color:
                                      isDark
                                          ? Colors.blue.shade200
                                          : Colors.blue.shade700,
                                  size:
                                      26,
                                ),
                              ),
                              const SizedBox(
                                width:
                                    12,
                              ),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    "Create a new note",
                                    style:
                                        TextStyle(
                                      fontSize:
                                          18,
                                      fontWeight:
                                          FontWeight.bold,
                                      color:
                                          primaryTextColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height:
                                        3,
                                  ),
                                  Text(
                                    "Add your note details",
                                    style:
                                        TextStyle(
                                      color:
                                          secondaryTextColor,
                                      fontSize:
                                          13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height:
                                22,
                          ),
                          TextFormField(
                            controller:
                                titleController,
                            style:
                                TextStyle(
                              color:
                                  primaryTextColor,
                            ),
                            decoration:
                                fieldDecoration(
                              label:
                                  "Title",
                              hint:
                                  "Enter note title",
                              icon:
                                  Icons.title,
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
                            height:
                                16,
                          ),
                          buildTopicDropdown(),
                          const SizedBox(
                            height:
                                16,
                          ),
                          DropdownButtonFormField<String>(
                            value:
                                selectedStatus,
                            dropdownColor:
                                cardColor,
                            style:
                                TextStyle(
                              color:
                                  primaryTextColor,
                            ),
                            decoration:
                                fieldDecoration(
                              label:
                                  "Status",
                              hint:
                                  "Select status",
                              icon:
                                  Icons.toggle_on_outlined,
                            ),
                            items:
                                const [
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height:
                          24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                              Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                "Note Content",
                                style:
                                    TextStyle(
                                  fontSize:
                                      20,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      primaryTextColor,
                                ),
                              ),
                              const SizedBox(
                                height:
                                    3,
                              ),
                              Text(
                                "Arrange your content in any order",
                                style:
                                    TextStyle(
                                  color:
                                      secondaryTextColor,
                                  fontSize:
                                      13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
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
                          style:
                              ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal:
                                  16,
                              vertical:
                                  13,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height:
                          16,
                    ),
                    buildBlocksSection(),
                    const SizedBox(
                      height:
                          28,
                    ),
                    SizedBox(
                      height:
                          54,
                      child:
                          ElevatedButton.icon(
                        onPressed:
                            isSaving
                                ? null
                                : saveNote,
                        icon:
                            isSaving
                                ? const SizedBox(
                                    height:
                                        22,
                                    width:
                                        22,
                                    child:
                                        CircularProgressIndicator(
                                      strokeWidth:
                                          2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.save_outlined,
                                  ),
                        label:
                            Text(
                          isSaving
                              ? "Saving..."
                              : "Save Note",
                          style:
                              const TextStyle(
                            fontSize:
                                16,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                        style:
                            ElevatedButton.styleFrom(
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
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
      ),
    );
  }
}

class ImageUrlDialog extends StatefulWidget {
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

  bool get isDark =>
      Theme.of(context).brightness ==
      Brightness.dark;

  Color get cardColor =>
      isDark
          ? const Color(0xFF1E1E1E)
          : Colors.white;

  Color get textColor =>
      isDark
          ? Colors.white
          : Colors.black87;

  Color get fieldColor =>
      isDark
          ? const Color(0xFF292929)
          : const Color(0xFFF7F8FA);

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
      backgroundColor:
          cardColor,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),
      title:
          Text(
        "Add Image URL",
        style:
            TextStyle(
          fontWeight:
              FontWeight.bold,
          color:
              textColor,
        ),
      ),
      content:
          TextField(
        controller:
            urlController,
        keyboardType:
            TextInputType.url,
        style:
            TextStyle(
          color:
              textColor,
        ),
        decoration:
            InputDecoration(
          hintText:
              "https://example.com/image.jpg",
          hintStyle:
              TextStyle(
            color:
                isDark
                    ? Colors.grey.shade500
                    : Colors.grey.shade600,
          ),
          prefixIcon:
              Icon(
            Icons.link,
            color:
                isDark
                    ? Colors.grey.shade400
                    : Colors.grey.shade700,
          ),
          filled:
              true,
          fillColor:
              fieldColor,
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              12,
            ),
            borderSide:
                BorderSide.none,
          ),
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
                urlController.text.trim();

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
