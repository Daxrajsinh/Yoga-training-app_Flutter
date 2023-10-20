import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_yoga/Screens/WorkOutDet.dart';
import 'package:flutter_yoga/model/model.dart';
import 'package:provider/provider.dart';

class BreakTime extends StatelessWidget {
  List<Yoga> ListOfYoga;
  int yogaindex;

  BreakTime({
    required this.ListOfYoga,
    required this.yogaindex,

  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>
      (create:(context)=>TimerModelSec(context , ListOfYoga , yogaindex) ,
    child: Consumer<TimerModelSec>(
      builder: (context, myModel, mychild){


      return WillPopScope(
        onWillPop: () async{
          myModel.show();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                const Text("Break Time" , style: TextStyle(fontSize: 35 , fontWeight: FontWeight.bold, color: Colors.white),),
                    Consumer<TimerModelSec>(
                      builder: (context , myModel , child){
                        return  Text(myModel.countdown.toString() ,style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 65 ,color: Colors.white),);
                      },

                    ),
                    const SizedBox(height: 20,),
                    Consumer<TimerModelSec>(
                      builder: (context , myModel, child){
                        return ElevatedButton(onPressed: (){

myModel.skip();

                        }, child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 24),

                          child: Text("SKIP" ,style: TextStyle(fontSize: 19 , color: Colors.black),),
                        ) , style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white) ),);
                      },

                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          yogaindex !=0 ?
                          Consumer<TimerModelSec>(
                              builder : (context ,myModel, child){
                                return TextButton(onPressed: () async{
                                  myModel.Pass();
                                  await Future.delayed(const Duration(seconds: 1));
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BreakTime(ListOfYoga: ListOfYoga, yogaindex: yogaindex-1)));
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(ListOfYoga: ListOfYoga, yogaindex: yogaindex-1)));
                                }, child: const Text("Previous" , style: TextStyle(fontSize: 16, color: Colors.white),));
                              }

                          ): Container(),
                          yogaindex != ListOfYoga.length-1 ?



                          Consumer<TimerModelSec>(
                              builder : (context , myModel , child){
                                return TextButton(onPressed: () async{
                                  myModel.Pass();

                                  await Future.delayed(const Duration(seconds: 1));
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BreakTime(ListOfYoga: ListOfYoga, yogaindex: yogaindex+1)));
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(ListOfYoga: ListOfYoga, yogaindex: yogaindex+1)));
                                }, child: const Text("Next" , style: TextStyle(fontSize: 16 , color: Colors.white),));
                              }

                          ) : Container()
                        ],
                      ),
                    ),          const Divider( thickness: 2,),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(

                          padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
                          child:  Text("Next: ${ yogaindex >= ListOfYoga.length-1 ? "FINISH" : ListOfYoga[yogaindex].YogaTitle}" , style: const TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold ,color: Colors.white),),
                        )),


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
          )


        ),
      );
    }
    ));
  }
}



class TimerModelSec with ChangeNotifier{
  TimerModelSec(context, List<Yoga> ListOfYoga , int yogaindex ){
    MyTimerSec(context  , ListOfYoga , yogaindex);
  }
  int countdown = 10;
  bool isPassed = false;
  bool visible = false;
bool  Isskip = false;
  MyTimerSec(context , List<Yoga> ListOfYoga , int yogaindex) async{
    Timer.periodic(const Duration(seconds: 1), (timer) {
      visible ? countdown+0 : countdown--;
      notifyListeners();
      if(countdown == 0 || Isskip){
        timer.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(
ListOfYoga: ListOfYoga, yogaindex: yogaindex,
        )));
      }

      else if(isPassed) {
        timer.cancel();


      }
    });
  }


  void skip(){
    Isskip = true;
    notifyListeners();
  }
  void show(){
    visible = true;
    notifyListeners();
  }
  void hide(){
    visible  =  false;
    notifyListeners();
  }
  void Pass(){
    isPassed = true;
    notifyListeners();
  }

}
