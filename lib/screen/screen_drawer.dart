import 'package:flutter/material.dart';
import 'package:personal_money_manager_apk/reusable_components/my_text.dart';
import 'package:personal_money_manager_apk/screen/screen_splash.dart';
import 'package:personal_money_manager_apk/screen/screen_transaction.dart';
import 'package:personal_money_manager_apk/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenDrawer extends StatelessWidget {
  const ScreenDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Colors.amber.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Consumer<UserServices>(
                    builder: (context, value, child) => FutureBuilder(
                          future: value.currentUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (snapshot.hasData) {
                                return UserAccountsDrawerHeader(
                                    currentAccountPicture: CircleAvatar(
                                      radius: size.height * 0.8,
                                      child: Text(
                                        snapshot.data!.name[0].toUpperCase(),
                                        style: TextStyle(
                                            fontSize: size.height * 0.05),
                                      ),
                                    ),
                                    accountName: Text(snapshot.data!.name),
                                    accountEmail: Text(snapshot.data!.email));
                              } else {
                                return const UserAccountsDrawerHeader(
                                    accountName: Text("Error"),
                                    accountEmail: Text("Error"));
                              }
                            }
                          },
                        )),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Card(
                  elevation: 10,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScrenTransaction(
                              incExp: true,
                            ),
                          ));
                    },
                    leading: Icon(
                      Icons.currency_rupee,
                      color: Colors.green,
                    ),
                    title: MyText(fontSize: 20, data: "Income Transaction"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Card(
                  elevation: 10,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScrenTransaction(
                              incExp: false,
                            ),
                          ));
                    },
                    leading: Icon(
                      Icons.currency_rupee,
                      color: Colors.red,
                    ),
                    title: MyText(fontSize: 20, data: "Expense Transaction"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Card(
                elevation: 10,
                child: ListTile(
                  onTap: () async {
                    final _shrp = await SharedPreferences.getInstance();
                    _shrp.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenSplash(),
                        ),
                        (route) => false);
                  },
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  title: MyText(fontSize: 20, data: "SignOut"),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
