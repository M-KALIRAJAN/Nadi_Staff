import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/preferences/AppPerfernces.dart';
import 'package:tech_app/routes/route_name.dart';
import 'package:tech_app/services/Stream_Chat_Service.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _navigate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _initNotifications();
  });
  }
Future<void> _initNotifications() async {
  try {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final token = await FirebaseMessaging.instance.getToken();

    print("🔥 FCM TOKEN: $token");

    if (token != null) {
      await Appperfernces.saveFcmToken(token);
    } else {
      print("❌ FCM token is NULL");
    }
  } catch (e) {
    print("❌ FCM ERROR: $e");
  }
}

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    final isLoggedIn = await Appperfernces.isLoggedIn();
    if (!mounted) return;
    if (isLoggedIn) {
          final techId = await Appperfernces.getTechId(); // <-- get techId here
    if (techId != null) {
      await StreamChatService().connectUser(techId);
    } 
      context.go(RouteName.bottom_nav);
    } else {
      context.go(RouteName.login);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.app_background_clr,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            "assets/logo/Techlogo.png",
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }
}
