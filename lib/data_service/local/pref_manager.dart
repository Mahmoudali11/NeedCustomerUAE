import "package:shared_preferences/shared_preferences.dart";
abstract class PrefManager{

  static String userDetails="UserDetails";
  static String token="token";
  static String username="username";
  static String password="password";
  static String sessionTime="sessionTime";



  static SharedPreferences? _instant;
  static setValue(String key,String? v)async{
      if(_instant==null){
        _instant=await SharedPreferences.getInstance();
      }
      if(v!=null){
      _instant?.setString(key, v);}


  } static Future<String?> getValue(String key)async{
      if(_instant==null){
        _instant=await SharedPreferences.getInstance();
      }

     return await _instant?.getString(key);


  } static removeValue(String key)async{
      if(_instant==null){
        _instant=await SharedPreferences.getInstance();
      }

      _instant?.remove(key);


  }

}