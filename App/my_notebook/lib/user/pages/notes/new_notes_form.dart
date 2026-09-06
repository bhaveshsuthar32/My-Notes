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








import 'package:flutter/material.dart';

class NewNotes extends StatefulWidget {
  const NewNotes({super.key});

  @override
  State<NewNotes> createState() => _NewNotesState();
}

class _NewNotesState extends State<NewNotes> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final contentController = TextEditingController();

  String? selectedTopic;
  String status = "Active";

  final List<String> topics = [
    "Flutter",
    "Node.js",
    "Java",
    "English",
  ];

  final List<String> statusList = [
    "Active",
    "Inactive",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Note"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                /// Title
                
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                ),

                const SizedBox(height: 16),

                /// Subtitle
                TextFormField(
                  controller: subtitleController,
                  decoration: const InputDecoration(
                    labelText: "Subtitle",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.subtitles),
                  ),
                ),

                const SizedBox(height: 16),

                /// Content
                TextFormField(
                  controller: contentController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: "Content",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                ),

                const SizedBox(height: 16),

                /// Topic Dropdown
                DropdownButtonFormField<String>(
                  value: selectedTopic,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Topic",
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: topics.map((topic) {
                    return DropdownMenuItem(
                      value: topic,
                      child: Text(topic),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTopic = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                /// Status Dropdown
                DropdownButtonFormField<String>(
                  value: status,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Status",
                    prefixIcon: Icon(Icons.toggle_on),
                  ),
                  items: statusList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      status = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                /// Image Picker UI
                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: InkWell(
                    onTap: () {
                      // TODO: Pick Images
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Select Images",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: width,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO Save API
                    },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      "Save Note",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}