import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/view/My_Request_List.dart';
import 'package:tech_app/view/home_view.dart';
import 'package:tech_app/view/material_inventory_view.dart';
import 'package:tech_app/view/profile_view.dart';

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
    // TODO: implement initState
    super.initState();
    screens = [
      () => HomeView(),
      () => MaterialInventoryView(),
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
        // Exit the app
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: screens[_selectedIndex](),
        bottomNavigationBar: Container(
          height: 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
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
              backgroundColor: Colors.white,
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
                  label: "Home",
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
                  label: "Inventory",
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
                  label: "Request List",
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
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
