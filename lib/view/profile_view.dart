import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/model/TechnicianProfile_Model.dart';
import 'package:tech_app/preferences/AppPerfernces.dart';
import 'package:tech_app/provider/theme_provider.dart';
import 'package:tech_app/routes/route_name.dart';
import 'package:tech_app/services/TechnicianProfile_Service.dart';
import 'package:tech_app/services/lockout_service.dart';
import 'package:tech_app/widgets/header.dart';
import 'package:tech_app/widgets/inputs/app_text_field.dart';
import 'package:tech_app/widgets/inputs/primary_button.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final TechnicianprofileService _service = TechnicianprofileService();
  TechnicianProfile? _profile;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  final LockoutService _lockoutService = LockoutService();
  bool pushNotification = false;
  bool darkMode = false;
  bool privacyControl = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    profiledata();
  }

  Future<void> profiledata() async {
    final response = await _service.tech_profile();
    if (!mounted) return;

    setState(() {
      _profile = response;
      firstNameController.text = _profile?.data.firstName ?? "";
      lastNameController.text = _profile?.data.lastName ?? "";
      emailController.text = _profile?.data.email ?? "";
      mobileController.text = _profile?.data.mobile?.toString() ?? "";
    });
  }

  Future<void> _logout(BuildContext context) async {
    try {
      // Call backend logout
      await _lockoutService.fetchlogout();
      // Clear local storage
      await Appperfernces.clearAll();
      await Appperfernces.setLoggedIn(false);

      // Navigate to splash
      context.go(RouteName.splash);
    } catch (e) {
      debugPrint('❌ Logout failed: $e');
      // Still force logout if backend fails
      await Appperfernces.clearAll();
      await Appperfernces.setLoggedIn(false);
      context.go(RouteName.splash);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(title: "Profile Management"),
            const Divider(),

            // EVERYTHING SCROLLS
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _profileHeader(),
                    const SizedBox(height: 20),
                    _personalDetailsContainer(),
                    const SizedBox(height: 20),
                    _applicationSettingsContainer(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: PrimaryButton(
                radius: 15,
                height: 50,
                color: Color.fromRGBO(192, 33, 36, 1),
                onPressed: () {
                  _logout(context);
                },
                text: "Log Out",
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- PROFILE HEADER ----------------
  Widget _profileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: _profile?.data.image != null
                  ? CachedNetworkImageProvider(
                      '${ImageBaseUrl.baseUrl}/${_profile!.data.image}',
                    )
                  : null,
              child: _profile?.data.image == null
                  ? const Icon(Icons.person, size: 30)
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () async {
                  final updated = await context.push(
                    RouteName.editprofile,
                    extra: _profile,
                  );
                  if (updated == true) profiledata();
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primary_clr,
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "${_profile?.data.firstName} ${_profile?.data.lastName}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(_profile?.data.role.skill ?? ""),
      ],
    );
  }

  Widget _personalDetailsContainer() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: "First Name",
            controller: firstNameController,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          AppTextField(
            label: "Last Name",
            controller: lastNameController,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          AppTextField(
            label: "Email",
            controller: emailController,
            readOnly: true,
          ),
          const SizedBox(height: 10),
          AppTextField(
            label: "Mobile Number",
            controller: mobileController,
            readOnly: true,
          ),
        ],
      ),
    );
  }

  Widget _applicationSettingsContainer() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          _switchTile(
            title: "Enable Push Notifications",
            subtitle: "Receive real-time alerts and updates",
            value: pushNotification,
            onChanged: (v) => setState(() => pushNotification = v),
          ),
          _switchTile(
            title: "Dark Mode",
            subtitle: "Reduce eye strain in low light",
            value: ref.watch(themeProvider) == ThemeMode.dark,
            onChanged: (v){
              ref.read(themeProvider.notifier).setTheme(v);
            },
          ),
          // _switchTile(
          //   title: "Privacy Controls",
          //   subtitle: "Manage data sharing preferences",
          //   value: privacyControl,
          //   onChanged: (v) => setState(() => privacyControl = v),
          // ),
        ],
      ),
    );
  }

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 12,color: Colors.black),),
            ],
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: value,
            activeColor: AppColors.scoundry_clr,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
