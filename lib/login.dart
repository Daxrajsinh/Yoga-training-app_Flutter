import 'package:flutter/material.dart';
import 'package:flutter_yoga/database/mongodb_service.dart';
import 'package:flutter_yoga/Screens/Home.dart';

class MyLogin extends StatefulWidget {
  bool isLoggedIn = false;
  MyLogin({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final MongoDBService _mongoDBService = MongoDBService();

  @override
  void initState() {
    super.initState();
    _mongoDBService.connect();// Connect to MongoDB when the widget initializes
    print('Called connect method');
  }

  @override
  void dispose() {
    _mongoDBService
        .close(); // Close the MongoDB connection when the widget is disposed
    super.dispose();
  }

  void _loginUser() async {
    // Ensure email and password are not empty
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect password'),
        ),
      );
      return;
    }

    try {
      // Find the user by email
      final user = await _mongoDBService.findUserByEmail(_emailController.text);

      if (user != null) {
        // Check if the provided password matches the stored password
        if (user['password'] == _passwordController.text) {
          // User authentication successful

          // Get the username if it exists, or use a default value if it's null or empty
          final username = user['username'];
          bool isuserLoggedIn = true;
          if (username != null && username.isNotEmpty) {

            // Navigate to the home page and pass the username as a parameter
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Home(isLoggedIn: isuserLoggedIn),
            ));
          } else {
            // Username is empty or null, show a message without the username
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Home(isLoggedIn: isuserLoggedIn),
            ));
          }
        } else {
          // Password is incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Incorrect password'),
            ),
          );
        }
      } else {
        // User not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not found'),
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occurred during login
      print('Error during login: $e');
      // You might want to show an error message to the user
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background_img2.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 190, top: 130),
              child: Text(
                'Welcome To\n Yoga App',
                style: TextStyle(color: Colors.black, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Text(
                            "                         Please login to continue\n",
                            style: TextStyle(
                              fontSize: 18, // Adjust the font size as needed
                            )
                          ),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _emailController,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: TextStyle(),
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.orangeAccent,
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: _loginUser,
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}