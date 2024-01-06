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
}