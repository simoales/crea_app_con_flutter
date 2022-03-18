import 'package:capitolo_5_sembast/dati/articolo.dart';
import 'package:capitolo_5_sembast/pagine/articolo.dart';
import 'package:flutter/material.dart';
import '../dati/articolo_db.dart';

class ListaArticoli extends StatefulWidget {
  @override
  _ListaArticoliState createState() => _ListaArticoliState();
}

class _ListaArticoliState extends State<ListaArticoli> {
  late ArticoloDb db;
  @override
  void initState() {
    db = ArticoloDb();
    db.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista della spesa'),
      ),
      body: FutureBuilder(
          future: leggiArticoli(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Articolo> lista = snapshot.data ?? [];
            return ListView.builder(
                itemCount: lista.length,
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: Key(lista[index].id.toString()),
                    onDismissed: (_) {
                      db.eliminaArticolo(lista[index]);
                    },
                    child: ListTile(
                      title: Text(lista[index].nome),
                      subtitle: Text('Quantità: ' +
                          lista[index].quantita +
                          ' - Note: ' +
                          lista[index].note),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaginaArticolo(lista[index], false)),
                        );
                      },
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PaginaArticolo(new Articolo('', '', '', 0), true)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future aggiungiArticoliTest() async {
    await db.inserisciArticolo(Articolo('Arance', '2Kg', 'Da Spremuta', 1));
    await db.inserisciArticolo(Articolo('Mele', '2Kg', 'Verdi', 1));
    await db.inserisciArticolo(Articolo('Pere', '2Kg', 'Mature', 1));
    await db.inserisciArticolo(Articolo('Pesche', '2Kg', 'Noci', 1));
  }

  Future leggiArticoli() async {
    await db.init();
    List<Articolo> articoli = await db.leggiArticoli();
    return articoli;
  }
}
