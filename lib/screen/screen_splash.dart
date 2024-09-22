import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_money_manager_apk/screen/_screen_login.dart';
import 'package:personal_money_manager_apk/screen/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
  }

  splash() {
    Future.delayed(
      Duration(seconds: 3),
      () async {
        final shrp = await SharedPreferences.getInstance();

        var data = shrp.getBool("LoginKey");
        print(data);
        if (data == null || data == false) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ScreenLogin(),
          ));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ScreenHome(),
          ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("images/Animation - 1726926307231.json",
                repeat: true, height: 250, width: 300, fit: BoxFit.fill),
          ),
          SizedBox(height: height * 0.3),
          Text(
            "Money Manager",
            style:
                TextStyle(fontSize: height * 0.04, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
