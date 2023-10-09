import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyScreen extends StatefulWidget {
  PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForNetwork();
  }

  void checkForNetwork() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      AppConstant.noNetworkSnackbar();
    }
  }

  bool isPageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(text: "privacy_policy".tr),
      body: WebView(
        initialUrl:
            'http://rosarymeditationguide.com/privacy', // Replace with your URL
        javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
      ),
    );
  }
}
