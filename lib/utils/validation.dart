class Validator {
  Validator._();

  static String? isValidPassword(String? password) {
  var res=password!.length >= 3;

    if(res){
    return null;
   }
   return "Not Valid Password";
  }

  static String? isValidEmail(String? email) {
    const emailRegExpString = r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
        r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
    var res= RegExp(emailRegExpString, caseSensitive: false).hasMatch(email!) ;
    if(res){
    return null;
   }
   return "Not Valid Email";
  }
  static bool isValidAddress(String address) {
    return address.length >= 7;
  }
  static String? isValidPhone(String? phone) {
    // final _phoneRegExpString = r'(^(?:[+0]9)?[0-9]{11}$)';
    final _phoneRegExpString1 = r'(^\+?5[0-9]{8}$)';
    var res= RegExp(_phoneRegExpString1).hasMatch(phone!) ;
   if(res){
    return null;
   }
   return "Not Valid Phone Number";
  }



 static String? isValidName(String? name) {
  if(name!=null &&name.length>2){
    return null;
  }
  return "Name Must more than 3 characters";
      
  }

 static bool isValidMeasure(String name) {
   return double.tryParse(name) != null;

  }



  static bool isValidDropDown(String hint,String value) {
    return value!= null && value != hint;
  }
  static bool isMatchPassword(String password, String matchPassword) {
    return password == matchPassword;
  }
}