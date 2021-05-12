import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'libroScreen.dart';
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
  Icon icona = Icon(Icons.search);
  Widget widgetRicerca = Text('Libri');
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
      appBar: AppBar(title: widgetRicerca, actions: [
        IconButton(
            icon: icona,
            onPressed: () {
              setState(() {
                if (this.icona.icon == Icons.search) {
                  this.icona = Icon(Icons.cancel);
                  this.widgetRicerca = TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (testoRicerca) => cercaLibri(testoRicerca),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
                } else {
                  setState(() {
                    this.icona = Icon(Icons.search);
                    this.widgetRicerca = Text('Libri');
                  });
                }
              });
            })
      ]),
      body: ListView.builder(
          itemCount: libri.length,
          itemBuilder: ((BuildContext context, int posizione) {
            return Card(
              elevation: 2,
              child: ListTile(
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => LibroScreen(libri[posizione]));
                    Navigator.push(context, route);
                  },
                  leading: Image.network(libri[posizione].immagineCopertina),
                  title: Text(libri[posizione].titolo),
                  subtitle: Text(libri[posizione].autori)),
            );
          })),
    );
  }

  Future cercaLibri(String ricerca) async {
    final String dominio = 'www.googleapis.com';
    final String percorso = '/books/v1/volumes';
    Map<String, dynamic> parametri = {'q': ricerca};
    final Uri url = Uri.https(dominio, percorso, parametri);
    try {
      http.get(url).then((res) {
        final resJson = json.decode(res.body);
        final libriMap = resJson['items'];
        libri = libriMap.map<Libro>((mappa) => Libro.fromMap(mappa)).toList();
        setState(() {
          risultato = res.body;
          libri = libri;
        });
      });
    } catch (errore) {
      setState(() {
        risultato = '';
      });
    }
    setState(() {
      risultato = 'Richiesta in corso';
    });
  }
}
