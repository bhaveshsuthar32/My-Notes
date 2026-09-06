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


import 'package:flutter/material.dart';
import 'package:my_notebook/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';

class TopicsPage extends StatefulWidget {
  const TopicsPage({super.key});

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  List<dynamic> topics = [];

  bool isloading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getTopics();
  }

  Future<void> getTopics() async {
    try {
      final data = await ApiServices().getTopicsAPI();

      setState(() {
        topics = data;
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    // final backgroundColor = isDark
    //     ? const Color(0xFF0F172A)
    //     : const Color(0xFFF5F7FA);

    final cardColor = isDark
        // ? const Color(0xFF172554)
          ? Colors.grey.shade900
        : Colors.white;

    final titleColor = isDark
        ? Colors.white
        : Colors.black87;

    final descriptionColor = isDark
        ? Colors.white70
        : Colors.black54;

    return Scaffold(
      // backgroundColor: backgroundColor,

      appBar: Header(),

      drawer: Drawerbar(),

      body: errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark ? Colors.red[200] : Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          : isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : topics.isEmpty
                  ? Center(
                      child: Text(
                        "No Topics Found",
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        final topic = topics[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),

                          decoration: BoxDecoration(
                            color: cardColor,

                            borderRadius: BorderRadius.circular(16),

                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Colors.black26
                                    : Colors.black12,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(14),

                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [
                                // IMAGE
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(12),

                                    child: topic['coverimage'] != null
                                        ? Image.network(
                                            topic['coverimage'].toString(),
                                            height: 110,
                                            fit: BoxFit.cover,

                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                height: 110,
                                                color: isDark
                                                    ? Colors.blueGrey[900]
                                                    : Colors.grey[200],
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  color: isDark
                                                      ? Colors.white54
                                                      : Colors.grey,
                                                  size: 35,
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            height: 110,
                                            color: isDark
                                                ? Colors.blueGrey[900]
                                                : Colors.grey[200],
                                            child: const Icon(
                                              Icons.image,
                                              size: 35,
                                            ),
                                          ),
                                  ),
                                ),

                                const SizedBox(width: 14),

                                // RIGHT SIDE
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // TITLE
                                      Text(
                                        topic['name'].toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,

                                        style: TextStyle(
                                          color: titleColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      // DESCRIPTION
                                      Text(
                                        topic['description'].toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,

                                        style: TextStyle(
                                          color: descriptionColor,
                                          fontSize: 14,
                                          height: 1.4,
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      // BUTTONS
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,

                                        children: [
                                          IconButton(
                                            tooltip: "Edit",
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: isDark
                                                  ? Colors.lightBlue[200]
                                                  : Colors.blue,
                                            ),
                                          ),

                                          IconButton(
                                            tooltip: "Delete",
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.delete_outline,
                                              color: isDark
                                                  ? Colors.red[300]
                                                  : Colors.red,
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
                        );
                      },
                    ),
    );
  }
}