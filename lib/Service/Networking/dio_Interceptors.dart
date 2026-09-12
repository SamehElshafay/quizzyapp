import 'package:dio/dio.dart';
import 'package:quizzy_app/Service/local/auth_token_service.dart';

class DioInterceptors extends Interceptor {
  final Dio dio;
  bool isHasToken;

  DioInterceptors(this.dio, {this.isHasToken = false});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Accept'] = "application/json";
    options.headers['Content-Type'] = "application/json";

    String accessToken = await AuthTokenService.instance.read() ?? "";
    options.headers['Authorization'] = 'Bearer $accessToken';

    // options.headers['Authorization'] = 'Bearer $accessToken';
    //  var accessToken = await TokenRepository().getAccessToken();

    // if (accessToken != null) {
    //   var expiration = await TokenRepository().getAccessTokenRemainingTime();

    //   if (expiration.inSeconds < 60) {
    //     dio.interceptors.requestLock.lock();

    //     // Call the refresh endpoint to get a new token
    //     await UserService()
    //         .refresh()
    //         .then((response) async {
    //       await TokenRepository().persistAccessToken(response.accessToken);
    //       accessToken = response.accessToken;
    //     }).catchError((error, stackTrace) {
    //       handler.reject(error, true);
    //     }).whenComplete(() => dio.interceptors.requestLock.unlock());
    //   }

    //   options.headers['Authorization'] = 'Bearer $accessToken';
    // }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}
