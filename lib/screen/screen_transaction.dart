import 'package:flutter/material.dart';
import 'package:personal_money_manager_apk/model/income_expanse_model.dart';
import 'package:personal_money_manager_apk/model/user_model.dart';
import 'package:personal_money_manager_apk/reusable_components/animated_text.dart';
import 'package:personal_money_manager_apk/reusable_components/custom_button.dart';
import 'package:personal_money_manager_apk/reusable_components/custom_form_field.dart';
import 'package:personal_money_manager_apk/reusable_components/my_text.dart';
import 'package:personal_money_manager_apk/services/income_expense_services.dart';
import 'package:personal_money_manager_apk/services/user_services.dart';
import 'package:provider/provider.dart';

class ScrenTransaction extends StatefulWidget {
  final bool incExp;
  const ScrenTransaction({
    super.key,
    required this.incExp,
  });

  @override
  State<ScrenTransaction> createState() => _ScrenTransactionState();
}

class _ScrenTransactionState extends State<ScrenTransaction> {
  TextEditingController _amount = TextEditingController();
  TextEditingController _description = TextEditingController();
  final updateKey = GlobalKey<FormState>();
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    final _incomeoeexpenseServices =
        Provider.of<IncomeExpenseServices>(context);
    final _userservices = Provider.of<UserServices>(context);

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _userservices.currentUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              final userData = snapshot.data;
              return widget.incExp
                  ? FutureBuilder(
                      future:
                          _incomeoeexpenseServices.getAllIncome(userData!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (snapshot.hasData) {
                            final incomes = snapshot.data;

                            if (incomes!.isNotEmpty) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  final incomeslist = incomes[index];
                                  return Card(
                                    child: ListTile(
                                        trailing: Container(
                                          width: 100,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    updateIncomeSheet(
                                                        incomeslist!, index);
                                                  },
                                                  icon: Icon(Icons.edit)),
                                              IconButton(
                                                  onPressed: () async {
                                                    await _incomeoeexpenseServices
                                                        .deleteCurrentIncome(
                                                            index,
                                                            incomeslist!);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        leading: MyText(
                                          fontSize: 30,
                                          data: "₹",
                                          color: Colors.green,
                                        ),
                                        title: MyText(
                                          data:
                                              "+${incomeslist!.amount.toString()}",
                                          fontSize: 20,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        subtitle: MyText(
                                          data:
                                              "${incomeslist.title} ${incomeslist.createdAt}",
                                          fontSize: 15,
                                        )),
                                  );
                                },
                                itemCount: incomes.length,
                              );
                            } else {
                              return Center(
                                  child: AnimatedText(
                                      data: "No Transcation Available",
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold));
                            }
                          } else {
                            return Center(
                              child: Text("Error"),
                            );
                          }
                        }
                      },
                    )
                  : FutureBuilder(
                      future:
                          _incomeoeexpenseServices.getAllExpense(userData!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (snapshot.hasData) {
                            final expenses = snapshot.data;

                            if (expenses!.isNotEmpty) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  final exepnselist = expenses[index];
                                  return Card(
                                    child: ListTile(
                                        trailing: Container(
                                          width: 100,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    updateExpenseSheet(
                                                        exepnselist, index);
                                                  },
                                                  icon: Icon(Icons.edit)),
                                              IconButton(
                                                  onPressed: () async {
                                                    await _incomeoeexpenseServices
                                                        .deleteCureentexpense(
                                                            exepnselist, index);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        leading: MyText(
                                          fontSize: 30,
                                          data: "₹",
                                          color: Colors.red,
                                        ),
                                        title: MyText(
                                          data:
                                              "-${exepnselist.amount.toString()}",
                                          fontSize: 20,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        subtitle: MyText(
                                          data:
                                              "${exepnselist.title} ${exepnselist.createdAt}",
                                          fontSize: 15,
                                        )),
                                  );
                                },
                                itemCount: expenses.length,
                              );
                            } else {
                              return Center(
                                  child: AnimatedText(
                                      data: "No Transcation Available",
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold));
                            }
                          } else {
                            return Center(
                              child: Text("Error"),
                            );
                          }
                        }
                      },
                    );
            } else {
              return Center(
                child: Text("Error"),
              );
            }
          }
        },
      ),
    );
  }

  updateIncomeSheet(IncomeModel income, int index) async {
    _amount.text = income.amount.toString();
    _description.text = income.description.toString();
    await showModalBottomSheet(
      context: context,
      builder: (context) => Form(
        key: updateKey,
        child: Column(
          children: [
            CustomFormField(controller: _amount, hintText: "Amount"),
            CustomFormField(controller: _description, hintText: "Description"),
            CustomButton(
                ontap: () async {
                  if (updateKey.currentState!.validate()) {
                    IncomeModel updatedIncome = IncomeModel(
                        amount: double.parse(_amount.text),
                        title: income.title,
                        description: _description.text,
                        createdAt: DateTime.now(),
                        id: income.id,
                        currentUserId: income.currentUserId);
                    final incomeservices = Provider.of<IncomeExpenseServices>(
                        context,
                        listen: false);
                    await incomeservices.updateCurrentIncome(
                        updatedIncome, index);
                    Navigator.pop(context);
                  }
                },
                name: "Update Income")
          ],
        ),
      ),
    );
  }

  updateExpenseSheet(IncomeModel expense, int index) async {
    _amount.text = expense.amount.toString();
    _description.text = expense.description.toString();
    await showModalBottomSheet(
      context: context,
      builder: (context) => Form(
        key: updateKey,
        child: Column(
          children: [
            CustomFormField(controller: _amount, hintText: "Amount"),
            CustomFormField(controller: _description, hintText: "Description"),
            CustomButton(
                ontap: () async {
                  if (updateKey.currentState!.validate()) {
                    IncomeModel updatedExpense = IncomeModel(
                        amount: double.parse(_amount.text),
                        title: expense.title,
                        description: _description.text,
                        createdAt: DateTime.now(),
                        id: expense.id,
                        currentUserId: expense.currentUserId);
                    final incomeservices = Provider.of<IncomeExpenseServices>(
                        context,
                        listen: false);
                    incomeservices.updateCurrentExpense(updatedExpense, index);
                    Navigator.pop(context);
                  }
                },
                name: "Update Income")
          ],
        ),
      ),
    );
  }
}
