import 'package:flutter/material.dart';
import 'package:my_notebook/user/components/bottom_nav.dart';
import 'package:my_notebook/user/components/drawerbar.dart';
import 'package:my_notebook/user/components/header.dart';
import 'package:my_notebook/user/pages/home.dart';
import 'package:my_notebook/user/pages/login/login.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      drawer: Drawerbar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNav(currentIndex: _currentIndex, onTap: (index){
        setState(() {
          _currentIndex = index ;
        });
      }),  
    );
  }
}