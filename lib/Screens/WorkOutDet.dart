import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_yoga/Screens/Break.dart';
import 'package:flutter_yoga/Screens/Finish.dart';
import 'package:flutter_yoga/model/model.dart';
import 'package:flutter_yoga/services/localdb.dart';
import 'package:provider/provider.dart';


class WorkOutDet extends StatelessWidget {
  List<Yoga> ListOfYoga;
  int yogaindex;



   WorkOutDet({
    required this.ListOfYoga,
     required this.yogaindex,
   });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
      create: (context)=>TimerModelSec(context , ListOfYoga , yogaindex+1 ,ListOfYoga[yogaindex].SecondsOrTimes ) ,
      child: Consumer<TimerModelSec>(
          builder: (context , myModel , child){



        return WillPopScope(
          onWillPop: () async{
            myModel.show();
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 350,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(ListOfYoga[yogaindex].YogaImgUrl)
                            )
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(ListOfYoga[yogaindex].YogaTitle , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 20) , textAlign: TextAlign.center,),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 80),
                        padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 25),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: ListOfYoga[yogaindex].Seconds ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("00" , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30 ,color: Colors.white),),
                            Text(" : " , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30 ,color: Colors.white),),
                            Consumer<TimerModelSec>(
                              builder: (context , myModel , child){
                                return  Text( myModel.countdown.toString().length == 1 ? "0"+myModel.countdown.toString() : myModel.countdown.toString()  ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30 ,color: Colors.white),);
                              },

                            )],
                        ): Text("x${ListOfYoga[yogaindex].SecondsOrTimes}", style:  TextStyle(fontWeight: FontWeight.bold,fontSize: 30 ,color: Colors.white), )
                      ),
                      Spacer(),
                      SizedBox(height: 30,),
                      Consumer<TimerModelSec>(
                        builder: (context , myModel , child){
                          return  ElevatedButton(onPressed: (){
                            myModel.show();
                          }, child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
                              child: const Text("Pause" ,style: TextStyle(fontSize: 20),)));
                        },
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            yogaindex !=0 ?
                            Consumer<TimerModelSec>(
                              builder : (context ,myModel, child){
                                return TextButton(onPressed: () async{
                                  myModel.Pass();
                                  await Future.delayed(Duration(seconds: 1));
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BreakTime(ListOfYoga: ListOfYoga, yogaindex: yogaindex-1)));
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(ListOfYoga: ListOfYoga, yogaindex: yogaindex-1)));
                                }, child: Text("Previous" , style: const TextStyle(fontSize: 16),));
                              }
                            ): Container(),
                            yogaindex != ListOfYoga.length-1 ?
                            Consumer<TimerModelSec>(
                              builder : (context , myModel , child){
                                return TextButton(onPressed: () async{
                            myModel.Pass();
                            await Future.delayed(Duration(seconds: 1));
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BreakTime(ListOfYoga: ListOfYoga, yogaindex: yogaindex+1)));
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(ListOfYoga: ListOfYoga, yogaindex: yogaindex+1)));
                                }, child: Text("Next" , style: TextStyle(fontSize: 16),));
                              }

                            ) : Container()
                          ],
                        ),
                      ),
                      Divider( thickness: 2,),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
                            child: Text("Next: ${ yogaindex >= ListOfYoga.length-1 ? "Finish" : ListOfYoga[yogaindex+1].YogaTitle}" , style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),),
                          ))
                    ],
                  ),
                ),
                Consumer<TimerModelSec>(
                  builder: (context , myModel , child){
                    return  Visibility(
                        visible: myModel.visible,
                        child: Container(
                          color: Colors.blueAccent.withOpacity(0.9),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Pause" , style: TextStyle(fontSize: 40,color: Colors.white , fontWeight: FontWeight.bold),),
                              const SizedBox(height: 10,),
                              const Text("Yoga feels better" , style: TextStyle(fontSize: 13 , color: Colors.white),),
                              const SizedBox(height: 30,),
                              OutlinedButton(onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(ListOfYoga: ListOfYoga, yogaindex: 0,)));
                              }, child: const SizedBox(
                                width: 180,
                                child: Text("Restart" , style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                              ),
                              ),
                              OutlinedButton(
                                  onPressed: (){
                                Navigator.pop(context);
                              }, child: Container(
                                width: 180,
                                child: Text("Quit" , style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                              )
                              ),
                              OutlinedButton(
                                onPressed: (){
                                myModel.hide();
                              }, child: Container(
                                width: 180,
                                child: const Text("Resume" , textAlign: TextAlign.center,),
                              ), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)
                              ),
                              )
                            ],
                          ),
                        ));
                  },
                )
              ],
            ),
          ),
        );
  }
      ),);
  }
}

class TimerModelSec with ChangeNotifier{
  TimerModelSec(context , List<Yoga> ListOfYoga , int yogaindex, countdown ){
    setCDownValue(int.parse(countdown) , ListOfYoga[yogaindex - 1].Seconds);
    CheckIfLast(yogaindex  >= ListOfYoga.length-1 );
    MyTimerSec(context , ListOfYoga , yogaindex);
    ReadTime(yogaindex);
  }
  int countdown = 0;
  bool isLast = false;

  void ReadTime(int yogaindex){
    print(yogaindex);
    if(yogaindex == 1){
      String now = DateTime.now().toString();
      LocalDB.setStartTime(now);

    }

  }
  void CheckIfLast(bool Ans)
  {
    isLast = Ans;
  }
  void setCDownValue(int count, bool isSec ){
    countdown = isSec ? count : 10000;
  }
  bool visible = false;
  bool isPassed = false;


  MyTimerSec(context, List<Yoga> ListOfYoga , int yogaindex) async{
    Timer.periodic(Duration(seconds: 1), (timer) async{
     visible ? countdown+0 : countdown--;
      notifyListeners();
      if(countdown == 0){
        timer.cancel();
        isLast
            ?
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Finish()))
            :
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BreakTime(
ListOfYoga: ListOfYoga, yogaindex: yogaindex
        )));
      }
      else if(isPassed) {
        timer.cancel();
      }
    });
  }
  void show(){
    visible = true;
    notifyListeners();
  }
  void Pass(){
    isPassed = true;
    notifyListeners();
  }
  void hide(){
    visible  =  false;
    notifyListeners();
  }
}
