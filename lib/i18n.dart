import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:intl/intl.dart';

class Locales {
  static const String TR = 'tr';
  static const String EN = 'en';
}

class GlobalCustomLocalizations {
  static const LocalizationsDelegate<GlobalCustomLocalizations> delegate = GlobalCustomLocalizationsDelegate();

  final Locale locale;

  GlobalCustomLocalizations(this.locale);

  static GlobalCustomLocalizations of(BuildContext context) { return Localizations.of<GlobalCustomLocalizations>(context, GlobalCustomLocalizations); }

  static final Map<String, Map<String, String>> _strings = {
    Locales.TR: {
      'app.title': 'Revolt',

      'app.add': 'Ekle',
      'app.added': 'Eklendi',
      'app.cancel': 'İptal',
      'app.done': 'Tamamlandı',
      'app.error': 'Bir hata oluştu',
      'app.exit': 'Uygulamadan çıkmak istiyor musunuz?',
      'app.loading': 'Yükleniyor...',
      'app.no': 'Hayır',
      'app.ok': 'Tamam',
      'app.save': 'Kaydet',
      'app.saved': 'Kaydedildi',
      'app.selected.more': '%d öğe seçildi',
      'app.selected.one': '%d öğe seçildi',
      'app.signout': 'Oturumu sonlandırmak istiyor musunuz?',
      'app.yes': 'Evet',

      'app.units.grams': 'g',
      'app.units.kilograms': 'Kg',
      'app.units.meters': 'm',
      'app.units.kilometers': 'Km',
      'app.units.calories': 'cal',
      'app.units.kilocalories': 'Kcal',

      'app.themes.red': 'Kırmızı',
      'app.themes.pink': 'Pembe',
      'app.themes.purple': 'Mor',
      'app.themes.deepPurple': 'Koyu Mor',
      'app.themes.indigo': 'Çivit',
      'app.themes.blue': 'Mavi',
      'app.themes.lightBlue': 'Açık Mavi',
      'app.themes.cyan': 'Cam Göbeği',
      'app.themes.teal': 'Çamurcun',
      'app.themes.green': 'Yeşil',
      'app.themes.lightGreen': 'Açık Yeşil',
      'app.themes.lime': 'Limon',
      'app.themes.yellow': 'Sarı',
      'app.themes.amber': 'Kehribar',
      'app.themes.orange': 'Turuncu',
      'app.themes.deepOrange': 'Koyu Turuncu',
      'app.themes.brown': 'Kahverengi',
      'app.themes.grey': 'Gri',
      'app.themes.blueGrey': 'Duman Mavi',
      'app.themes.black': 'Siyah',

      'signin.username': 'Kullanıcı Adı',
      'signin.password': 'Şifre',
      'signin.enter': 'Giriş',
      'signin.invalid': 'Geçersiz kullanıcı adı veya şifre',

      'home.title': 'Revolt',
    },
  };

  static void set(String locale, String key, String value) {
    var map = _strings[locale];
    if (map != null) { map.update(key, (current) => value, ifAbsent: () => value); }
  }

  String get(String key) { return (_strings[locale.languageCode][key] ?? key); }
  String format(String key, dynamic args) { return sprintf(_strings[locale.languageCode][key], args); }

  String date(DateTime date) { return DateFormat.yMd(locale.languageCode).format(date); }
  String datetime(DateTime date) { return DateFormat.yMd(locale.languageCode).add_Hm().format(date); }

  String get APP_TITLE { return this.get('app.title'); }

  String get APP_ADD { return this.get('app.add'); }
  String get APP_ADDED { return this.get('added'); }
  String get APP_CANCEL { return this.get('app.cancel'); }
  String get APP_DONE { return this.get('app.done'); }
  String get APP_ERROR { return this.get('app.error'); }
  String get APP_EXIT { return this.get('app.exit'); }
  String get APP_LOADING { return this.get('app.loading'); }
  String get APP_NO { return this.get('app.no'); }
  String get APP_OK { return this.get('app.ok'); }
  String get APP_SAVE { return this.get('app.save'); }
  String get APP_SAVED { return this.get('app.saved'); }
  String get APP_SIGNOUT { return this.get('app.signout'); }
  String APP_SELECTED (int count) { return this.format(count > 1 ? 'app.selected.more' : 'app.selected.one', [count]); }
  String get APP_YES { return this.get('app.yes'); }

  String get APP_UNITS_GRAMS { return this.get('app.units.grams'); }
  String get APP_UNITS_KILOGRAMS { return this.get('app.units.kilograms'); }
  String get APP_UNITS_METERS { return this.get('app.units.meters'); }
  String get APP_UNITS_KILOMETERS { return this.get('app.units.kilometers'); }
  String get APP_UNITS_CALORIES { return this.get('app.units.calories'); }
  String get APP_UNITS_KILOCALORIES { return this.get('app.units.kilocalories'); }

  String get SIGNIN_USERNAME { return this.get('signin.username'); }
  String get SIGNIN_PASSWORD { return this.get('signin.password'); }
  String get SIGNIN_ENTER { return this.get('signin.enter'); }
  String get SIGNIN_INVALID { return this.get('signin.invalid'); }

  String get HOME_TITLE { return this.get('home.title'); }
}

class GlobalCustomLocalizationsDelegate extends LocalizationsDelegate<GlobalCustomLocalizations> {
  const GlobalCustomLocalizationsDelegate();

  static const Iterable<String> _locales = [Locales.TR];

  @override
  bool isSupported(Locale locale) { /*_locales.contains(locale.languageCode);*/ return true; }

  @override
  Future<GlobalCustomLocalizations> load(Locale locale) {
    if (!_locales.contains(locale.languageCode)) { locale = Locale(_locales.first); }

    return Future.sync(() => GlobalCustomLocalizations(locale));
  }

  @override
  bool shouldReload(GlobalCustomLocalizationsDelegate old) { return false; }
}