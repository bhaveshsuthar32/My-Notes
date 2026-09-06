

// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/pages/home.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'My App',
//       theme: ThemeData(
//         useMaterial3: true,
//       ),
//       // home: const Home(), // 👈 your page here
//       // home: RootPage(),
//       home: Home(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_notebook/theme/theme_provider.dart';
import 'package:my_notebook/theme/light_theme.dart';
import 'package:my_notebook/theme/dark_theme.dart';

import 'package:my_notebook/user/pages/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "My Notes",

          // Light Theme
          theme: AppLightTheme.theme,

          // Dark Theme
          darkTheme: AppDarkTheme.theme,

          // Current Theme
          themeMode: themeProvider.themeMode,

          // Home Page
          home: const Home(),
        );
      },
    );
  }
}