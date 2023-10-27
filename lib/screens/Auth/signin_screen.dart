import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pos/controller/login_controller.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';
import 'package:pos/utils/helping_method.dart';
import 'package:pos/widgets/text_field.dart';
import 'package:pos/widgets/text_field_label.dart';

import '../Tabbar/tab_bar_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController =
      TextEditingController(text: "ecart-user-1@mailinator.com");
  TextEditingController passwordController =
      TextEditingController(text: "user1234");

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  bool rememberMe = false;
  GlobalKey<FormState> formKey = GlobalKey();
  var helpingMethod = HelpingMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 70),
          const Center(
            child: Text(
              AppConstants.logInTextTitle,
              style: TextStyle(
                fontSize: 30,
                fontFamily: FontConstants.bold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            AppConstants.logInTextDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: FontConstants.regular,
            ),
          ),
          const SizedBox(height: 30),
          textFieldLabel(label: AppConstants.emailTextLabel, isRequired: true),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            hintText: AppConstants.emailTextHint,
            controller: emailController,
            focusNode: emailNode,
            validator: (value) {
              if (value == null || value == "") {
                return "Field is required";
              }
              if (!value.contains("@")) {
                return "Enter a valid email address";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          textFieldLabel(
              label: AppConstants.passwordTextLabel, isRequired: true),
          const SizedBox(height: 16),
          textField(
            textInputAction: TextInputAction.done,
            hintText: AppConstants.passwordTextHint,
            controller: passwordController,
            focusNode: passwordNode,
            validator: (value) {
              if (value == null || value == "") {
                return "Field is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          GetBuilder<LoginController>(builder: (loginController) {
            if (loginController.loading) {
              return const SizedBox(
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  loginController
                      .loginUser(emailController.text, passwordController.text)
                      .then((value) {
                    if (value == true) {
                      helpingMethod.openAndReplaceScreen(
                          context: context, screen: const DrawerScreen());
                    }
                  });
                }
              },
              child: const Text(
                AppConstants.signInText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.medium,
                ),
              ),
            );
          }),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: rememberMe,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                  title: Transform.translate(
                    offset: const Offset(-10, 0),
                    child: const Text(
                      AppConstants.rememberMeText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontConstants.regular,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  AppConstants.forgotPasswordText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff0B59ED),
                    fontWeight: FontWeight.w500,
                    fontFamily: FontConstants.medium,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
