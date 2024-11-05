import 'package:easy_globe/screens/currency_exchange_screen.dart';
import 'package:easy_globe/widgets/custom_button.dart';
import 'package:easy_globe/screens/empty_screen.dart';
import 'package:easy_globe/screens/search_country_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to EasyGlobe!'),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: const Text(
                "A simple API-powered app that provides essential information about any country, including details on geography, population, and culture, along with a feature to check exchange rates for your preferred currencies.\n",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const CustomButton(
                icon: Icons.accessibility,
                text: 'Country Info',
                screen: SearchCountryScreen()),
            const SizedBox(height: 20),
             CustomButton(
                icon: Icons.money,
                text: 'Exchange Rates',
                screen: CurrencyExchangeScreen()),
            const SizedBox(height: 20),
            const CustomButton(
                icon: Icons.info, text: 'About', screen: EmptyScreen()),
          ],
        ),
      ),
    );
  }
}
