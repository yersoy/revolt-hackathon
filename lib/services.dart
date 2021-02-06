import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Keys {
  static const String EDUCATIONS = 'educations';
  static const String USERS = 'users';
}

typedef Reviver<T> = T Function(dynamic data);

class Repository<T> {
  final CollectionReference _collection;
  final Reviver<T> _reviver;

  Repository._(CollectionReference collection, {Reviver<T> reviver}) : _collection = collection, _reviver = reviver;

  Future<T> get(dynamic id) { return _collection.doc(id).get().then((snapshot) => _reviver(snapshot.data())); }
}

class Services {
  FirebaseFirestore _store;
  final Map<dynamic, CollectionReference> _collections = Map();

  Services._();

  static Services _instance;
  factory Services() { return (_instance ??= Services._()); }

  Future<bool> initialize() {
    return Firebase.initializeApp().then((app) {
      if (app != null) { return ((_store = FirebaseFirestore.instance) != null); }

      return false;
    });
  }

  CollectionReference get(dynamic key) { return _collections.putIfAbsent(key, () => _store.collection(key)); }

  CollectionReference educations() { return this.get(Keys.EDUCATIONS); }
  CollectionReference users() { return this.get(Keys.USERS); }
}