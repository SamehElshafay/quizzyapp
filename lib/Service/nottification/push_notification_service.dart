import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/profile_repository_service.dart';
import 'package:quizzy_app/Service/local/cache_notification_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static const String _topicName = "general";
  Future<void> initPushNotification() async {
    requestNotificationPermissions();
    FirebaseMessaging.onMessage.listen((event) {
      print(event.messageType);
      print(event.messageId);
      print(event.senderId);
      print(event.notification!.title);
      print(event.notification!.body);
      print(event.data);
    });
    // _firebaseMessaging.onTokenRefresh.listen((String token) async {
    //   // Handle token refresh
    //   print('Token refreshed: $token');
    //   // Save the token to your server or update user's FCM token in the database

    //   // updateDeviceToken();
    // });
    if (CacheNotificationService.instance.isNotificationEnabled()) {
      await _subscribeToTopic(topicName: _topicName);
    }
  }

  void requestNotificationPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
  }

  Future<void> _subscribeToTopic({required String topicName}) async {
    await _firebaseMessaging.subscribeToTopic(topicName);
  }

  Future<void> _unSubscribeToTopic({required String topicName}) async {
    await _firebaseMessaging.subscribeToTopic(topicName);
  }

  void disableNotification() {
    _unSubscribeToTopic(topicName: _topicName);
    FirebaseMessaging.instance
        .deleteToken()
        .then((value) => debugPrint("The Notification is disabled"));
  }

  void activeNotification() {
    _subscribeToTopic(topicName: _topicName);
    updateDeviceToken();
  }

  Future<void> updateDeviceToken() async {
    /*
    Seaniro of Token When SignUp :
     We Send Device Token when SignUp
     We Send the Token each the User LogIn 
     We update the Token when the App unistall
     We update the Token when the disableNotification
    */
// Send a New Token for The Server because when call the Method getToken : it Create a New Token (Like Unistall the App)

    String? token = await getToken();
    await PofileRepositoryService()
        .updateProfile(
            deviceToken: token,
            name: CacheUserService.instance.getUser().name ?? "")
        .then((value) {
      debugPrint("Send a New Token $token to The Server");
      debugPrint(
          "Information that Sended ${value.data!.deviceToken} \n ${value.data!.name} ");
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}
