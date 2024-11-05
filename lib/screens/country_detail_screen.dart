import 'package:easy_globe/models/country.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {
  final String countryName;
  final Map<String, dynamic>? countryData;

  const CountryDetailScreen({super.key, required this.countryName, this.countryData});

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _countryData;

  @override
  void initState() {
    super.initState();
    _loadCountryData();
  }

  Future<void> _loadCountryData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final data = await fetchCountryData(widget.countryName);

      setState(() {
        _countryData = widget.countryData ?? data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_countryData?['name'] ?? 'Country Detail'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCountryData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _countryData?['flagPng'] ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoCard(
            title: 'General Information',
            children: [
              _buildInfoRow('Official Name', _countryData?['officialName']),
              _buildInfoRow('Capital', _countryData?['capital']),
              _buildInfoRow('Population', _countryData?['population']?.toString()),
              _buildInfoRow('Region', _countryData?['region']),
              _buildInfoRow('Subregion', _countryData?['subregion']),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Additional Details',
            children: [
              _buildInfoRow('Continent', _countryData?['continent']),
              _buildInfoRow('Languages', _countryData?['languages']),
              _buildInfoRow('Dial Code', _countryData?['dial']),
              _buildInfoRow('Timezone', _countryData?['timezone']),
              _buildInfoRow('Currency', _countryData?['currency']),
            ],
          ),
          const SizedBox(height: 16),
          if (_countryData?['googleMaps'] != null)
            ElevatedButton.icon(
              onPressed: () {
                // Open the Google Maps URL                
             
              },
              icon: const Icon(Icons.map),
              label: const Text('View on Google Maps'),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }
}
