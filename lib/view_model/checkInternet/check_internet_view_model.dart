import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';

class CheckInternetViewModel extends GetxController {
  // var isDeviceConnected = false.obs;
  // late StreamSubscription _streamSubscription;

  // @override
  // void onInit() {
  //   _streamSubscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((ConnectivityResult result) async {
  //     if (result != ConnectivityResult.none) {
  //       isDeviceConnected.value =
  //           await InternetConnectionChecker().hasConnection;
  //       _updateState();
  //     }
  //   });
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   _streamSubscription.cancel();
  // }

  // void _updateState() {
  //   if (isDeviceConnected.value) {
  //     SnackBarHelper.instance.showMessage(message: "Hava Internt");
  //   } else {
  //     SnackBarHelper.instance.showMessage(message: "No Internt");
  //   }
  // }

  // Future<bool> isConnectionExist() async {
  //   return await InternetConnectionChecker().hasConnection;
  // }
}
