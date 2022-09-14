import 'package:flutter/material.dart';

void main() => runApp(RutApp());

class RutApp extends StatelessWidget {
  const RutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.brown),
        title: 'Rut Flet',
        home: Scaffold(
            appBar: AppBar(title: const Text('Gelateria da Rut Flet')),
            body: Builder(builder: (context) {
              return SingleChildScrollView(
                child: Column(children: [
                  Container(
                    height: 50,
                  ),
                  const Text('Il gelato migliore del mondo',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Container(
                    height: 50,
                  ),
                  Image.network('https://bit.ly/flutgelato'),
                  Container(
                    height: 100,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        SnackBar snackBar = const SnackBar(
                            content: Text('La mail di Rut è rut@flet.dev'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text('Informazioni',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )))
                ]),
              );
            })));
  }
}
