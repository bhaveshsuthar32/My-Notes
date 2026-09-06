
// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';

// class Admin extends StatefulWidget {
//   const Admin({super.key});

//   @override
//   State<Admin> createState() => _AdminState();
// }

// class _AdminState extends State<Admin> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Header(),
//       drawer: Drawerbar(),

//       body: Text("admin side"),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/theme/theme_provider.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';
import 'package:provider/provider.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List<dynamic> users = [];
  bool isloading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    try {
      final data = await ApiServices().getUserAPI();

      setState(() {
        users = data;
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
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    final bgColor = isDark
        ? const Color(0xFF0F172A)
        : const Color(0xFFF5F7FA);

    final cardColor = isDark
        ? const Color(0xFF172554)
        : Colors.white;

    final textColor = isDark ? Colors.white : Colors.black87;
    final secondaryColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: Header(),
      drawer: Drawerbar(),

      body: errorMessage != null
          ? Center(
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor),
              ),
            )
          : isloading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Admin Panel",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Manage registered users",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Total Users
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(4),
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

                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.blue.withOpacity(0.20)
                                : Colors.blue.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Icon(
                            Icons.people_outline,
                            size: 28,
                            color: isDark
                                ? Colors.lightBlue[200]
                                : Colors.blue,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Users",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 3),

                            Text(
                              users.length.toString(),
                              style: TextStyle(
                                color: textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Users Table
                  Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(4),
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

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),

                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child: DataTable(
                          columnSpacing: 20,
                          horizontalMargin: 12,
                          headingRowHeight: 55,
                          dataRowMinHeight: 60,
                          dataRowMaxHeight: 70,

                          headingRowColor:
                              WidgetStateProperty.all(
                            isDark
                                ? const Color(0xFF1E3A8A)
                                : const Color(0xFFEFF6FF),
                          ),

                          columns: [
                            DataColumn(
                              label: Text(
                                "Sr. No.",
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "User Name",
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Email",
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Role",
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            DataColumn(
                              label: Text(
                                "Action",
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],

                          rows: List.generate(users.length, (index) {
                            final user = users[index];
                            final isAdmin = user["isadmin"] == "Admin";

                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                DataCell(
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundColor: isDark
                                            ? Colors.blue.withOpacity(0.25)
                                            : Colors.blue.withOpacity(0.10),

                                        child: Text(
                                          user["firstname"][0]
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.lightBlue[200]
                                                : Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 10),

                                      Text(
                                        "${user["firstname"]} ${user["lastname"]}",
                                        style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                DataCell(
                                  Text(
                                    user["email"].toString(),
                                    style: TextStyle(
                                      color: secondaryColor,
                                    ),
                                  ),
                                ),

                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),

                                    decoration: BoxDecoration(
                                      color: isAdmin
                                          ? Colors.orange.withOpacity(0.15)
                                          : Colors.green.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    child: Text(
                                      isAdmin ? "Admin" : "User",
                                      style: TextStyle(
                                        color: isAdmin
                                            ? Colors.orange
                                            : Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                DataCell(
                                  Row(
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
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}