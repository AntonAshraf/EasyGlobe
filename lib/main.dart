import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';
class CustomCard extends StatelessWidget {
  final String name;
  final String picturePath;
  final TextEditingController _animalScore = TextEditingController();

  CustomCard({required this.name, required this.picturePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name),
          TextFormField(
            controller: _animalScore,
            decoration: InputDecoration(
              labelText: 'Enter the rating here',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a rating";
              }
              if (value != 'good' && value!='bad' && value!='excellent') {
                return "please enter good, bad or excellent";
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_animalScore.text=='good' || _animalScore.text=='bad' || _animalScore.text=='excellent') {
                Navigator.pop(context, {"currentRating": _animalScore.text});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter a rating")),
                );
              }
            },
            child: Text("Return to first screen"),
          )
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen("None"),
    );
  }
}

class FirstScreen extends StatefulWidget {
  final String currentRating;

  FirstScreen(this.currentRating);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  String currentRating = "None";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to EasyGlobe!'),
          titleTextStyle:TextStyle(color:Colors.blue,fontSize: 30,fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
    body: Center(
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                child:
                Text("A simple API-powered app that provides essential information about any country, including details on geography, population, and culture, along with a feature to check exchange rates for your preferred currencies.\n"
                ,style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ElevatedButton(
                  onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState?.validate() == true) {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          name: _nameController.text,
                          imagePath: "assets/images/${_typeController.text}.jpg",
                        ),
                      ),
                    );

                    if (result != null && result.containsKey('currentRating')) {
                      setState(() {
                        currentRating = result['currentRating'];
                      });
                    }
                  }
                },
                child: Text("View Details About any Country",style: TextStyle(color: Colors.blue),),
              ),
              Text('\n\n\n'),
              ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState?.validate() == true) {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondScreen(
                            name: _nameController.text,
                            imagePath: "assets/images/${_typeController.text}.jpg",
                          ),
                        ),
                      );

                      if (result != null && result.containsKey('currentRating')) {
                        setState(() {
                          currentRating = result['currentRating'];
                        });
                      }
                    }
                  },
                  child: Text("Currency Exchange Rates",style: TextStyle(color: Colors.blue),)
              ),
              Text('\n\n\n'),
              ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState?.validate() == true) {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondScreen(
                            name: _nameController.text,
                            imagePath: "assets/images/${_typeController.text}.jpg",
                          ),
                        ),
                      );

                      if (result != null && result.containsKey('currentRating')) {
                        setState(() {
                          currentRating = result['currentRating'];
                        });
                      }
                    }
                  },
                  child: Text("A Random Joke",style: TextStyle(color: Colors.blue),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final String name;
  final String imagePath;

  const SecondScreen({required this.name, required this.imagePath});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late String name;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    // Initialize state with the values passed from the first screen
    name = widget.name;
    imagePath = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: CustomCard(
          name: name,
          picturePath: imagePath,
        ),
      ),
    );
  }
}