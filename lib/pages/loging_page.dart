import 'package:flutter/material.dart';
import 'package:musicapp/componets/custom_button.dart';
import 'package:musicapp/componets/custom_text_field.dart';
import 'package:musicapp/pages/auth_remote.dart';
import 'package:musicapp/pages/main_page.dart';
import 'package:musicapp/pages/sign_up_page.dart';

class LogingPage extends StatefulWidget {
  const LogingPage({super.key});

  @override
  State<LogingPage> createState() => _LogingPageState();
}

class _LogingPageState extends State<LogingPage> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 5,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: CustomTextField(
                      controller: nameController,
                      hintTextValue: "Enter your name",
                      iconValue: Icons.person,
                    )),
                SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: CustomTextField(
                      isobscureText: true,
                      controller: passwordController,
                      hintTextValue: "Enter your password",
                      iconValue: Icons.lock,
                    )),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      name: "Sign up",
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CustomButton(
                      name: "Continue",
                      function: () async {
                        final bool a = await AuthRemote().login(
                            name: nameController.text,
                            password: passwordController.text);
                        if (a) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                        }
                      },
                    )),
                  ],
                ),
                // Spacer()
              ],
            ),
          ),
          drawer: const Drawer(),
        ),
      ),
    );
  }
}
