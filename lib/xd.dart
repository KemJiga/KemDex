import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final baseUrl = 'http://10.0.2.2:5000';
  var _mangaName = '';
  var _mangaAuthor = '';
  var _mangaGenre = '';
  var _mangaDescription = '';

  var _loaded = false;

  void _save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    var url = Uri.parse('$baseUrl/get_manga_info/?manga_name=$_mangaName');

    var res = await http.get(url);

    if (res.statusCode == 200) {
      var jsonResponse = jsonDecode(res.body);
      _mangaName = jsonResponse['name'];
      _mangaAuthor = jsonResponse['author'];
      _mangaGenre = jsonResponse['genres'].join(', ');
      _mangaDescription = jsonResponse['description'];
      _loaded = true;
      setState(() {});
    } else {
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onSaved: (value) {
                      _mangaName = value!;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _save,
                    child: const Text('Search'),
                  ),
                  if (_loaded) ...[
                    Card(
                      child: Column(
                        children: [
                          Text('Manga Name: $_mangaName'),
                          Text('Manga Author: $_mangaAuthor'),
                          Text('Manga Genre: $_mangaGenre'),
                          Text('Manga Description: $_mangaDescription'),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
