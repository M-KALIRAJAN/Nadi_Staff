import 'package:flutter/material.dart';
import 'package:tech_app/view/update_request_view.dart';
import 'package:tech_app/widgets/card/servicerequest_cart.dart';

class LivechatView extends StatefulWidget {
  const LivechatView({super.key});

  @override
  State<LivechatView> createState() => _LivechatViewState();
}

class _LivechatViewState extends State<LivechatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ServicerequestCart()
            // UpdateRequestView(),
          ],
        ),
      ),
    );
  }
}
