import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/preferences/AppPerfernces.dart';
import 'package:tech_app/services/Stream_Chat_Service.dart';

class ChatDetailsScreen extends StatefulWidget {
  final String? adminId;
  final String? adminName;

  const ChatDetailsScreen({super.key, this.adminId, this.adminName});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  late final StreamChatClient client;
  Channel? channel;
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    client = StreamChatService().client;
    setupStreamChat();
  }

  Future<void> setupStreamChat() async {
    try {
      final streamService = StreamChatService();

      final userId = await  Appperfernces.getTechId();
    
      final adminId = widget.adminId;
        print("Technician ID 👉 $userId");
    print("Admin ID 👉 $adminId");
      if (userId == null || adminId == null) {
        print("UserId or AdminId is null ❌");
        return;
      }

      await streamService.connectUser(
        userId
      );

      channel = streamService.client.channel(
        'messaging',
        extraData: {
          'members': [userId, adminId],
        },
      );

      await channel!.watch();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("Stream setup error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (channel == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.adminName ?? "Chat")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return StreamChannel(
      channel: channel!,
      child: Scaffold(
        appBar: AppBar(
           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.scoundry_clr,
                    child: Text(
                      widget.adminName != null && widget.adminName!.isNotEmpty
                          ? widget.adminName![0].toUpperCase()
                          : "A",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.adminName ?? "Admin",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamMessageListView(
                messageBuilder: (context, details, messages, defaultMessage) {
                  final message = details.message;
                  final currentUser = StreamChat.of(context).client.state.currentUser;
                  final isMe = message.user?.id == currentUser?.id;

                  // ✅ My messages (Right side)
                  if (isMe) {
                    return defaultMessage.copyWith(
                      showUsername: false,
                      showUserAvatar: DisplayWidget.gone,
                    );
                  }

                  // ✅ Admin messages (Left side with custom avatar)
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.scoundry_clr,
                          child: Text(
                            (widget.adminName?.isNotEmpty ?? false)
                                ? widget.adminName![0].toUpperCase()
                                : "A",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: defaultMessage.copyWith(
                            showUsername: false,
                            showUserAvatar: DisplayWidget.gone,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const StreamMessageInput(),
          ],
        ),
      ),
    );
  }
}