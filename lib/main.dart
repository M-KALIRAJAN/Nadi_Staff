import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/provider/theme_provider.dart';
import 'package:tech_app/routes/app_route.dart';
import 'package:tech_app/services/NotificationService.dart';
import 'package:tech_app/services/firebase_background_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  await Notificationservice.initialize();
  await Notificationservice.createChannel();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeProvider),
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: "Poppins",
        scaffoldBackgroundColor: AppColors.background_clr,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary_clr,
          secondary: AppColors.new_clr,
          surface: Colors.white,
        ),

        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Poppins",
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary_clr,
          secondary: AppColors.new_clr,
          surface: Color(0xFF1E1E1E),
        ),

        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),

      routerConfig: Approute,
    );
  }
}
