import 'package:flutter/material.dart';

void main() => runApp(RutApp());

class RutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rut Flet',
        theme: ThemeData(primarySwatch: Colors.brown),
        home: Scaffold(
            appBar: AppBar(title: Text('Gelateria da Rut Flet')),
            body: SingleChildScrollView(
              child: Builder(
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      Container(height: 50),
                      Text(
                        'Il Gelato migliore del mondo!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Container(height: 50),
                      Image.network(
                          'https://images.pexels.com/photos/47062/bananas-dessert-ice-cream-fruit-47062.jpeg'),
                      Container(height: 100),
                      ElevatedButton(
                          child: Text(
                            'Informazioni',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),

                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            SnackBar snackBar = SnackBar(
                                content: Text('La mail di Rut è rut@flet.dev'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }),
                    ],
                  );
                },
              ),
            )));
  }
}
