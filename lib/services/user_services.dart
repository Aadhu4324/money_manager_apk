import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_money_manager_apk/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices extends ChangeNotifier {
  Box<UserModel>? userBox;
  Future<void> openBox() async {
    userBox = await Hive.openBox<UserModel>("Uesrs");
  }

  Future<UserModel> adduser(UserModel user) async {
    if (userBox == null) {
      await openBox();
    }
    await userBox!.add(user);

    return user;
  }

  Future<UserModel?> loginUser(String email, String passWord) async {
    final _shrp = await SharedPreferences.getInstance();
    if (userBox == null) {
      await openBox();
    }
    for (var user in userBox!.values) {
      if (user.email == email && user.passWord == passWord) {
        _shrp.setString("Login", user.uid);
        _shrp.setBool("LoginKey", true);
        return user;
      }
    }
    return null;
  }

  Future<UserModel> currentUserData() async {
    final _shrp = await SharedPreferences.getInstance();
    final userId = _shrp.getString("Login");

    if (userBox == null) {
      await openBox();
    }

    final data = userBox!.values.singleWhere(
      (element) => element.uid == userId,
    );

    return data;
  }
}
