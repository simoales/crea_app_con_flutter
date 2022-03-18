import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'articolo.dart';

class ArticoloDb {
  //this needs to be a singleton
  static final ArticoloDb _singleton = ArticoloDb._internal();
  //private internal constructor
  ArticoloDb._internal();

  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? _db;

  factory ArticoloDb() {
    return _singleton;
  }
  final store = intMapStoreFactory.store('articoli');

  Future<Database> init() async {
    if (_db == null) {
      await _openDb().then((db) {
        _db = db;
      });
    }
    return _db!;
  }

  Future _openDb() async {
    final percorsoDocumenti = await getApplicationDocumentsDirectory();
    final percorsoDb = join(percorsoDocumenti.path, 'articoli.db');
    final db = await dbFactory.openDatabase(percorsoDb);
    return db;
  }

  //metodi CRUD
  Future<int> inserisciArticolo(Articolo articolo) async {
    if (_db == null) {
      await init();
    }
    return await store.add(_db!, articolo.trasformaInMap());
  }

  Future aggiornaArticolo(Articolo articolo) async {
    final finder = Finder(filter: Filter.byKey(articolo.id));
    await store.update(_db!, articolo.trasformaInMap(), finder: finder);
  }

  Future eliminaArticolo(Articolo articolo) async {
    final finder = Finder(filter: Filter.byKey(articolo.id));
    await store.delete(_db!, finder: finder);
  }

  Future eliminaDatiDb() async {
    await store.delete(_db!);
  }

  Future<List<Articolo>> leggiArticoli() async {
    if (_db == null) {
      await init();
    }
    final finder = Finder(sortOrders: [
      SortOrder('priorita'),
      SortOrder('id'),
    ]);

    final articoliSnapshot = await store.find(_db!, finder: finder);
    return articoliSnapshot.map((snapshot) {
      final articolo = Articolo.daMap(snapshot.value);
      articolo.id = snapshot.key;
      return articolo;
    }).toList();
  }
}
