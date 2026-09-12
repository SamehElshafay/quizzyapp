import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/end_point.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class TermsViewModel extends GetxController {
  late final WebViewController _controller;
  bool _isLoadPage = false;
  late final PlatformWebViewControllerCreationParams params;
  WebViewController get controller => _controller;
  bool get isLoadPage => _isLoadPage;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    debugPrint('Intilze the TermsViewModel');
    _isLoadPage = false;
    _initWebView();
  }

  void _initWebView() {
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params);
// ···
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          // onNavigationRequest: (NavigationRequest request) {
          //   // if (request.url.startsWith('https://www.youtube.com/')) {
          //   //   debugPrint('blocking navigation to ${request.url}');
          //   //   return NavigationDecision.prevent;
          //   // }
          //   // debugPrint('allowing navigation to ${request.url}');
          //   // return NavigationDecision.navigate;

          // },
        ),
      )
      ..loadRequest(Uri.parse(EndPoint.terms)).then((value) {
        _isLoadPage = true;
        update();
      });
  }

  @override
  void onClose() {
    _controller.clearCache();
    _controller.clearLocalStorage();

    super.onClose();
  }
}
