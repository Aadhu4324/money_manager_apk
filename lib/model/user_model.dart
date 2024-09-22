import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  String email;
  @HiveField(1)
  String passWord;
  @HiveField(2)
  String name;
  @HiveField(3)
  String phonenumber;
  @HiveField(4)
  String uid;
  UserModel(
      {required this.email,
      required this.passWord,
      required this.name,
      required this.phonenumber,
      required this.uid});
}
