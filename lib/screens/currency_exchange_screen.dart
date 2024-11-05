import 'package:easy_globe/services/exchange_rate_service.dart';
import 'package:flutter/material.dart';

class CurrencyExchangeScreen extends StatefulWidget {
  const CurrencyExchangeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyExchangeScreenState createState() => _CurrencyExchangeScreenState();
}

class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen> {
  String selectedCurrency = 'EGP';
  double? exchangeRate;

  final List<Map<String, String>> currencies = [
    {'code': 'EGP', 'name': 'Egyptian Pound'},
    {'code': 'EUR', 'name': 'Euro'},
    {'code': 'GBP', 'name': 'British Pound'},
    {'code': 'JPY', 'name': 'Japanese Yen'},
    {'code': 'CAD', 'name': 'Canadian Dollar'},
    {'code': 'AED', 'name': 'UAE Dirham'},
    {'code': 'USD', 'name': 'United States Dollar'},
    {'code': 'INR', 'name': 'Indian Rupee'},
    {'code': 'CNY', 'name': 'Chinese Yuan'},
    {'code': 'AUD', 'name': 'Australian Dollar'},
    {'code': 'SAR', 'name': 'Saudi Riyal'},
    {'code': 'KWD', 'name': 'Kuwaiti Dinar'},
    {'code': 'OMR', 'name': 'Omani Rial'},
    {'code': 'QAR', 'name': 'Qatari Rial'},
    {'code': 'BHD', 'name': 'Bahraini Dinar'},
    {'code': 'LYD', 'name': 'Libyan Dinar'},
    {'code': 'DZD', 'name': 'Algerian Dinar'},
    {'code': 'MAD', 'name': 'Moroccan Dirham'},
    {'code': 'JOD', 'name': 'Jordanian Dinar'},
    {'code': 'LBP', 'name': 'Lebanese Pound'},
    {'code': 'YER', 'name': 'Yemeni Rial'},
  ];

  void fetchExchangeRate() async {
    final rate = await ExchangeRateService.getExchangeRate(selectedCurrency);
    setState(() {
      exchangeRate = rate;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Exchange"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    children: [
                      const Text(
                        'Select Currency',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        menuMaxHeight: 600,
                        value: selectedCurrency,
                        items: currencies.map((currency) {
                          return DropdownMenuItem<String>(
                            value: currency['code'],
                            child: Row(
                              children: [
                                const Icon(Icons.monetization_on, color: Colors.blue),
                                const SizedBox(width: 8),
                                Text('${currency['name']}'),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCurrency = value!;
                            fetchExchangeRate();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    children: [
                      const Text(
                        'Exchange Rate',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        exchangeRate != null
                            ? '1 USD = ${exchangeRate!.toStringAsFixed(2)} $selectedCurrency'
                            : 'Fetching rate...',
                        style: const TextStyle(fontSize: 24, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: fetchExchangeRate,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text("Refresh Rate"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
