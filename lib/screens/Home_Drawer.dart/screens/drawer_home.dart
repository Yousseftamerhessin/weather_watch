import 'package:flutter/material.dart';
import '../widget/Dark_mode.dart';
import '../widget/Help_Tile.dart';
import '../widget/Rate_app.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          color: isDarkMode
              ? Colors.black.withOpacity(0.7)
              : Colors.white.withOpacity(0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
               DarkMode(),
               HelpTile(),
               RateApp(),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Developed by Youssef Tamer',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
