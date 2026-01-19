import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_app/controllers/Auth_Controllers.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/core/utils/snackbar_helper.dart';
import 'package:tech_app/routes/route_name.dart';
import 'package:tech_app/widgets/inputs/app_text_field.dart';
import 'package:tech_app/widgets/inputs/primary_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isChecked = false;
  bool isLoading = false;
  final _fromkey = GlobalKey<FormState>();
  final _authcontroller = AuthControllers();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: screenWidth * 0.9,
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: screenHeight * 0.5,  
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _fromkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Welcome!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        AppTextField(
                          label: "Enter Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: _authcontroller.email,
                          validator: _authcontroller.validateEmail,
                        ),
                        SizedBox(height: 15),
                        AppTextField(
                          label: "Enter Password",
                          keyboardType: TextInputType.visiblePassword,
                          surfixIcon: Icon(Icons.visibility_off),
                          controller: _authcontroller.pasword,
                          validator: _authcontroller.validatePassword,
                        ),
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (v) {
                                    setState(() {
                                      isChecked = v!;
                                    });
                                  },
                                ),
                                Text("Remember me"),
                              ],
                            ),

                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: AppColors.scoundry_clr),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        PrimaryButton(
                          height: 48,
                          Width: double.infinity,
                          isLoading: isLoading,
                          radius: 12,
                          color: AppColors.primary_clr,
                          onPressed: () async {
                            if (_fromkey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              final errorMessage = await _authcontroller
                                  .login();
                              setState(() {
                                isLoading = false;
                              });
                              if (errorMessage == null) {
                                SnackbarHelper.show(
                                  context,
                                  message: "Login successful",
                                  backgroundColor: AppColors.scoundry_clr,
                                );
                                context.push(RouteName.bottom_nav);
                              } else {
                                SnackbarHelper.show(
                                  context,
                                  message: errorMessage,
                                  backgroundColor: Colors.red,
                                );
                                // debugPrint("errorMessage $errorMessage");
                              }
                            }
                          },
                          text: "Login",
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
