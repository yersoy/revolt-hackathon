import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'constants.dart';
import 'models.dart';

typedef Reviver<T> = T Function(dynamic data);

class Repository<T extends Model> {
  final CollectionReference _collection;
  final Reviver<T> _revive;

  Repository._(CollectionReference collection, {Reviver<T> revive}) : _collection = collection, _revive = revive;

  Future<Iterable<T>> all() { return _collection.get().then((query) => query.docs.map((doc) { print(doc.data()); return _revive(doc.data());}).toList()); }

  Future<T> get(dynamic id) { return _collection.doc(id).get().then((snapshot) => _revive(snapshot.data())); }
  Future<T> save(T model) { final data = model.toJson(), document = _collection.doc(data['id']); return document.set(data..update('id', (id) => document.id)).then((e) => _revive(data)); }
  Future<void> delete (dynamic id) { return _collection.doc(id).delete(); }
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

  Repository<Education> educations() { return Repository._(this.get(Keys.EDUCATIONS), revive: (data) => Education.fromJson(data)); }
  Repository<AppUser> users() { return Repository._(this.get(Keys.USERS), revive: (data) => AppUser.fromJson(data)); }
  Repository<Lesson> lessons() { return Repository._(this.get(Keys.LESSONS), revive: (data) => Lesson.fromJson(data)); }
}