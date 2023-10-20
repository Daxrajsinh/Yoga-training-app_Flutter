import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static String timeKey = "TIMEKEY";
  static String lastDoneOn = "LASTDONEON";
  static String StreakKey = "StreakKey";
  static String KcalKey = "kcalKey";
  static String WorkOutTimeKey = "WorkOutTimeKey";
  static String FirstTime = "FIRSTTIMEKEY";

  //To calculate workout duration
  static Future<bool> setStartTime(String Time) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(timeKey, Time);
  }

  static Future<String?> getStartTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(timeKey);
  }

//To maintain the streak increment

  static Future<bool> setLastDoneOn(String Date) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(lastDoneOn, Date);
  }

  static Future<String?> getLastDoneOn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(lastDoneOn);
  }

//To fetch and save the value of streak
  static Future<bool> setStreak(int streak) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(StreakKey, streak);
  }

  static Future<int?> getStreak() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(StreakKey);
  }

// To fetch and save the kCAL of workout
  static Future<bool> setkcal(int kcal) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(KcalKey, kcal);
  }

  static Future<int?> getKcal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(KcalKey);
  }

//To save and fetch the overall workout time
  static Future<bool> setWorkOutTime(int minutes) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setInt(WorkOutTimeKey, minutes);
  }

  static Future<int?> getWorkOutTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(WorkOutTimeKey);
  }

  static Future<bool> setFirstTime(bool isFirstTime) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(FirstTime, isFirstTime);
  }

  static Future<bool?> getFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(FirstTime);
  }
}
