class Articolo {
  int? id;
  late String nome;
  late String quantita; //non si può mettere la à accentata
  String? data; //la data di inserimento /modifica
  late String note;
  late int priorita;

  Articolo(this.nome, this.quantita, this.note, this.priorita);

  Map<String, dynamic> trasformaInMap() {
    return {
      'id': id ?? null,
      'nome': nome,
      'quantita': quantita,
      'note': note,
    };
  }

  Articolo.daMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    quantita = map['quantita'];
    note = map['note'];
  }
}
