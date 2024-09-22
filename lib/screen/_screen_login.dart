import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_money_manager_apk/reusable_components/custom_button.dart';
import 'package:personal_money_manager_apk/reusable_components/custom_form_field.dart';
import 'package:personal_money_manager_apk/reusable_components/my_text.dart';
import 'package:personal_money_manager_apk/screen/screen_home.dart';
import 'package:personal_money_manager_apk/screen/screen_register.dart';
import 'package:personal_money_manager_apk/services/user_services.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _loginkey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();

  TextEditingController _pass = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff654ea3), Color(0xffeaafc8)])),
        child: Stack(
          children: [
            Form(
              key: _loginkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: size * 0.13,
                  ),
                  CustomFormField(controller: _email, hintText: "Email"),
                  CustomFormField(controller: _pass, hintText: "PassWord"),
                  CustomButton(
                      ontap: () {
                        if (_loginkey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          Timer(
                            Duration(seconds: 3),
                            () async {
                              setState(() {
                                isLoading = false;
                              });
                              UserServices _services = UserServices();
                              final data = await _services.loginUser(
                                  _email.text, _pass.text);
                              data == null
                                  ? ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: MyText(
                                        fontSize: 15,
                                        data: "Invalid User Credentials ",
                                        color: Colors.white,
                                      ),
                                    ))
                                  : Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScreenHome(),
                                      ));
                            },
                          );
                        }
                      },
                      name: "Login"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                          fontSize: size * 0.028,
                          data: "Don't Have An Account"),
                      SizedBox(
                        width: size * 0.015,
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScreenRegister(),
                            )),
                        child: MyText(
                          fontSize: size * 0.035,
                          data: "Create",
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
