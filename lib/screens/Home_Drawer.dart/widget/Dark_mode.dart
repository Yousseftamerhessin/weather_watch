import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../style/theme_provider.dart';

class DarkMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return SwitchListTile(
      title: Text(
        'Dark Mode',
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      value: isDarkMode,
      onChanged: (bool value) {
        themeProvider.toggleTheme();
        Navigator.pop(context);
      },
      secondary: Icon(
        isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
