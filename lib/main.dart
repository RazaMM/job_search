import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/ui/core/themes/theme.dart';
import 'package:job_search/ui/home/home_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // This is required for sqflite_ffi to work on Windows and Linux.
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }

  if(!Platform.isAndroid && !Platform.isIOS) {
    databaseFactory = databaseFactoryFfi;
  }

  // This is required for window_manager to work
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(1000, 600),
    center: true,
    minimumSize: Size(1000, 600)
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Search',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      home: ProviderScope(child: HomePage()),
    );
  }
}
