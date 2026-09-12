import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quizzy_app/model/settings_data_model.dart';

class EndPoint {
  EndPoint._();

  static String baseUrl = dotenv.get("BASE_URL");
  static final String login = dotenv.get("LOGIN");
  static final String logout = dotenv.get("LOGOUT");
  static final String register = dotenv.get("REGISTER");
  static final String checkUser = dotenv.get("CHECK_USER");
  static final String socialLogin = dotenv.get("SOCIAL_LOGIN");
  static final String guestLogin = "/api/auth/guest-login";
  static final String updateAcademicYear = "/api/auth/update-academic-year";
  // /api/academic-years
  static final String academiYears = dotenv.get("ACADEMIC_YEARS");

  static final String subjects = dotenv.get("SUBJECTS");

  static final String messgeApiResponse =
      dotenv.get("MESSAGE_API"); // to get Message Erro when occur Execption

  static final String verifyCode = dotenv.get("VERIFY_CODE");
  static final String forgetPassword = dotenv.get("FORGET_PASSWORD");
  static final String resetPassword = dotenv.get("RESET_PASSWORD");
  static final String veifyEmailCode = dotenv.get("VERIFY_EMAIL_CODE");
  static final String reSendVeifyEmail = dotenv.get("RESEND_VERIFY_EMAIL");
  static final String veifyPhoneCode = dotenv.get("VERIFY_PHONE_CODE");
  static final String reSendVeifyPhone = dotenv.get("RESEND_VERIFY_PHONE");

/*
VERIFY_PHONE_CODE="/api/auth/verify-phone-code"
RESEND_VERIFY_PHONE="/api/auth/sendVerifyPhone"
*/
  // Exams
  static final String exams = dotenv.get("EXAMS");
  static final String storeExams = dotenv.get("EXAMS");
  static final String startQuiz = dotenv.get("START_QUIZ");
  static final String answerQuestion = dotenv.get("ANSWER_QUESTION");
  static final String units = dotenv.get('UNITS');
  static final String questions = dotenv.get('QUESTIONS');
  static final String attemptAnswers = dotenv.get('ATTEMPT_ANSWERS');
  static final String achievements = dotenv.get('ACHIEVEMENTS');
  static final String ads = dotenv.get('ADS');
  static final String topStudent = dotenv.get('TOP_STUDENTS');
  static final String examAttempts = dotenv.get('EXAM_ATTEMPTS');

// Profile
/*
UPDATE_PROFILE="/api/auth/update-profile"
PROFILE="/api/auth/profile"
RECHARGE_ACCOUNT="/api/auth/recharge-account"
DELETE_ACCOUNT="/api/auth/delete-account"
rechargeAccount

*/
  static final String profile = dotenv.get('PROFILE');
  static final String updateProfile = dotenv.get('UPDATE_PROFILE');
  static final String rechargeAccount = dotenv.get('RECHARGE_ACCOUNT');
  static final String deleteAccount = dotenv.get('DELETE_ACCOUNT');
  // SETTINGS
  static final String settings = dotenv.get('SETTINGS');
  /*
TERMS="https://quizzy.quizzy.site/terms"

PRIVACY_POLICY="https://quizzy.quizzy.site/privacy_policy"
*/
// CONTACT_US
  static final String terms = "$baseUrl${dotenv.get('TERMS')}";
  static final String privacyPolicy = "$baseUrl${dotenv.get('PRIVACY_POLICY')}";
  static final String contactUs = dotenv.get('CONTACT_US');
  static final String cobonLocations = dotenv.get('COBON_LOCATION');

/*
TOP_STUDENTS="/api/exams/students/top"
EXAM_ATTEMPTS="/api/exams/exam_attempts/attempts"
*/

  static String showExamById({required int examId}) => "$exams/$examId";
  static String showExamAttempt({required int id}) => "$examAttempts/$id";
  static String getAttemptAnswers({required int examAttemptId}) =>
      "$attemptAnswers/$examAttemptId";

  /*
  EXAMS="/api/exams"
START_QUIZ="/api/exams/start"
ANSWER_QUESTION="/api/exams/answer_question"

  */

  static String getAcademiYearById({required int id}) => "$academiYears/$id";
  static String getSubjectById({required int id}) => "$subjects/$id";
  static String getUnitById({required int id}) => "$units/$id";

  static String getSendNoteOrWrongToQuestion({required int idQuestion}) =>
      "$questions/$idQuestion";

/*
Choose the Server Avalabilty to get the Base Url from it Like Firebase
or any End Point

*/
  static void setSettings(SettingsData settingsData) {
    baseUrl = settingsData.baseUrlApi ?? dotenv.get("BASE_URL");
  }
}
