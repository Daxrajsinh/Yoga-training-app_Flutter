import 'package:flutter/material.dart';
import 'package:flutter_yoga/Screens/Home.dart';
import 'package:flutter_yoga/login.dart';
import 'package:flutter_yoga/model/model.dart';
import 'package:flutter_yoga/services/localdb.dart';
import 'package:flutter_yoga/services/yogadb.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future makeYogaEntry(Yoga yoga, String TableName) async {
    await YogaDatabase.instance.Insert(yoga, TableName);
  }

  Future makeYogaSumEntry(YogaSummary yogaSummary) async {
    await YogaDatabase.instance.InsertYogaSum(yogaSummary);
  }


  checkUp() async{
    await LocalDB.getFirstTime().then((value) async {
      if (value.toString() == "null" || value != false) {
        print("First Time Entering");
        await LocalDB.setStreak(0);
        await LocalDB.setLastDoneOn(
            DateTime.now().subtract(Duration(days: 1)).toString());
        await LocalDB.setkcal(0);
        await LocalDB.setWorkOutTime(0);
        await LocalDB.setFirstTime(false);

        makeYogaSumEntry(YogaSummary(YogaWorkOutName: YogaModel.YogaTable1,
            BackImg: "assets/01_Suryanamskar/main.jpg",
            TimeTaken: "6",
            TotalNoOfWork: "12",
            yogakey: 1));
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/1.png",
            YogaTitle: "Pranamasana (Prayer pose)",
            SecondsOrTimes: '15',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/2.png",
            YogaTitle: "Hastauttanasana (Raised arms pose)",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/3.png",
            YogaTitle: "Uttanasana (Standing forward bend)",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/4.png",
            YogaTitle: "Ardha Uttanasana (half-standing forward bend)",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/5.png",
            YogaTitle: "Exhale and return to the forward fold",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/6.png",
            YogaTitle: "Get into a plank pose",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/7.png",
            YogaTitle: "Lower yourself into a low pushup",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/8.png",
            YogaTitle: "Urdhva Mukha Svanasana(Inhale and enter an upward dog pose)",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/9.png",
            YogaTitle: "Adho Mukha Svanasana (downward pose)",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/10.png",
            YogaTitle: "Move back into the standing forward bend",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/11.png",
            YogaTitle: "Inhale and move back into the upward salute",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/01_Suryanamskar/12.png",
            YogaTitle: "Exhale and return to the mountain pose",
            SecondsOrTimes: '15',
            YogaKey_WorkOuts: 1), YogaModel.YogaTable1,);

        makeYogaSumEntry(YogaSummary(YogaWorkOutName: YogaModel.YogaTable2,
            BackImg: "assets/02_WeightLossYoga/main.jpg",
            TimeTaken: "6",
            TotalNoOfWork: "12",
            yogakey: 2));
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/1.jpeg",
            YogaTitle: "Practice yoga walking every day for 30 minutes on weekdays and at least an hour on weekends. ",
            SecondsOrTimes: '15',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/2.jpeg",
            YogaTitle: "Stomp your anger into the ground while you walk.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/3.jpeg",
            YogaTitle: "Feel your sadness.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/4.jpeg",
            YogaTitle: "Rotate your shoulders.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/5.jpeg",
            YogaTitle: "Rotate your spine.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/6.jpeg",
            YogaTitle: "Allow a healing color to trickle through your body from head to foot. ",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/7.jpeg",
            YogaTitle: "Concentrate as you walk connected to the ground.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/8.jpeg",
            YogaTitle: "Move one hand and send someone a positive sentence.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/9.jpeg",
            YogaTitle: "Imagine the numbers 1 to 20 in your head, chest, abdomen, legs, feet, and into the ground (beneath the feet).",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/10.jpeg",
            YogaTitle: "Visualize a beautiful sun in the sky and clothe yourself with a golden ray of sunshine.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/11.jpeg",
            YogaTitle: "Stop all thoughts.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/02_WeightLossYoga/12.jpeg",
            YogaTitle: "Walk freely. ",
            SecondsOrTimes: '15',
            YogaKey_WorkOuts: 2), YogaModel.YogaTable2,);

        makeYogaSumEntry(YogaSummary(YogaWorkOutName: YogaModel.YogaTable3,
            BackImg: "assets/03_KidsYoga/main.jpeg",
            TimeTaken: "6",
            TotalNoOfWork: "10",
            yogakey: 3));
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/1.jpeg",
            YogaTitle: "Kneel on your hands and knees.",
            SecondsOrTimes: '15',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/2.jpeg",
            YogaTitle: "Breathe out and lower yourself down.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/3.jpeg",
            YogaTitle: "Bring your forehead to the floor",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/4.jpeg",
            YogaTitle: "Position your arms.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/5.jpeg",
            YogaTitle: "Breathe and hold the pose.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/6.jpeg",
            YogaTitle: "Determine if you should be doing child's pose.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/7.jpeg",
            YogaTitle: "Make the pose comfortable for stiff joints.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/8.jpeg",
            YogaTitle: "Increase the stretch of your torso.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/9.jpeg",
            YogaTitle: "Rest your forehead on your hands.",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
        makeYogaEntry(Yoga(Seconds: true,
            YogaImgUrl: "assets/03_KidsYoga/10.jpeg",
            YogaTitle: "Use pillows and cushions",
            SecondsOrTimes: '30',
            YogaKey_WorkOuts: 3), YogaModel.YogaTable3,);
      } else {
        print("NOT A FIRST TIME");
      }
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUp();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(isLoggedIn: false)));
    });
    //CHECK INSTALLATION,INSERT,READ,UPDATE,OPERATION STATUS

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/logo/yoga_trasparent.png")
      ),
    );
  }
}
