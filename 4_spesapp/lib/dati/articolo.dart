class Articolo {
  int id;
  String nome;
  String quantita; //non si può mettere la à accentata
  String data; //la data di inserimento /modifica
  String note;
  int priorita;
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
    //return Articolo(map['nome'], map['quantita'], map['note'], map['priorita']);
    id = map['id'];
    nome = map['nome'];
    quantita = map['quantita'];
    note = map['note'];
  }
}
