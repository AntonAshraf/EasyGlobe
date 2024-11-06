import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About EasyGlobe',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue),),
        centerTitle: true,// backgroundColor: Colors.purple,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20),
            Text(
              'EasyGlobe is an API-powered app that provides essential information about countries worldwide. '
                  'With EasyGlobe, you can quickly access details on geography, population, culture, and current '
                  'exchange rates for your preferred currencies.\n\n'
                  'Key Features:\n'
                  '- Search for detailed country information.\n'
                  '- View current exchange rates for various currencies.\n'
                  '- Simple and easy-to-use interface.\n\n'
                  'EasyGlobe is developed to be your quick reference guide for essential country data!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              'Developer: Your Company or Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
