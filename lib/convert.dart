import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revolt/models.dart';

typedef Reviver<T> = T Function(dynamic value);

class Convert {
  static final Map<Type, Reviver> _types = <Type, Reviver> {
    bool: (value) { return _trust(value, (o) => [1, 'true'].contains(value)); },
    double: (value) { return _trust(value, (o) => double.parse(o.toString(), (e) => double.nan)); },
    int: (value) { return _trust(value, (o) => int.parse(o.toString()), 0); },

    DateTime: (value) { return _trust(value, (o) => (o is num ? DateTime.fromMillisecondsSinceEpoch(o) : (o is Timestamp ? o.toDate() : DateTime.parse(o.toString())))); },
    String: (value) { return _trust(value, (o) => o.toString()); },
    Location: (value) { return _trust(value, (o) => o.toString()); },
    GeoPoint: (value) { return _trust(value, (o) => o.toString()); },

  };

  static dynamic _trust<T>(dynamic value, Reviver<T> action, [T fallback]) { return ((value ??= fallback) is T ? value : (value == null ? null : action(value))); }

  static void define<T> (Reviver<T> generate) { _types.putIfAbsent(T, () => generate); }

  static dynamic to<T>(dynamic value) { return (value is T ? value : _types[T](value)); }
}