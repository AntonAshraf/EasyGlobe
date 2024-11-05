import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchCountryData(String countryName) async {
  final url = Uri.parse('https://restcountries.com/v3.1/name/$countryName');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      if (data.isNotEmpty) {
        final country = data[0];

        // Extract the currency
        final currencyMap = country['currencies'] as Map<String, dynamic>;
        final currency = currencyMap.values.first['name'];

        // Extract the language
        final languagesMap = country['languages'] as Map<String, dynamic>;
        final language = languagesMap.values.join(', ');

        final dial = country['idd']['root'] as String;

        return {
          'name': country['name']['common'],
          'officialName': country['name']['official'],
          'currency': currency,
          'dial': dial,
          'capital': country['capital']?.isNotEmpty == true ? country['capital'][0] : 'N/A',
          'region': country['region'],
          'subregion': country['subregion'],
          'languages': language,
          'googleMaps': country['maps']['googleMaps'],
          'population': country['population'],
          'timezone': country['timezones']?.isNotEmpty == true ? country['timezones'][0] : 'N/A',
          'continent': country['continents']?.isNotEmpty == true ? country['continents'][0] : 'N/A',
          'flagPng': country['flags']['png'],
        };
      } else {
        throw Exception('No data found for the given country.');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

void main() {
  fetchCountryData('Poland').then((data) {
    if (kDebugMode) {
      print(data);
    }
  }).catchError((e) {
    if (kDebugMode) {
      print(e);
    }
  });
}
