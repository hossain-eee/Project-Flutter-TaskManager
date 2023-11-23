class Urls {
  Urls._(); // singleton
  //if anytime base url or any other url is chnaged, then we need to chnage just here not all over the app wehere we applied api
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static String registration = "$_baseUrl/registration";
  static String login = "$_baseUrl/login";
  static String createTask = "$_baseUrl/createTask";
  static String taskStatusCount = "$_baseUrl/taskStatusCount";
  static String newTask = "$_baseUrl/listTaskByStatus/New";
  static String inProgressTask = "$_baseUrl/listTaskByStatus/Progress";
  static String completedTask = "$_baseUrl/listTaskByStatus/Completed";
  static String cancelledTask = "$_baseUrl/listTaskByStatus/Cancelled";
  static String deleteTask(String id) =>
      "$_baseUrl/deleteTask/$id"; //treat as a function, because we need id as a parameter, in post man id is in String data type
  static String updateTaskStatus(String id, String status) =>
      "$_baseUrl/updateTaskStatus/$id/$status"; //treat as a function, because we need id and status as a parameter, in post man id is in String data type

  static String updateProfile = "$_baseUrl/profileUpdate";
  static String sendOtpToEmail(String email) =>
      "$_baseUrl/RecoverVerifyEmail/$email";
  static String otpVerify(String email, String otp) =>
      "$_baseUrl/RecoverVerifyOTP/$email/$otp";
  static String resetPassword = "$_baseUrl/RecoverResetPass";
}
