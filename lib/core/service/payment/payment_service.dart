import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fintech/core/app/env_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  PaymentService._privateConstructor();
  static final PaymentService instance = PaymentService._privateConstructor();

  static Map<String, dynamic>? _paymentIntent;

  static final String _stripeSecret = EnvVariables.instance.stripeSecretKey;

  static String _calculateAmount(String amount) {
    final a = (double.parse(amount) * 100).toInt();
    return a.toString();
  }

  static Future<bool> makePayment({
    required String amount,
    required String currency,
  }) async {
    try {
      _paymentIntent = await _createPaymentIntent(amount, currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: _paymentIntent!['client_secret'],
          style: ThemeMode.system,
          merchantDisplayName: 'Fintech',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      return true;
    } catch (e) {
      log("Error in makePayment: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>> _createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
      };

      var dio = Dio();
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_stripeSecret',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      return response.data;
    } catch (err) {
      throw Exception('Payment Intent Error: $err');
    }
  }
}
