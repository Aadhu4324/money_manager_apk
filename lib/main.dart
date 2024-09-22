import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_money_manager_apk/model/income_expanse_model.dart';
import 'package:personal_money_manager_apk/model/user_model.dart';

import 'package:personal_money_manager_apk/screen/screen_splash.dart';
import 'package:personal_money_manager_apk/services/income_expense_services.dart';
import 'package:personal_money_manager_apk/services/user_services.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(IncomeModelAdapter());
  await IncomeExpenseServices().openIncomeBox();
  await IncomeExpenseServices().openExpenseBox();
  await UserServices().openBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IncomeExpenseServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserServices(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Money Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ScreenSplash(),
      ),
    );
  }
}
