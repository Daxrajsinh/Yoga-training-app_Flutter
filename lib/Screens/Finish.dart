import 'package:flutter/material.dart';
import 'package:flutter_yoga/services/localdb.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_yoga/Screens/Home.dart';

class Finish extends StatelessWidget {
  const Finish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider <UpdateFitnessModel>(
      create: (context)=>UpdateFitnessModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(

          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network("https://media.istockphoto.com/vectors/first-prize-gold-trophy-iconprize-gold-trophy-winner-first-prize-vector-id1183252990?k=20&m=1183252990&s=612x612&w=0&h=BNbDi4XxEy8rYBRhxDl3c_bFyALnUUcsKDEB5EfW2TY=" , width: 350, height: 350,),
                  Text(
                    "You have successfully completed this Yoga Pack!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 13 , horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("125" , style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold),),
                      Text("KCal" , style :TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Column(
                    children: [
                      Text("12" , style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold),),
                      Text("Minutes" , style :TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
            ),
            Divider(thickness: 2,),
            Container(
              child: Column(
                children: [

                ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home(isLoggedIn: true)),
                  );
                }, child: Container(
                  width: MediaQuery.of(context).size.width - 70,
                  padding: const EdgeInsets.all(18.0),
                  child: Text("DONE !" , style: TextStyle(fontSize: 20) , textAlign: TextAlign.center,),

                ))
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
            ),
            Consumer<UpdateFitnessModel>(
              builder: (context , myModel , child){
                return  Container();
              },

            )
          ],
        ),
      ),
    );
  }
}


class UpdateFitnessModel with ChangeNotifier{
UpdateFitnessModel(){
  print("IT WORKS");
  SetWorkoutTime();
  LastWorkOutDoneOn();
  SetMyKCAL(13);
}
int a = 1;

  void SetWorkoutTime() async{

    print("SetWorkoutTime");
String? StartTime = await LocalDB.getStartTime();
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(StartTime ?? "2022-05-24 19:31:15.182");
int difference = DateTime.now().difference(tempDate).inMinutes;
int? mywotime = await LocalDB.getWorkOutTime();
print(mywotime);
// LocalDB.setWorkOutTime( mywotime! + 59);
LocalDB.setWorkOutTime( mywotime! + difference);

  }


  void LastWorkOutDoneOn() async{
print("LAST WORKOUT DONE");


    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(await LocalDB.getLastDoneOn() ?? "2022-05-24 19:31:15.182");
    int difference = DateTime.now().difference(tempDate).inDays;
    if(difference == 0){
      print("GOOD JOB");


    }else{
      int? streaknow = await LocalDB.getStreak();
      LocalDB.setStreak( streaknow! +  1);

    }

await LocalDB.setLastDoneOn(DateTime.now().toString());
  }


  void SetMyKCAL(int myKCAL) async{
    print("SetMyKCAL");
    int? kcal = await LocalDB.getKcal();
    print(kcal);
    LocalDB.setkcal(kcal.toString() == "null" ? 0  : kcal! + myKCAL);

  }
//TODO: Set the initial value of streak and lastdone on in starting of app
}

