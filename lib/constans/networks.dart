abstract class NetworkApis{

  static const base="https://www.i-technician.com/";
  static const category="category.php";
  static const categoryGust="category.php?user=guest";
  static const saveEnquiry="saveEnquiry.php";
  static const login="login.php";
  static const register="register.php";
  static const resetPassword="resetpassword.php";
  static const resetPassEmail="resetpassword.php";
  static const refreshToken="refresh.php";
  static const getUserEnquires="getUserRequests.php";
  static const getOffers="offers.php";
  static const updatePayment="updateStatus.php";
  static const deleteAccount="deleteAccount.php";
  ////request header
static const requestHeader={
  "Content-Type":"application/json",
  "Accept":"*/*"
};
}