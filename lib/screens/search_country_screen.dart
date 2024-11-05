import 'package:easy_globe/models/country.dart';
import 'package:flutter/material.dart';
import 'country_detail_screen.dart';

class SearchCountryScreen extends StatefulWidget {
  const SearchCountryScreen({super.key});

  @override
  State<SearchCountryScreen> createState() => _SearchCountryScreenState();
}

class _SearchCountryScreenState extends State<SearchCountryScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchCountry() async {
    final countryName = _searchController.text.trim();
    if (countryName.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final countryData = await fetchCountryData(countryName);

      // If countryData is valid, navigate to the detail screen
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => CountryDetailScreen(countryName: countryName, countryData: countryData),
        ),
      );
    } catch (e) {
      // If an error occurs, display an error message
      setState(() {
        _errorMessage = 'Country not found. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Country'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Enter country name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (_) => _searchCountry(),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _searchCountry,
                child: const Text('Search'),
              ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 20),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
