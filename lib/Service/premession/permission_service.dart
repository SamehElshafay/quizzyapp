import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';

class PermissionService {
  static PermissionService? _instance;

  PermissionService._();
  static PermissionService get instance => _instance ??= PermissionService._();

  Future<bool> requestPermissions(Permission permission) async {
    PermissionStatus permissionStatus = await permission.status;

    if (permissionStatus.isGranted) {
      return true;
    }

    PermissionStatus status = await permission.request();

    if (status.isGranted) {
      return true;
    } else {
      if (status.isPermanentlyDenied) {
        // The user opted to never ask for the permission again, so navigate  them to the settings
        if (Platform.isIOS) return true;
        _showMessage(
            message:
                "يجب عليك إعطاء الصلاحية بالموافقة لكي يعمل التطبيق بدون اخطاء");

        await openAppSettings();
        permissionStatus = await permission.status;
        if (permissionStatus.isGranted) {
          return true;
        } else {
          return false;
        }
      } else {
        // The user denied the premission
        // Explain why the permission is needed and request again
        if (Platform.isIOS) return true;
        _showMessage(
            message:
                "يجب عليك إعطاء الصلاحية بالموافقة لكي يعمل التطبيق بدون اخطاء");

        return false;
      }
    }
  }

  Future<bool> checkStorage() async {
    /*
    IOS : use Specis Like Camera , phot in inoList
  if(Above Android 13){
   // use a Specisce Like Camera , vieo , photo
   // or if you wnat Files use MangeEternalStorage
 }else if (Low Android 13){
     use default in Android Maninfist Premession (READ_EXTERNAL_STORAGE , WRITE_EXTERNAL_STORAGE)
 }
  */

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt > 32) {
      // return await requestPermissions(Permission.manageExternalStorage);
      return true;
      /*
  return true;
This was Frustrating to solve myself.
 Apparently Android 13 on Flutter does not need permission or a package to work.
  Remove permission handler for storage and it will work just fine because in API 33
   no such permission exist so it will always return empty. Code Below


      */
    } else {
      return await requestPermissions(Permission.storage);
    }
  }

  Future<bool> checkCamera() async {
    return await requestPermissions(Permission.camera);
  }

  Future<bool> checkGallary() async {
    /*
 phohto work in ios and Android sdk Above 32+
    */
    Permission permission = Permission.photos;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        permission = Permission.storage;
      } else {
        permission = Permission.photos;
      }
    } else {
      // if is IOS
      permission = Permission.photos;
    }

    return await requestPermissions(permission);
  }

  void _showMessage({required String message}) {
    SnackBarHelper.instance.showMessage(
        message: message, isEnglish: false, erro: true, showByGetx: true);
  }
}
