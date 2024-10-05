import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:personal_money_manager_apk/reusable_components/button.dart';
import 'package:personal_money_manager_apk/reusable_components/my_text.dart';
import 'package:personal_money_manager_apk/screen/screen_add.dart';
import 'package:personal_money_manager_apk/screen/screen_drawer.dart';
import 'package:personal_money_manager_apk/services/income_expense_services.dart';
import 'package:personal_money_manager_apk/services/user_services.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int touchedIndex = -1;
  late String userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => fetchData(),
    );
  }

  fetchData() async {
    final _userServices = Provider.of<UserServices>(context, listen: false);
    final _incomeOrExpenseServices =
        Provider.of<IncomeExpenseServices>(context, listen: false);
    final currentUser = await _userServices.currentUserData();
    await _incomeOrExpenseServices.calculateTotalIncome(currentUser.uid);
    await _incomeOrExpenseServices.calculateTottalExpense(currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserServices>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade500,
          title: const MyText(
            data: "Home",
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff3c1053),
            Color(0xffad5389),
          ])),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: FutureBuilder(
                          future: value.currentUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (snapshot.hasData) {
                                userId = snapshot.data!.uid;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const MyText(
                                      fontSize: 20,
                                      data: "Welcome  ",
                                      color: Colors.white,
                                    ),
                                    MyText(
                                        fontSize: 25,
                                        data: snapshot.data!.name,
                                        color: Colors.white)
                                  ],
                                );
                              } else {
                                return const MyText(
                                  fontSize: 20,
                                  data: "Error",
                                );
                              }
                            }
                          }),
                    ),
                    Button(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenAdd(
                                currentUserId: userId,
                                inorEx: true,
                              ),
                            )),
                        color: Colors.white,
                        data: "AddIncome",
                        boxcolor: Colors.green),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Button(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenAdd(
                                currentUserId: userId,
                                inorEx: false,
                              ),
                            )),
                        color: Colors.white,
                        data: "AddExpense",
                        boxcolor: const Color.fromARGB(255, 155, 19, 19)),
                  ],
                ),
              ),
              Consumer<IncomeExpenseServices>(builder: (context, value, child) {
                return Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 50,
                      sections: showingSections(
                          value.totalIncome, value.totalExpense),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        drawer: ScreenDrawer(),
      ),
    );
  }

  List<PieChartSectionData> showingSections(double income, double expense) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 80.0 : 70.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: income == 0.00 && expense == 0.00 ? 50 : income,
            title: income.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: income == 0.00 && expense == 0.00 ? 50 : expense,
            title: expense.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
