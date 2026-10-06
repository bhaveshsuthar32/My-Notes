// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/components/bottom_nav.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';
// import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/pages/login/login.dart';

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     Home(),
//     LoginPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Header(),
//       drawer: Drawerbar(),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavBar(currentIndex: _currentIndex, onTap: (index){
//         setState(() {
//           _currentIndex = index ;
//         });
//       }),  
//     );
//   }
// // }

// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/components/bottom_nav.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';
// import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/pages/topics/topics_page.dart';

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const Home(),

//     // Temporary pages
//     const TopicsPage(),

//     const Center(
//       child: Text("Search"),
//     ),

//     const Center(
//       child: Text("AI Assistant"),
//     ),

//     const Center(
//       child: Text("Profile"),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const Header(),

//       drawer: const Drawerbar(),

//       body: _pages[_currentIndex],

//       bottomNavigationBar: BottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/components/bottom_nav.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';
// import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/pages/notes/notes_page.dart';
// import 'package:my_notebook/user/pages/topics/topics_page.dart';

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const Home(),
//     const TopicsPage(),
//     const NotesPage(),
//     const Center(child: Text("AI Assistant")),
//     const Center(child: Text("Profile")),
//   ];

//   void changePage(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const Header(),

//       drawer: Drawerbar(
//         onPageSelected: changePage,
//       ),

//       body: IndexedStack(
//         index: _currentIndex,
//         children: _pages,
//       ),

//       bottomNavigationBar: BottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: changePage,
//       ),
//     );
//   }
// } 


// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/components/bottom_nav.dart';
// import 'package:my_notebook/user/components/drawerbar.dart';
// import 'package:my_notebook/user/components/header.dart';
// import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/pages/notes/notes_page.dart';
// import 'package:my_notebook/user/pages/topics/topics_page.dart';

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const Home(),
//     const TopicsPage(),
//     const NotesPage(),
//     const Center(
//       child: Text("AI Assistant"),
//     ),
//     const Center(
//       child: Text("Profile"),
//     ),
//   ];

//   void changePage(int index) {
//     if (index < 0 || index >= _pages.length) {
//       return;
//     }

//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // =========================================================
//       // COMMON HEADER
//       // =========================================================
//       appBar: const Header(),

//       // =========================================================
//       // COMMON DRAWER
//       // =========================================================
//       drawer: Drawerbar(
//         onPageSelected: (index) {
//           // First change page
//           changePage(index);

//           // Then close drawer
//           Navigator.of(context).pop();
//         },
//       ),

//       // =========================================================
//       // MAIN PAGES
//       // =========================================================
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _pages,
//       ),

//       // =========================================================
//       // COMMON BOTTOM NAVIGATION
//       // =========================================================
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: changePage,
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/user/components/bottom_nav.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';
import 'package:my_notebook/user/pages/home.dart';
import 'package:my_notebook/user/pages/login/login.dart';
import 'package:my_notebook/user/pages/notes/notes_page.dart';
import 'package:my_notebook/user/pages/profile/profile_page.dart';
import 'package:my_notebook/user/pages/topics/topics_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  bool _isCheckingAuth = true;
  bool _isLoggedIn = false;

  final List<Widget> _pages = [
    const Home(),
    const TopicsPage(),
    const NotesPage(),
    const Center(
      child: Text("AI Assistant"),
    ),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final isLoggedIn = await ApiServices().isLoggedIn();

    if (!mounted) return;

    setState(() {
      _isLoggedIn = isLoggedIn;
      _isCheckingAuth = false;
    });
  }

  void changePage(int index) {
    if (index < 0 || index >= _pages.length) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Authentication check chal raha hai
    if (_isCheckingAuth) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // User login nahi hai
    if (!_isLoggedIn) {
      return const LoginPage();
    }

    // User login hai
    return Scaffold(
      appBar: const Header(),

      drawer: Drawerbar(
        onPageSelected: (index) {
          changePage(index);
          Navigator.of(context).pop();
        },
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: changePage,
      ),
    );
  }
}