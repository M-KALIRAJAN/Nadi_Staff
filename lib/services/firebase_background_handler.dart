import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tech_app/services/NotificationService.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  await Notificationservice.initialize();
  await Notificationservice.createChannel();

  final title = message.notification?.title ?? "Service";
  final body = message.notification?.body ??
      "Your service is ${message.data['service'] ?? ''}";

  await Notificationservice.show(
    title: title,
    body: body,
  );
}
