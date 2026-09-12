import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/settings_repository_service.dart';
import 'package:quizzy_app/Service/local/auth_route_service.dart';
import 'package:quizzy_app/Service/local/cache_notification_service.dart';
import 'package:quizzy_app/Service/local/cache_settings_service.dart';

import 'package:quizzy_app/Service/local/cache_subject_service.dart';
import 'package:quizzy_app/Service/local/cache_theme_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';

import 'package:quizzy_app/firebase_options.dart';
import 'package:quizzy_app/model/Image_dimensions_model.dart';
import 'package:quizzy_app/model/academic_year_model.dart';
import 'package:quizzy_app/model/book_model.dart';
import 'package:quizzy_app/model/data_subject_model.dart';
import 'package:quizzy_app/model/settings_data_model.dart';
import 'package:quizzy_app/model/settings_model.dart';
import 'package:quizzy_app/model/subjects_model.dart';
import 'package:quizzy_app/model/user_model.dart';

import 'package:quizzy_app/utils/binding/splash_binding.dart';
import 'package:quizzy_app/utils/constant.dart';

import 'package:quizzy_app/utils/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
  print(message.notification!.title);
  print(message.notification!.body);
  // SnackBarHelper.instance.showMessage(message: "Mohamed", showByGetx: true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Future.wait([dotenv.load(fileName: ".env"), Hive.initFlutter()]);

  Hive.registerAdapter(AcademicYearModelAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SubjectsModelAdapter());
  Hive.registerAdapter(DataSubjectModelAdapter());
  Hive.registerAdapter(BookModelAdapter());
  Hive.registerAdapter(ImageDimensionsModelAdapter());
  Hive.registerAdapter(SettingsDataAdapter());
  Hive.registerAdapter(SettingsModelAdapter());

  await Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    AuthRouteService.instance.init(),
    CacheUserService.instance.init(),
    CacheSubjectService.instance.init(),
    CacheNotificationService.instance.init(),
    CacheThemeService.instance.init(),
    CacheSettingsService.instance.init(),
  ]);

  await SettingsRepositoryService().getSettings().then((value) async {
    await CacheSettingsService.instance.updateSettings(settingsModel: value);
    CacheSettingsService.instance.getStudentData(); // cache Student Data
  }).catchError((e) => debugPrint(e.toString()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return GetBuilder<ThemeViewMode>(
          init: ThemeViewMode(),
          id: "updateTheme",
          builder: (controller) {
            return GetMaterialApp(
              title: 'Quizzy App',
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.initialRoute,
              initialBinding: SplashBinding(),
              getPages: Routes.getPages(),
              navigatorKey: navigatorKey,
              theme: controller.themeValue,
            );
          },
        );
      },
    );
  }
}
