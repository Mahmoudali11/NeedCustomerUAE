import 'package:intl/intl.dart';

abstract class TextFormatting{

  static String formatDate(DateTime? date){

    DateFormat f=DateFormat.yMd("en");

    if(date!=null){
   return f.format(date);
  }
  return f.format(DateTime.now());
  }
  static String formatTime(DateTime? date){

    DateFormat f=DateFormat("hh:mm:ss a","en");

    if(date!=null){
   return f.format(date);
  }
  return f.format(DateTime.now());
  }

  static DateTime createDateTime(String timeStr, String dateStr) {
    // Parse time
    List<String> timeParts = timeStr.split(' ');
    List<String> timeNumbers = timeParts[0].split(':');
    int hour = int.parse(timeNumbers[0]);
    int minute = int.parse(timeNumbers[1]);
    bool isPM = timeParts[1] == 'PM';
    if (isPM && hour != 12) {
      hour += 12;
    } else if (!isPM && hour == 12) {
      hour = 0;
    }

    // Parse date
    List<String> dateNumbers = dateStr.split('/');
    int year = int.parse(dateNumbers[2]);
    int month = int.parse(dateNumbers[0]);
    int day = int.parse(dateNumbers[1]);

    // Create DateTime object
    DateTime resultDateTime = DateTime(year, month, day, hour, minute);
    return resultDateTime;
  }
  static String dateToDateTime(DateTime dateTime){


    var dateForm=DateFormat("yyyy-MM-dd HH:mm:ss","en");

    return dateForm.format(dateTime);
  }
}