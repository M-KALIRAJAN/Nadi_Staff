import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/firebase_options.dart';
import 'package:tech_app/l10n/app_localizations.dart';
import 'package:tech_app/preferences/AppPerfernces.dart';
import 'package:tech_app/provider/language_provider.dart';
import 'package:tech_app/provider/theme_provider.dart';
import 'package:tech_app/routes/app_route.dart';
import 'package:tech_app/services/NotificationService.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:tech_app/services/Stream_Chat_Service.dart';

///  STEP 1: ADD THIS HERE (TOP LEVEL, NOT INSIDE CLASS)
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// FIREBASE INIT
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// LOCAL NOTIFICATION INIT
  await NotificationService.initialize();
  await NotificationService.createChannel();

  /// BACKGROUND HANDLER
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  /// REQUEST PERMISSION (iOS)
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  /// VERY IMPORTANT FOR IOS TOKEN
  await FirebaseMessaging.instance.setAutoInitEnabled(true); 
    // ✅ CONNECT USER BEFORE APP STARTS
  // final techId = await Appperfernces.getTechId();

  // if (techId != null) {
  //   await StreamChatService().connectUser(techId);
  // }

  /// GET FCM TOKEN
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print("🔥 FCM TOKEN = $token");
  } catch (e) {
    print("⚠️ FCM not available on simulator: $e");
  }

  /// TOKEN REFRESH LISTENER
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    print("🔥 NEW FCM TOKEN = $newToken");
  });

  /// FOREGROUND MESSAGE
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationService.show(
      title: message.notification?.title ?? 'OTP',
      body: message.notification?.body ?? 'Your OTP is ${message.data['otp']}',
    );
  });
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final StreamChatClient client = StreamChatService().client;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    return MaterialApp.router(
      title: 'Nadi Staff',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      routerConfig: Approute,

      // ✅ THIS IS THE FIX
      builder: (context, child) {
        return StreamChat(
          client: client,
          child: child!,
        );
      },
    );
  }
}
