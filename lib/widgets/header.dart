import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final bool showRefreshIcon;

  const Header({super.key, required this.title, this.showRefreshIcon = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          // Container(
          //   height: 38,
          //   width: 38,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Color.fromRGBO(183, 213, 205, 1),
          //   ),
          //   child: const Icon(
          //     Icons.arrow_back_rounded,
          //     color: Colors.white,
          //   ),
          // ),

          // Title
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          // Right icon
          showRefreshIcon
              ? Container(
                  height: 38,
                  width: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(183, 213, 205, 1),
                  ),
                  child: const Icon(
                    Icons.refresh_outlined,
                    color: Colors.white,
                    size: 27,
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      height: 38,
                      width: 38,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(183, 213, 205, 1),
                      ),
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: const Text("0", style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
