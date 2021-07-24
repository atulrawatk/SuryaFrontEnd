class SocketStrings{
  // static String SocketURl =
  //     "http://2fb24ca8ff45.ngrok.io/${Temp_UserModel.Temp_UserModel.userId}";


  static String socketUrl =
      "http://14.142.186.249:3001/60af280e757692c7a6e1acf1";


  //static String SocketURl="https://messaging.surya-app.com/${Temp_UserModel.Temp_UserModel.userId}";
  //static String SocketURl="ws://ec2-65-0-70-46.ap-south-1.compute.amazonaws.com:3001/${Temp_UserModel.Temp_UserModel.userId}";
  static String deliverMessage = "DELIVER_MESSAGE";
  static String receiveMessage = "RECEIVE_MESSAGE";
  static String readMessage = "READ_MESSAGE";
  static String sendMessage = "SEND_MESSAGE";
  static String createThread = "CREATE_THREAD";
  static String joinRoom = "JOIN_ROOM";
  static String join = "JOIN";
  static String typing = "TYPING";
  static String deleteMessage = "DELETE_MESSAGE";
  static String exchangeKeys = "EXCHANGE_KEY";
  static String threadUpdate = "THREAD_UPDATE";
  static String newThread = "NEW_THREAD";
  static String createGroup = "CREATE_GROUP";
  static String threadActivity = "THREAD_ACTIVITY";
  static String blockUser = "BLOCK";
  static String leaveRoom = "LEAVE_ROOM";
  static String adminCreate = "ADMIN_CREATE";
  static String adminRemove = "ADMIN_REMOVE";
  static String threadChange = "THREAD_CHANGE";

  static String userStatus = "STATUS";
  static String userOnline = "ONLINE";
  static String userOffline = "OFFLINE";
  static String userReactivate = "USER_ACTIVITY";

  //webrtc
  static String callEvent = "CALL";
  static String callOffer = "OFFER";
  static String callAnswer = "ANSWER";
  static String callCandidate = "CANDIDATE";
  static String callLeave = "LEAVE";
  static String callBusy = "BUSY";

  //Activity Types
  static String groupName = "GroupName";
  static String groupProfilePic = "GroupProfilePic";
  static String groupLeave = "Leave";
  static String groupAdd = "Add";
  static String groupRemove = "Remove";
}