import 'package:hive_flutter/hive_flutter.dart';
part 'income_expanse_model.g.dart';

@HiveType(typeId: 2)
class IncomeModel extends HiveObject {
  @HiveField(0)
  double amount;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime createdAt;
  @HiveField(4)
  String id;
  @HiveField(5)
  String currentUserId;

  IncomeModel(
      {required this.amount,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.id,
      required this.currentUserId});
}
