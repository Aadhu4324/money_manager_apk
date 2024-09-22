import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_money_manager_apk/model/income_expanse_model.dart';

class IncomeExpenseServices with ChangeNotifier {
  double _totalIncome = 0.00;
  double _totalExpense = 0.00;
  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;
  Box<IncomeModel>? expenseBox;
  //openIncomeBox

  Future<Box<IncomeModel>> openIncomeBox() async {
    final incomeBox = await Hive.openBox<IncomeModel>("Income");
    return incomeBox;
  }
  //addIncome

  Future<void> addIncome(IncomeModel income) async {
    final incomBox = await openIncomeBox();
    print(totalIncome);
    await incomBox.add(income);
    await calculateTotalIncome(income.currentUserId);

    notifyListeners();
  }

//getAllIncomedata Based on current user
  Future<List<IncomeModel?>> getAllIncome(String currentUserId) async {
    final incomeBox = await openIncomeBox();
    return incomeBox.values
        .where(
          (element) => currentUserId == element.currentUserId,
        )
        .toList();
  }
  //calculateTottal Income

  Future<void> calculateTotalIncome(String currentUserId) async {
    final List<IncomeModel?> income = await getAllIncome(currentUserId);
    _totalIncome = income.fold(0.00, (previousValue, income) {
      return previousValue + income!.amount;
    });
    notifyListeners();
    print(totalIncome);
  }

  //update income
  Future<void> updateCurrentIncome(IncomeModel income, int index) async {
    final incomeBox = await openIncomeBox();
    await incomeBox.putAt(index, income);
    await calculateTotalIncome(income.currentUserId);
  }

  //delete Income
  Future<void> deleteCurrentIncome(int index, IncomeModel income) async {
    final incomeBox = await openIncomeBox();
    await incomeBox.deleteAt(index);
    print("deleted");
    await calculateTotalIncome(income.currentUserId);
  }

//openExpense Box
  Future<void> openExpenseBox() async {
    expenseBox = await Hive.openBox<IncomeModel>("Expense");
  }

//addExpense
  Future<void> addExpense(IncomeModel expense) async {
    if (expenseBox == null) {
      await openExpenseBox();
    }
    await expenseBox!.add(expense);
    await calculateTottalExpense(expense.currentUserId);
  }
  //getAll Expense based on Current User

  Future<List<IncomeModel>> getAllExpense(currentUserId) async {
    if (expenseBox == null) {
      await openExpenseBox();
    }
    return expenseBox!.values.where(
      (element) {
        return element.currentUserId == currentUserId;
      },
    ).toList();
  }
  //calculateTotal expense

  Future<void> calculateTottalExpense(currentUserId) async {
    if (expenseBox == null) {
      await openExpenseBox();
    }
    final expense = await getAllExpense(currentUserId);
    _totalExpense = expense.fold(
      0.00,
      (previousValue, element) => previousValue + element.amount,
    );
    notifyListeners();
  }
  //updateExpense

  Future<void> updateCurrentExpense(IncomeModel expense, int index) async {
    if (expenseBox == null) {
      await openExpenseBox();
    }
    await expenseBox!.putAt(index, expense);
    await calculateTottalExpense(expense.currentUserId);
  }

  Future<void> deleteCureentexpense(IncomeModel expense, int index) async {
    if (expenseBox == null) {
      await openExpenseBox();
    }

    await expenseBox!.deleteAt(index);
    await calculateTottalExpense(expense.currentUserId);
  }
}
