import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'libro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LibriScreen(),
    );
  }
}

class LibriScreen extends StatefulWidget {
  @override
  _LibriScreenState createState() => _LibriScreenState();
}

class _LibriScreenState extends State<LibriScreen> {
  String risultato = '';
  List<Libro> libri = [];
  @override
  void initState() {
    cercaLibri('Oceano Mare');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libri'),
      ),
      body: Container(child: Text(risultato)),
    );
  }

  Future cercaLibri(String ricerca) async {
    final String dominio = 'www.googleapis.com';
    final String percorso = '/books/v1/volumes';
    Map<String, dynamic> parametri = {'q': ricerca};
    final Uri url = Uri.https(dominio, percorso, parametri);
    http.get(url).then((res) {
      final resJson = json.decode(res.body);
      final libriMap = resJson['items'];
      libri = libriMap.map<Libro>((mappa) => Libro.fromMap(mappa)).toList();
      setState(() {
        risultato = res.body;
        libri = libri;
      });
    });

    setState(() {
      risultato = 'Richiesta in corso';
    });
  }
}
