// import 'package:flutter/material.dart';
// import 'package:calculator/Theme/ThemeManager.dart';
//
//
// class settingsScreen extends StatefulWidget {
//
//   @override
//   State<settingsScreen> createState() => _settingsScreenState();
// }
//
// class _settingsScreenState extends State<settingsScreen> {
//
//   final ThemeManager themeManager; // Expect a ThemeManager instance
//
//   // Constructor requires the ThemeManager
//   settingsScreen({Key? key, required this.themeManager}) : super(key: key);
//   void _themeListener() {
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     themeManager.addListener(_themeListener); // MyApp listens to the global _themeManager
//   }
//
//   @override
//   void dispose() {
//     themeManager.removeListener(_themeListener);
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         title: Text(
//           "Settings",
//           style: TextStyle(
//             color: Theme.of(context).primaryColor,
//             fontSize: 25,
//             letterSpacing: 1.5,
//           ),
//         ),
//
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(4.0),
//           child: Container(color: Theme.of(context).primaryColor, height: 2.5),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SwitchListTile(
//             title: Text("Dark Mode"),
//             value: widget.themeManager.themeMode == ThemeMode.dark,
//             onChanged: (bool isDark) {
//               widget.themeManager.toggleTheme(isDark);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
