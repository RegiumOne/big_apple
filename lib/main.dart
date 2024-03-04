import 'package:big_apple/app.dart';
import 'package:big_apple/common/firebase/firebase_options.dart';
import 'package:big_apple/di/injector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies(Environment.prod);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  const app = App();

  runApp(app);
}
