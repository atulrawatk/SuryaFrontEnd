import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:surya/app/data/socket/SocketStrings.dart';
import 'package:surya/app/utils/network/network_connection.dart';

class SocketService {

  SocketService._();

  factory SocketService(){
    return SocketService._();
  }
  late IO.Socket? socket;
  late Map<String, String> roomJoined, newRoomJoined;

  //Creating Socket
  createSocketConnection({required String? userId,
      required String? notificationId}) async {
    String url = SocketStrings.socketUrl;
    debugPrint(url);
    debugPrint(userId);

  //  socket_connecting(context);

  //  String access_token = await App_data().get_session_token();
  //  debugPrint("access_token $access_token");
    debugPrint("access_token $notificationId");
    socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .disableAutoConnect()
            .enableForceNewConnection()

            .setQuery(<String, dynamic>{
              'nameSpace': "60af280e757692c7a6e1acf1", //userId
              'user': "60af280e757692c7a6e1acf1", //userId
              'token': "lr9PEdJKRZMG6D4ovbmJRlb0ygQKrhJT",
              "offerId": notificationId
            })
            .build());

    socket!.connect();

    socket!.onConnectError((data) {
      debugPrint(data.toString());
      if (socket != null) {
        close_socket();
        reconnect_socket();
      }
    });


    socket!.onConnectTimeout((data) {
      if (socket != null && !socket!.connected) {
        debugPrint("timeout ==== ");
        createSocketConnection(notificationId: "", userId: '');
      }
    });

    roomJoined = new Map();

    newRoomJoined = new Map();

   socket!.on("connect", (data)  {
    // Logger().w("wegfhjewgfubwef");
     debugPrint(" $data");
     //on_connected(userId, data, context)
   });

    socket!.on(
       "disconnect", (data) => {
      debugPrint("Disconnected   $data")
       //  on_disconnect(userId, _.toString(), context)
       });
  }

  // void socket_connecting(BuildContext context) {
  //   debugPrint("connnecting ===== ");
  //   final NetworkConnection get_internet_checker = Get.find();
  //   if (get_internet_checker != null) {
  //     get_internet_checker.checkInternetConnection(false, true);
  //   }
  // }

  void close_socket() {
    if (socket != null) {
      debugPrint("======= ${socket!.opts.toString()}");
      debugPrint("======= ${socket!.flags.toString()}");
      debugPrint("======= ${socket!.acks.toString()}");
      debugPrint("======= ${socket!.id}");
      debugPrint("======= inside close socket");
      //socket.close();
      socket!.dispose();
      socket = null;
    }
  }

  void reconnect_socket() {
    debugPrint("socket data $socket");
    if (socket == null) {
      debugPrint("socket data inside $socket");

      //Need to work
      createSocketConnection( notificationId: "", userId: '');
    }
  }
}
