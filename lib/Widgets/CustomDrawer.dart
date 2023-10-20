import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_yoga/Screens/Home.dart';
import 'package:flutter_yoga/Screens/SplashScreen.dart';
import 'package:flutter_yoga/services/localdb.dart';

class CustomDrawer extends StatelessWidget {
  // const CustomDrawer({Key? key}) : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final bool isLoggedIn;

  CustomDrawer({required this.isLoggedIn});

  Future<void> logout(BuildContext context) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(isLoggedIn: false)));
  }

  Future<void> shareApp() async {
    await FlutterShare.share(
        title: 'Hey I am using Yoga For Beginners App',
        text: 'Hey I am using Yoga For Beginners App. It has best yoga workout for all age groups. You should try it once.',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("https://images.unsplash.com/photo-1545389336-cf090694435e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80"),
              ),
            ),
          ),
          // Add a Logout button
          if (isLoggedIn)
          ListTile(
            title: Text("Logout", style: TextStyle(fontSize: 18)),
            leading: Icon(Icons.logout, size: 25),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to log out?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        logout(context);
                      },
                      child: Text('Logout'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              );
            },
          ),
          // Other menu items
          ListTile(
            title: Text("Reset Progress", style: TextStyle(fontSize: 18)),
            leading: Icon(Icons.restart_alt_sharp, size: 25),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('RESET PROGRESS'),
                  actionsAlignment: MainAxisAlignment.center,
                  actionsPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  content: Text('This will reset all of your fitness data including Total Workout Time, Streak, and Burned Calories. The action cannot be reverted once done.'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel", style: TextStyle(fontSize: 20)),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 18, horizontal: 35)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await LocalDB.setWorkOutTime(0);
                        await LocalDB.setkcal(0);
                        await LocalDB.setStreak(0);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
                      },
                      child: Text("Reset", style: TextStyle(fontSize: 20)),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 18, horizontal: 35)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text("Share With Friends", style: TextStyle(fontSize: 18)),
            leading: Icon(Icons.share, size: 25),
            onTap: shareApp,
          )
        ],
      ),
    );
  }
}
