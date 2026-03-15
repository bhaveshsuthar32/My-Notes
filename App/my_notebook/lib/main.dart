// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/pages/home.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/root_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      // home: const Home(), // 👈 your page here
      // home: RootPage(),
      home: Home(),
    );
  }
}
