import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/search_page.dart';
import 'utils/root_detection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await RootDetection.isDeviceRooted()) {
    runApp(const RootedDeviceWarningApp());
  } else {
    runApp(ProviderScope(child: MyApp()));
  }
}

class RootedDeviceWarningApp extends StatelessWidget {
  const RootedDeviceWarningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Security Warning')),
        body: const Center(
          child: Text(
            'This device is rooted. The app cannot run on a rooted device for security reasons.',
            style: TextStyle(color: Colors.red, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iTunes Media Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchPage(),
    );
  }
}
