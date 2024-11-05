import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ExchangeRateService {
  static Future<double?> getExchangeRate(String symbol) async {
    const apiKey = 'f9ffe2a809ae480ea3243da2cc990934';
    final url =
        'https://api.currencyfreaks.com/v2.0/rates/latest?apikey=$apiKey&symbols=$symbol';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return double.parse(data['rates'][symbol]);
      } else {
        throw Exception('Failed to load exchange rate');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
