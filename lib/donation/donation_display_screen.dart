import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/payment_controller.dart';
import '../route/route_helpers.dart';

class DonationDisplayScreen extends StatefulWidget {
  DonationDisplayScreen({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<DonationDisplayScreen> {
  late WebViewController _webViewController;
  var _paymentController = Get.find<PaymentController>();
  //pk_live_51OBGhKKkUZbN8qqvfBcuthdshvhdq9BYMmF5WrNXzJrVWvjwIHza159rRrHyADKZE1wgqw9PVyjn95wBbMPjnHLu00e5Mw0ig9
  String apiKey =
      "pk_live_51OBGhKKkUZbN8qqvfBcuthdshvhdq9BYMmF5WrNXzJrVWvjwIHza159rRrHyADKZE1wgqw9PVyjn95wBbMPjnHLu00e5Mw0ig9";
  // String apiKey =
  //     "pk_test_51OBGhKKkUZbN8qqvBbx8k2evjE1bhMfEJt6VywvlKOAWivQp2khZNbYgE3wFLA1L62KQD27jIqLJ33b2HphbnLU3006udhce5b";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WebView(
          initialUrl: initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) =>
              _webViewController = webViewController,
          onPageFinished: (String url) {
            if (url == initialUrl) {
              _redirectToStripe(_paymentController.sessionId);
            }
          },
          navigationDelegate: (NavigationRequest request) async {
            if (request.url.startsWith('https://success')) {
              Get.offNamed(RouteHelpers.donationSuccessPage);
              // var restaurant = Get.find<RestaurantController>().restaurant;

              // bool isError =
              //     await ApiService.confirmTransaction(shopId: restaurant.id);
              // if (!isError) {
              //   var createTempId = await MyFunctions.regenerateTempId();
              // }
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (BuildContext context) => PaymentStatusPage(
              //     isError: isError,
              //   ),
              // ));
            } else if (request.url.startsWith('https://error')) {
              Get.offNamed(RouteHelpers.donationErrorPage);
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }

  String get initialUrl => 'https://marcinusx.github.io/test1/index.html';

  Future<void> _redirectToStripe(String sessionId) async {
    final redirectToCheckoutJs = '''
var stripe = Stripe(\'$apiKey\');
    
stripe.redirectToCheckout({
  sessionId: '${_paymentController.sessionId}'
}).then(function (result) {
  result.error.message = 'Error'
});
''';

    try {
      await _webViewController.evaluateJavascript(redirectToCheckoutJs);
    } on PlatformException catch (e) {
      if (!e.details.contains(
          'JavaScript execution returned a result of an unsupported type')) {
        rethrow;
      }
    }
  }
}
