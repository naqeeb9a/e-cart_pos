import 'package:flutter/material.dart';
import 'package:pos/screens/drawer_screen.dart';
import 'package:pos/utils/constants/app_constants.dart';
import 'package:pos/utils/constants/font_constants.dart';
import 'package:pos/utils/helping_method.dart';
import 'package:pos/widgets/text_field.dart';
import 'package:pos/widgets/text_field_label.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  bool rememberMe = false;

  var helpingMethod = HelpingMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
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
        ),
        const SizedBox(height: 16),
        textFieldLabel(label: AppConstants.passwordTextLabel, isRequired: true),
        const SizedBox(height: 16),
        textField(
          textInputAction: TextInputAction.done,
          hintText: AppConstants.passwordTextHint,
          controller: passwordController,
          focusNode: passwordNode,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            helpingMethod.openAndReplaceScreen(
                context: context, screen: const DrawerScreen());
          },
          child: const Text(
            AppConstants.signInText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: FontConstants.medium,
            ),
          ),
        ),
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
    );
  }
}
