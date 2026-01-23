import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  
import 'package:tech_app/core/utils/Time_Date.dart';
import 'package:tech_app/provider/notification_Service_Provider.dart';

class Notifications extends ConsumerWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationAsync = ref.watch(notificationServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: notificationAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (err, _) => Center(child: Text("Error: $err")),

        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(child: Text("No notifications"));
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.refresh(notificationServiceProvider);
            },
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final n = notifications[index];

                return ListTile(
                  leading: Icon(
                    n.type == "Service Request" ? Icons.work : Icons.inventory,
                    color: Colors.blue,
                  ),
                  title: Text(n.message),
                  subtitle: Text(formatDateForUI(n.time)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
