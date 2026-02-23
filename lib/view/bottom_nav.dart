import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/l10n/app_localizations.dart';
import 'package:tech_app/view/My_Request_List.dart';
import 'package:tech_app/view/home_view.dart';
import 'package:tech_app/view/material_inventory_view.dart';
import 'package:tech_app/view/profile_view.dart';
import 'package:tech_app/view/livechat_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  DateTime? lastBackPressed;
  late final List<Widget Function()> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      () => HomeView(),
      () => MaterialInventoryView(),
      ()=> ChatsView(),
      () => MyRequestList(),
      () => ProfileView(),
    ];
  }

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (lastBackPressed == null ||
            now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
          lastBackPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Tap again to exit"),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // prevent exit
        }
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: screens[_selectedIndex](),
        bottomNavigationBar: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: AppColors.scoundry_clr,
                items: [
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icons/home.png"),
                      size: 26,
                    ),
                    activeIcon: ImageIcon(
                      AssetImage("assets/icons/home.png"),
                      size: 26,
                    ),
                    label: AppLocalizations.of(context)!.home,
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icons/chat.png"),
                      size: 26,
                    ),
                    activeIcon: ImageIcon(
                      AssetImage("assets/icons/chat.png"),
                      size: 26,
                    ),
                    label: AppLocalizations.of(context)!.inventory,
                  ),
                      BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icons/chat.png"),
                      size: 26,
                    ),
                    activeIcon: ImageIcon(
                      AssetImage("assets/icons/chat.png"),
                      size: 26,
                    ),
                    label: "live chat ",
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icons/services.png"),
                      size: 27,
                    ),
                    activeIcon: ImageIcon(
                      AssetImage("assets/icons/services.png"),
                      size: 27,
                    ),
                    label:AppLocalizations.of(context)!.requestList,
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icons/profile.png"),
                      size: 26,
                    ),
                    activeIcon: ImageIcon(
                      AssetImage("assets/icons/profile.png"),
                      size: 26,
                    ),
                    label: AppLocalizations.of(context)!.profile
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
