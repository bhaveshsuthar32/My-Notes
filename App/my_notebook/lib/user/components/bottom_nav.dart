// import 'package:flutter/material.dart';

// class BottomNav extends StatelessWidget {

//   final int currentIndex;
//   final Function(int) onTap;

//   const BottomNav({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         onTap: onTap,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.black54,
//         showUnselectedLabels: true,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined,),
//             label: "Home",

//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: "Search",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.electric_bolt_outlined), // ✅ EV Service
//             label: "EV Service",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications_outlined),
//             label: "Notifications",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class BottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const BottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 72,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(
//             color: Colors.grey.shade200,
//             width: 1,
//           ),
//         ),
//       ),
//       child: SafeArea(
//         top: false,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _navItem(
//               index: 0,
//               icon: Icons.home_outlined,
//               selectedIcon: Icons.home_rounded,
//               label: "Home",
//             ),

//             _navItem(
//               index: 1,
//               icon: Icons.menu_book_outlined,
//               selectedIcon: Icons.menu_book_rounded,
//               label: "Topics",
//             ),

//             _navItem(
//               index: 2,
//               icon: Icons.search_outlined,
//               selectedIcon: Icons.search_rounded,
//               label: "Search",
//             ),

//             _navItem(
//               index: 3,
//               icon: Icons.auto_awesome_outlined,
//               selectedIcon: Icons.auto_awesome,
//               label: "AI",
//             ),

//             _navItem(
//               index: 4,
//               icon: Icons.person_outline_rounded,
//               selectedIcon: Icons.person_rounded,
//               label: "Profile",
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _navItem({
//     required int index,
//     required IconData icon,
//     required IconData selectedIcon,
//     required String label,
//   }) {
//     final bool isSelected = currentIndex == index;

//     return Expanded(
//       child: InkWell(
//         onTap: () => onTap(index),
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               isSelected ? selectedIcon : icon,
//               size: 22,
//               color: isSelected
//                   ? const Color(0xFF4E4DE7)
//                   : const Color(0xFF7B7B8A),
//             ),

//             const SizedBox(height: 4),

//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight:
//                     isSelected ? FontWeight.w600 : FontWeight.w400,
//                 color: isSelected
//                     ? const Color(0xFF4E4DE7)
//                     : const Color(0xFF7B7B8A),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              _navItem(
                context,
                index: 0,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                label: "Home",
              ),

              _navItem(
                context,
                index: 1,
                icon: Icons.menu_book_outlined,
                selectedIcon: Icons.menu_book_rounded,
                label: "Topics",
              ),

              // _navItem(
              //   context,
              //   index: 2,
              //   icon: Icons.search_outlined,
              //   selectedIcon: Icons.search_rounded,
              //   label: "Search",
              // ),
              _navItem(
                context,
                index: 2,
                icon: Icons.notes_outlined,
                selectedIcon: Icons.notes_rounded,
                label: "Notes",
              ),

              _navItem(
                context,
                index: 3,
                icon: Icons.auto_awesome_outlined,
                selectedIcon: Icons.auto_awesome,
                label: "AI",
              ),

              _navItem(
                context,
                index: 4,
                icon: Icons.person_outline_rounded,
                selectedIcon: Icons.person_rounded,
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isSelected = currentIndex == index;

    const primaryColor = Color(0xFF4E4DE7);

    final unselectedColor = isDark
        ? Colors.white.withOpacity(0.60)
        : const Color(0xFF7B7B8A);

    final selectedBackground = isDark
        ? primaryColor.withOpacity(0.18)
        : primaryColor.withOpacity(0.10);

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? selectedBackground : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isSelected ? selectedIcon : icon,
                    size: 21,
                    color: isSelected ? primaryColor : unselectedColor,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.5,
                    height: 1.0,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? primaryColor : unselectedColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
