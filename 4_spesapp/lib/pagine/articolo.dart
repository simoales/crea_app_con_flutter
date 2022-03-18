import 'package:capitolo_5_sembast/dati/articolo_db.dart';
import 'package:capitolo_5_sembast/pagine/lista_articoli.dart';
import 'package:flutter/material.dart';
import '../dati/articolo.dart';

class PaginaArticolo extends StatefulWidget {
  final Articolo articolo;
  final bool nuovo;
  PaginaArticolo(this.articolo, this.nuovo);

  @override
  _PaginaArticoloState createState() => _PaginaArticoloState();
}

class _PaginaArticoloState extends State<PaginaArticolo> {
  final TextEditingController txtNome = TextEditingController();
  final TextEditingController txtNote = TextEditingController();
  final TextEditingController txtQuantita = TextEditingController();
  final TextEditingController txtPriorita = TextEditingController();
  late ArticoloDb db;

  @override
  void initState() {
    db = ArticoloDb();

    if (!widget.nuovo) {
      txtNome.text = widget.articolo.nome ;
      txtNote.text = widget.articolo.note ;
      txtQuantita.text = widget.articolo.quantita ;
      txtPriorita.text = widget.articolo.priorita.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dettaglio Articolo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CasellaTesto(txtNome, 'Nome'),
            CasellaTesto(txtNote, 'Note'),
            CasellaTesto(txtQuantita, 'Quantità'),
            CasellaTesto(txtPriorita, 'Priorità'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            widget.articolo.nome = txtNome.text;
            widget.articolo.note = txtNote.text;
            widget.articolo.quantita = txtQuantita.text;
            widget.articolo.priorita = int.tryParse(txtPriorita.text) ?? 0;

            if (widget.nuovo) {
              db.inserisciArticolo(widget.articolo).then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaArticoli()),
                );
              });
            } else {
              db.aggiornaArticolo(widget.articolo).then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaArticoli()),
                );
              });
            }
          }),
    );
  }
}

class CasellaTesto extends StatelessWidget {
  final TextEditingController controller;
  final String titolo;
  CasellaTesto(this.controller, this.titolo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: titolo,
        ),
      ),
    );
  }
}
