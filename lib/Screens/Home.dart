import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yoga/Screens/Startup.dart';
import 'package:flutter_yoga/Widgets/CustomAppBar.dart';
import 'package:flutter_yoga/Widgets/CustomDrawer.dart';
import 'package:flutter_yoga/model/model.dart';
import 'package:flutter_yoga/services/localdb.dart';
import 'package:flutter_yoga/services/yogadb.dart';
import 'package:flutter_yoga/login.dart';

class Home extends StatefulWidget {
  bool isLoggedIn = false;
  Home({Key? key, required this.isLoggedIn}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween, _homeTween, _yogaTween, _iconTween, _drawerTween;
  late AnimationController _textAnimationController;

  bool isLoading = true;
  late List<YogaSummary> yogasumlst;
  Future readYogaSumEntry() async {
    yogasumlst = await YogaDatabase.instance.readAllYogaSum();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_animationController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.lightBlue)
        .animate(_animationController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _homeTween = ColorTween(begin: Colors.white, end: Colors.blue)
        .animate(_animationController);
    _yogaTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _textAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    super.initState();
    GetFitnessData();


    readYogaSumEntry();
  }

  int? streak;
  int? kcal;
  int? womin;
  void GetFitnessData() async {
    streak = await LocalDB.getStreak();
    kcal = await LocalDB.getKcal();
    womin = await LocalDB.getWorkOutTime();

    print(await LocalDB.getLastDoneOn());
    setState(() {});
  }

  bool scrollListner(ScrollNotification scrollNotification) {
    bool scroll = false;
    if (scrollNotification.metrics.axis == Axis.vertical) {
      _animationController.animateTo(scrollNotification.metrics.pixels / 80);
      _textAnimationController.animateTo(scrollNotification.metrics.pixels);
      return scroll = true;
    }
    return scroll;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(body: Center())
        : Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(isLoggedIn: widget.isLoggedIn),
      backgroundColor: Colors.transparent,
      body: NotificationListener(
        onNotification: scrollListner,
        child: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/bg2.jpg', // Replace with your image path
              fit: BoxFit.cover, // Adjust the fit as needed
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              height: double.infinity,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(50, 100, 50, 40),
                              decoration: const BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(13),
                                  bottomLeft: Radius.circular(13),
                                ),
                              ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        widget.isLoggedIn ? (streak.toString() == "null" ? "0" : streak.toString()) : "0",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 23,
                                        ),
                                      ),
                                      const Text(
                                        "Streak",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        widget.isLoggedIn ? (kcal.toString() == "null" ? "0" : kcal.toString()) : "0",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 23,
                                        ),
                                      ),
                                      const Text(
                                        "Cal",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        widget.isLoggedIn ? (womin.toString() == "null" ? "0" : womin.toString()) : "0",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 23,
                                        ),
                                      ),
                                      const Text(
                                        "Minutes",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  if (!widget.isLoggedIn)
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black87, // Change the background color to black
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Please Login to Continue\n",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20, // Increase the font size
                                              color: Colors.orangeAccent, // Change the text color to white
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) => MyLogin(isLoggedIn: false),
                                                ),
                                              );
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.orangeAccent, // Change the button color to black
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25), // Increase the button size
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15), // Add rounded corners
                                              ),
                                              elevation: 3, // Add a subtle shadow to the button
                                            ),
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                fontSize: 18, // Increase the button text size
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontFamily: 'Raleway'
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (widget.isLoggedIn)
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: const Text(
                                        "Our Yoga Packs",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                        if (widget.isLoggedIn)
                                          SingleChildScrollView(
                                            child:ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: yogasumlst.length,
                                              itemBuilder: (context, index) {
                                                // ... (yoga list rendering code remains the same)
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => Startup(
                                                                yogaSum:
                                                                yogasumlst[
                                                                index],
                                                                Yogakey: yogasumlst[
                                                                index]
                                                                    .yogakey
                                                                    .toString())));
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.only(
                                                        bottom: 20),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: 150,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: AssetImage(
                                                                      yogasumlst[
                                                                      index]
                                                                          .BackImg
                                                                          .toString()))),
                                                        ),
                                                        Container(
                                                          height: 150,
                                                          color: Colors.black26,
                                                        ),
                                                        Positioned(
                                                          right: 20,
                                                          left: 10,
                                                          top: 10,
                                                          child: Text(
                                                            yogasumlst[index]
                                                                .YogaWorkOutName,
                                                            style: const TextStyle(
                                                                color:
                                                                Colors.white,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 30,
                                                          left: 12,
                                                          top: 38,
                                                          child: Text("${yogasumlst[index]
                                                              .TimeTaken} Minutes || ${yogasumlst[index]
                                                              .TotalNoOfWork} Workouts"
                                                            ,
                                                            style: const TextStyle(
                                                                color:
                                                                Colors.white,
                                                                fontSize: 10),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomAppBar(
                            animationController: _animationController,
                            colorsTween: _colorTween,
                            drawerTween: _drawerTween,
                            homeTween: _homeTween,
                            iconTween: _iconTween,
                            onPressed: () {
                              scaffoldKey.currentState?.openDrawer();
                            },
                            yogaTween: _yogaTween,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
