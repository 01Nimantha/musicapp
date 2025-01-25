import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/componets/custom_button.dart';
import 'package:musicapp/componets/custom_text_field.dart';
import 'package:musicapp/pages/auth_remote.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: CustomTextField(
                        hintTextValue: "Enter your name",
                        iconValue: Icons.person,
                        controller: nameController)),
                SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: CustomTextField(
                        isobscureText: true,
                        hintTextValue: "Enter your password",
                        iconValue: Icons.lock,
                        controller: passwordController)),
                CustomButton(
                  name: "Creat",
                  function: () async {
                    final bool x = await AuthRemote().signup(
                        name: nameController.text,
                        password: passwordController.text);
                    if (x) {
                      Navigator.pop(context);
                      if (kDebugMode) {
                        print("NIhhkh");
                      }
                    }
                    if (kDebugMode) {
                      print("NIhhkh");
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          drawer: const Drawer(),
        ),
      ),
    );
  }
}
