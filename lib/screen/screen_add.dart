import 'package:flutter/material.dart';
import 'package:personal_money_manager_apk/model/income_expanse_model.dart';
import 'package:personal_money_manager_apk/reusable_components/custom_button.dart';
import 'package:personal_money_manager_apk/reusable_components/custom_form_field.dart';
import 'package:personal_money_manager_apk/services/income_expense_services.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

class ScreenAdd extends StatefulWidget {
  final String currentUserId;
  final bool inorEx;
  ScreenAdd({super.key, required this.currentUserId, required this.inorEx});

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  TextEditingController _amount = TextEditingController();

  TextEditingController _description = TextEditingController();

  String? dropDownValue = "Salary";
  String? dropDownValue2 = "Food";

  final _addIncomekey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _services = Provider.of<IncomeExpenseServices>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _addIncomekey,
        child: widget.inorEx
            ? Column(
                children: [
                  CustomFormField(
                    controller: _amount,
                    hintText: "Amount",
                    type: TextInputType.number,
                  ),
                  CustomFormField(
                      controller: _description, hintText: "Description"),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 25),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      value: dropDownValue,
                      items: incomes.map(
                        (e) {
                          return DropdownMenuItem(
                            child: Text(e.toString()),
                            value: e,
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = value;
                        });
                      },
                    ),
                  ),
                  CustomButton(
                    ontap: () async {
                      if (_addIncomekey.currentState!.validate()) {
                        final id = Uuid().v4();
                        IncomeModel _income = IncomeModel(
                            amount: double.parse(_amount.text),
                            title: dropDownValue.toString(),
                            description: _description.text,
                            createdAt: DateTime.now(),
                            id: id,
                            currentUserId: widget.currentUserId);

                        await _services.addIncome(_income);
                        Navigator.pop(context);
                      }
                    },
                    name: "Add Income",
                    color: const Color.fromARGB(255, 14, 213, 21),
                  )
                ],
              )
            : Column(
                children: [
                  CustomFormField(
                    controller: _amount,
                    hintText: "Amount",
                    type: TextInputType.number,
                  ),
                  CustomFormField(
                      controller: _description, hintText: "Description"),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 25),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      value: dropDownValue2,
                      items: expense.map(
                        (e) {
                          return DropdownMenuItem(
                            child: Text(e.toString()),
                            value: e,
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropDownValue2 = value;
                        });
                      },
                    ),
                  ),
                  CustomButton(
                    ontap: () async {
                      if (_addIncomekey.currentState!.validate()) {
                        final id = Uuid().v4();
                        IncomeModel _expense = IncomeModel(
                            amount: double.parse(_amount.text),
                            title: dropDownValue2.toString(),
                            description: _description.text,
                            createdAt: DateTime.now(),
                            id: id,
                            currentUserId: widget.currentUserId);

                        await _services.addExpense(_expense);
                        Navigator.pop(context);
                      }
                    },
                    name: "Add Expense",
                    color: const Color.fromARGB(255, 14, 213, 21),
                  )
                ],
              ),
      ),
    );
  }
}

List<String> incomes = [
  "Salary",
  "CashBack",
  "Sales",
  "PocketMoney",
  "Interest",
  "Savings",
  "Bonus",
  "Other"
];
List<String> expense = [
  "Food",
  "Misclenous",
  "Grocery OnlineShopping",
  "Personal Care",
  "Charity",
  "Loan",
  "Daily expense",
  "Travelling",
  "Other"
];
