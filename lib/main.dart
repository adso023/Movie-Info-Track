import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_track/src/app.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(App());
}

/// Things to do
/// 1. Make a search screen
/// 2. Add some state caching for the main view page
/// 
