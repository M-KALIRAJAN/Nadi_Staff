import 'package:flutter/material.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/model/TechnicianProfile_Model.dart';
import 'package:tech_app/preferences/AppPerfernces.dart';
import 'package:tech_app/services/TechnicianProfile_Service.dart';
import 'package:tech_app/widgets/header.dart';
import 'package:tech_app/widgets/inputs/app_text_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TechnicianprofileService _service = TechnicianprofileService();
  TechnicianProfile? _profile;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;

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
  try {
    final response = await _service.tech_profile();

    if (!mounted) return;

    setState(() {
      _profile = response;

      firstNameController.text = _profile?.data.firstName ?? "";
      lastNameController.text = _profile?.data.lastName ?? "";
      emailController.text = _profile?.data.email ?? "";
      mobileController.text = _profile?.data.mobile?.toString() ?? "";
    });

    // Save profile to preferences
    await Appperfernces.saveProfiledata(response);

  } catch (e) {
   
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(title: "Profile Management"),

            const Divider(),
            const SizedBox(height: 10),
            Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, size: 90),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary_clr,
                    ),
                    child: Icon(Icons.edit_outlined),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${_profile?.data.firstName} ${_profile?.data.lastName}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text("${_profile?.data.role.skill}"),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(15),
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Personal informarion",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Full Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        AppTextField(
                          label: "First Name",
                          controller: firstNameController,
                          readOnly: true,
                          enabled: false,
                        ),
                        const SizedBox(height: 10),

                        Text(
                          "Last Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        AppTextField(
                          label: "Last Name",
                          controller: lastNameController,
                          readOnly: true,
                          enabled: false,
                        ),

                        const SizedBox(height: 10),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        AppTextField(
                          label: "Email",
                          controller: emailController,
                          readOnly: true,
                          enabled: false,
                        ),

                        const SizedBox(height: 10),
                        Text(
                          "Mobile Number",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        AppTextField(
                          label: "Mobile Number",
                          controller: mobileController,
                          readOnly: true,
                          enabled: false,
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
