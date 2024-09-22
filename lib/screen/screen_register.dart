import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_money_manager_apk/model/user_model.dart';
import 'package:personal_money_manager_apk/reusable_components/custom_button.dart';
import 'package:personal_money_manager_apk/reusable_components/custom_form_field.dart';
import 'package:personal_money_manager_apk/reusable_components/my_text.dart';
import 'package:personal_money_manager_apk/services/user_services.dart';
import 'package:uuid/uuid.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  final _registerKey = GlobalKey<FormState>();
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
              key: _registerKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: size * 0.13,
                  ),
                  CustomFormField(
                    controller: _email,
                    hintText: 'E-mail',
                  ),
                  CustomFormField(
                    controller: _pass,
                    hintText: 'PassWord',
                  ),
                  CustomFormField(
                    controller: _name,
                    hintText: 'Name',
                  ),
                  CustomFormField(
                    controller: _phone,
                    hintText: 'PhoneNumber',
                  ),
                  CustomButton(
                    ontap: () {
                      if (_registerKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                          Timer(
                            Duration(seconds: 3),
                            () async {
                              setState(() {
                                isLoading = false;
                              });
                              final id = Uuid().v4();
                              final _user = UserModel(
                                  email: _email.text,
                                  passWord: _pass.text,
                                  name: _name.text,
                                  phonenumber: _phone.text,
                                  uid: id);
                              UserServices _services = UserServices();
                              await _services.adduser(_user);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Created")));
                              Navigator.pop(context);
                            },
                          );
                        });
                      }
                    },
                    name: "Register",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                          fontSize: size * 0.028, data: "You Have An Account"),
                      SizedBox(
                        width: size * 0.015,
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: MyText(
                          fontSize: size * 0.035,
                          data: "Login",
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
