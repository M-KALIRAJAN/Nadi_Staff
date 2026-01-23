import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_app/routes/app_route.dart';
import 'package:tech_app/services/NotificationService.dart';
import 'package:tech_app/services/firebase_background_handler.dart';

  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Notificationservice.initialize();
  await Notificationservice.createChannel();
   FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
   );
   await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true
   );
    // 🔔 FOREGROUND NOTIFICATION
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      Notificationservice.show(
        title: notification.title ?? '',
        body: notification.body ?? '',
      );
    }
  });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: Approute,
      theme: ThemeData(fontFamily: "Poppins"),
    );
  }
}
