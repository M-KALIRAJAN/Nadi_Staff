import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_app/provider/InventoryList_provider.dart';

class Header extends ConsumerStatefulWidget {
  final String title;
  final bool showRefreshIcon;

  const Header({
    super.key,
    required this.title,
    this.showRefreshIcon = false,
  });

  @override
  ConsumerState<Header> createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<Header>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animation controller for spinning refresh icon
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    try {
      // Start spinning
      _controller.repeat();
      // Refresh inventory provider
      await ref.refresh(inventorylistprovider.future);
    } finally {
      // Stop spinning
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          // InkWell(
          //   onTap: () => Navigator.of(context).pop(),
          //   child: Container(
          //     height: 38,
          //     width: 38,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Color.fromRGBO(183, 213, 205, 1),
          //     ),
          //     alignment: Alignment.center,
          //     child: const Icon(
          //       Icons.arrow_back_rounded,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),

          // Title
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          // Right icon
          widget.showRefreshIcon
              ? InkWell(
                  onTap: _onRefresh,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _controller.value * 5.3, 
                        child: child,
                      );
                    },
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(183, 213, 205, 1),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.refresh_outlined,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
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
                      alignment: Alignment.center,
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
                        child: const Text(
                          "0",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
