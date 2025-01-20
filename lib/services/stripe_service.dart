import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StripeService {
  static const String _secretKey = 'sk_test_your_key';
  static const String _publishableKey = 'pk_test_your_key';

  static Future<void> initialize() async {
    Stripe.publishableKey = _publishableKey;
  }

  static Future<PaymentIntent> createPaymentIntent(
      int amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount.toString(),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $_secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return PaymentIntent.fromJson(json.decode(response.body));
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  static Future<void> makePayment(int amount, String currency) async {
    try {
      PaymentIntent intent = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: intent.clientSecret,
          merchantDisplayName: 'Flutter Foods',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
