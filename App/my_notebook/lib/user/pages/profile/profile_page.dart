// import 'package:flutter/material.dart';
// import 'package:my_notebook/services/api_services.dart';
// import 'package:my_notebook/user/pages/login/login.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   bool isDarkMode = false;
//   bool notificationsEnabled = true;

//   String selectedLanguage = "English";

//   @override
//   void initState() {
//     super.initState();

//     isDarkMode =
//         WidgetsBinding.instance.platformDispatcher.platformBrightness ==
//             Brightness.dark;
//   }

//   Future<void> logout() async {
//     final shouldLogout = await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         final theme = Theme.of(context);

//         return AlertDialog(
//           backgroundColor: theme.dialogBackgroundColor,
//           title: const Text("Logout"),
//           content: const Text(
//             "Are you sure you want to logout?",
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context, false);
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context, true);
//               },
//               child: const Text("Logout"),
//             ),
//           ],
//         );
//       },
//     );

//     if (shouldLogout != true) return;

//     try {
//       await ApiServices().logoutAPI();

//       if (!mounted) return;

//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const LoginPage(),
//         ),
//         (route) => false,
//       );
//     } catch (e) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             e.toString().replaceFirst("Exception: ", ""),
//           ),
//         ),
//       );
//     }
//   }

//   void showLanguageDialog() {
//     final languages = [
//       "English",
//       "Hindi",
//       "Gujarati",
//     ];

//     showDialog(
//       context: context,
//       builder: (context) {
//         final theme = Theme.of(context);

//         return AlertDialog(
//           backgroundColor: theme.dialogBackgroundColor,
//           title: const Text("Select Language"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: languages.map((language) {
//               return RadioListTile<String>(
//                 value: language,
//                 groupValue: selectedLanguage,
//                 title: Text(language),
//                 onChanged: (value) {
//                   if (value == null) return;

//                   setState(() {
//                     selectedLanguage = value;
//                   });

//                   Navigator.pop(context);
//                 },
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }

//   void showEditProfileDialog() {
//     final firstNameController =
//         TextEditingController(text: "Bhavesh");

//     final lastNameController =
//         TextEditingController(text: "Suthar");

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Edit Profile"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: firstNameController,
//                 decoration: const InputDecoration(
//                   labelText: "First Name",
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextField(
//                 controller: lastNameController,
//                 decoration: const InputDecoration(
//                   labelText: "Last Name",
//                 ),
//               ),
//             ],
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
//                 Navigator.pop(context);

//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("Profile updated"),
//                   ),
//                 );
//               },
//               child: const Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.fromLTRB(
//             20,
//             20,
//             20,
//             30,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // --------------------------------------------------
//               // PROFILE HEADER
//               // --------------------------------------------------
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(22),
//                 decoration: BoxDecoration(
//                   color: theme.cardColor,
//                   borderRadius: BorderRadius.circular(24),
//                   border: Border.all(
//                     color: theme.dividerColor.withOpacity(0.15),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         CircleAvatar(
//                           radius: 48,
//                           backgroundColor:
//                               colorScheme.primary.withOpacity(0.12),
//                           child: Icon(
//                             Icons.person_rounded,
//                             size: 52,
//                             color: colorScheme.primary,
//                           ),
//                         ),

//                         Positioned(
//                           right: 0,
//                           bottom: 0,
//                           child: Container(
//                             padding: const EdgeInsets.all(7),
//                             decoration: BoxDecoration(
//                               color: colorScheme.primary,
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: theme.cardColor,
//                                 width: 3,
//                               ),
//                             ),
//                             child: Icon(
//                               Icons.edit_rounded,
//                               size: 15,
//                               color: colorScheme.onPrimary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 15),

//                     Text(
//                       "Bhavesh Suthar",
//                       style: theme.textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),

//                     const SizedBox(height: 5),

//                     Text(
//                       "bhavesh@example.com",
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         color: theme.textTheme.bodyMedium?.color
//                             ?.withOpacity(0.6),
//                       ),
//                     ),

//                     const SizedBox(height: 18),

//                     SizedBox(
//                       width: double.infinity,
//                       height: 45,
//                       child: OutlinedButton.icon(
//                         onPressed: showEditProfileDialog,
//                         icon: const Icon(
//                           Icons.edit_outlined,
//                           size: 18,
//                         ),
//                         label: const Text("Edit Profile"),
//                         style: OutlinedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 25),

//               // --------------------------------------------------
//               // SETTINGS
//               // --------------------------------------------------
//               Text(
//                 "Settings",
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               _settingsCard(
//                 context,
//                 children: [
//                   _settingsTile(
//                     context,
//                     icon: Icons.dark_mode_outlined,
//                     title: "Dark Mode",
//                     subtitle: "Use dark theme across the app",
//                     trailing: Switch(
//                       value: isDarkMode,
//                       onChanged: (value) {
//                         setState(() {
//                           isDarkMode = value;
//                         });

//                         // TODO:
//                         // Connect this with your ThemeProvider
//                         // so the complete application changes theme.
//                       },
//                     ),
//                   ),

//                   _divider(context),

//                   _settingsTile(
//                     context,
//                     icon: Icons.language_rounded,
//                     title: "Language",
//                     subtitle: selectedLanguage,
//                     trailing: const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 16,
//                     ),
//                     onTap: showLanguageDialog,
//                   ),

//                   _divider(context),

//                   _settingsTile(
//                     context,
//                     icon: Icons.notifications_outlined,
//                     title: "Notifications",
//                     subtitle: "Receive app notifications",
//                     trailing: Switch(
//                       value: notificationsEnabled,
//                       onChanged: (value) {
//                         setState(() {
//                           notificationsEnabled = value;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 25),

//               // --------------------------------------------------
//               // ACCOUNT
//               // --------------------------------------------------
//               Text(
//                 "Account",
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),

//               const SizedBox(height: 12),

//               _settingsCard(
//                 context,
//                 children: [
//                   _settingsTile(
//                     context,
//                     icon: Icons.lock_outline_rounded,
//                     title: "Privacy & Security",
//                     subtitle: "Manage your account security",
//                     trailing: const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 16,
//                     ),
//                     onTap: () {},
//                   ),

//                   _divider(context),

//                   _settingsTile(
//                     context,
//                     icon: Icons.help_outline_rounded,
//                     title: "Help & Support",
//                     subtitle: "Get help with My Notebook",
//                     trailing: const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 16,
//                     ),
//                     onTap: () {},
//                   ),

//                   _divider(context),

//                   _settingsTile(
//                     context,
//                     icon: Icons.info_outline_rounded,
//                     title: "About",
//                     subtitle: "My Notebook",
//                     trailing: const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 16,
//                     ),
//                     onTap: () {},
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 25),

//               // --------------------------------------------------
//               // LOGOUT
//               // --------------------------------------------------
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: OutlinedButton.icon(
//                   onPressed: logout,
//                   icon: const Icon(
//                     Icons.logout_rounded,
//                   ),
//                   label: const Text(
//                     "Logout",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: colorScheme.error,
//                     side: BorderSide(
//                       color: colorScheme.error.withOpacity(0.5),
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Center(
//                 child: Text(
//                   "My Notebook • Version 1.0.0",
//                   style: theme.textTheme.bodySmall?.copyWith(
//                     color: theme.textTheme.bodySmall?.color
//                         ?.withOpacity(0.45),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _settingsCard(
//     BuildContext context, {
//     required List<Widget> children,
//   }) {
//     final theme = Theme.of(context);

//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: theme.dividerColor.withOpacity(0.12),
//         ),
//       ),
//       child: Column(
//         children: children,
//       ),
//     );
//   }

//   Widget _settingsTile(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     Widget? trailing,
//     VoidCallback? onTap,
//   }) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 5,
//       ),
//       onTap: onTap,
//       leading: Container(
//         width: 42,
//         height: 42,
//         decoration: BoxDecoration(
//           color: colorScheme.primary.withOpacity(0.10),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(
//           icon,
//           color: colorScheme.primary,
//           size: 22,
//         ),
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       subtitle: Padding(
//         padding: const EdgeInsets.only(top: 3),
//         child: Text(
//           subtitle,
//           style: theme.textTheme.bodySmall?.copyWith(
//             color: theme.textTheme.bodySmall?.color
//                 ?.withOpacity(0.6),
//           ),
//         ),
//       ),
//       trailing: trailing,
//     );
//   }

//   Widget _divider(BuildContext context) {
//     return Divider(
//       height: 1,
//       indent: 74,
//       endIndent: 16,
//       color: Theme.of(context).dividerColor.withOpacity(0.12),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/theme/theme_provider.dart';
import 'package:my_notebook/user/pages/login/login.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationsEnabled = true;

  String selectedLanguage = "English";

  // ============================================================
  // LOGOUT
  // ============================================================

  Future<void> logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return AlertDialog(
          backgroundColor: theme.dialogBackgroundColor,
          title: const Text("Logout"),
          content: const Text(
            "Are you sure you want to logout?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) return;

    try {
      await ApiServices().logoutAPI();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst("Exception: ", ""),
          ),
        ),
      );
    }
  }

  // ============================================================
  // LANGUAGE DIALOG
  // ============================================================

  void showLanguageDialog() {
    final languages = [
      "English",
      "Hindi",
      "Gujarati",
    ];

    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);

        return AlertDialog(
          backgroundColor: theme.dialogBackgroundColor,
          title: const Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((language) {
              return RadioListTile<String>(
                value: language,
                groupValue: selectedLanguage,
                title: Text(language),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    selectedLanguage = value;
                  });

                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // ============================================================
  // EDIT PROFILE DIALOG
  // ============================================================

  void showEditProfileDialog() {
    final firstNameController =
        TextEditingController(text: "Bhavesh");

    final lastNameController =
        TextEditingController(text: "Suthar");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: "First Name",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Profile updated"),
                  ),
                );
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==================================================
              // PROFILE HEADER
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: theme.dividerColor.withOpacity(0.15),
                  ),
                ),
                child: Column(
                  children: [

                    // PROFILE IMAGE
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor:
                              colorScheme.primary.withOpacity(0.12),
                          child: Icon(
                            Icons.person_rounded,
                            size: 52,
                            color: colorScheme.primary,
                          ),
                        ),

                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.cardColor,
                                width: 3,
                              ),
                            ),
                            child: Icon(
                              Icons.edit_rounded,
                              size: 15,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // NAME
                    Text(
                      "Bhavesh Suthar",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // EMAIL
                    Text(
                      "bhavesh@example.com",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color
                            ?.withOpacity(0.6),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // EDIT PROFILE BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton.icon(
                        onPressed: showEditProfileDialog,
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 18,
                        ),
                        label: const Text("Edit Profile"),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // SETTINGS
              // ==================================================

              Text(
                "Settings",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              _settingsCard(
                context,
                children: [

                  // ==================================================
                  // DARK MODE
                  // ==================================================

                  _settingsTile(
                    context,
                    icon: Icons.dark_mode_outlined,
                    title: "Dark Mode",
                    subtitle: "Use dark theme across the app",

                    trailing: Consumer<ThemeProvider>(
                      builder: (
                        context,
                        themeProvider,
                        child,
                      ) {
                        return Switch(
                          value: themeProvider.isDarkMode,
                          onChanged: (value) {
                            themeProvider.toggleTheme(value);
                          },
                        );
                      },
                    ),
                  ),

                  _divider(context),

                  // ==================================================
                  // LANGUAGE
                  // ==================================================

                  _settingsTile(
                    context,
                    icon: Icons.language_rounded,
                    title: "Language",
                    subtitle: selectedLanguage,
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: showLanguageDialog,
                  ),

                  _divider(context),

                  // ==================================================
                  // NOTIFICATIONS
                  // ==================================================

                  _settingsTile(
                    context,
                    icon: Icons.notifications_outlined,
                    title: "Notifications",
                    subtitle: "Receive app notifications",
                    trailing: Switch(
                      value: notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          notificationsEnabled = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // ACCOUNT
              // ==================================================

              Text(
                "Account",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              _settingsCard(
                context,
                children: [

                  // PRIVACY
                  _settingsTile(
                    context,
                    icon: Icons.lock_outline_rounded,
                    title: "Privacy & Security",
                    subtitle: "Manage your account security",
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: () {},
                  ),

                  _divider(context),

                  // HELP
                  _settingsTile(
                    context,
                    icon: Icons.help_outline_rounded,
                    title: "Help & Support",
                    subtitle: "Get help with My Notebook",
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: () {},
                  ),

                  _divider(context),

                  // ABOUT
                  _settingsTile(
                    context,
                    icon: Icons.info_outline_rounded,
                    title: "About",
                    subtitle: "My Notebook",
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // LOGOUT
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: logout,
                  icon: const Icon(
                    Icons.logout_rounded,
                  ),
                  label: const Text(
                    "Logout",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(
                      color: colorScheme.error.withOpacity(0.5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // VERSION
              // ==================================================

              Center(
                child: Text(
                  "My Notebook • Version 1.0.0",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color
                        ?.withOpacity(0.45),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SETTINGS CARD
  // ============================================================

  Widget _settingsCard(
    BuildContext context, {
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.12),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // ============================================================
  // SETTINGS TILE
  // ============================================================

  Widget _settingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),

      onTap: onTap,

      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: colorScheme.primary,
          size: 22,
        ),
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color
                ?.withOpacity(0.6),
          ),
        ),
      ),

      trailing: trailing,
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  Widget _divider(BuildContext context) {
    return Divider(
      height: 1,
      indent: 74,
      endIndent: 16,
      color: Theme.of(context).dividerColor.withOpacity(0.12),
    );
  }
}