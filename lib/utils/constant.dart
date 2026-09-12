import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GlobalKey bottomNavgationGlobalKey = GlobalKey();
Color primayColor = const Color(0xff268C6D);

Color erroColor = const Color(0xffcc0000);

enum Source { camera, gallary }

enum SourceLoginType { email, phone }

enum QuizType { random, specialist, ai }

enum QuestionSourceType { none, image, video, sound }

enum SocialMediaType { google, facebook, apple }
