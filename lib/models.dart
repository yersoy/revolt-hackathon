import 'dart:convert';

abstract class Model {
  dynamic get identity;
  dynamic toJson();
}

class Location {
  double latitude;
  double longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(dynamic json) => Location(
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  dynamic toJson() => {
        'latitude': this.latitude,
        'longitude': this.longitude,
      };
}

class Education extends Model {
  dynamic id;
  String name;

  @override
  get identity => this.id;

  Education({this.id, this.name});

  factory Education.fromJson(dynamic json) => Education(
        id: json['id'],
        name: json['name'],
      );

  @override
  dynamic toJson() => {
        'id': this.id,
        'name': this.name,
      };
}

class Competence {
  dynamic educationId;
  int level;

  Competence({this.educationId, this.level});

  factory Competence.fromJson(dynamic json) =>
      Competence(educationId: json['educationId'], level: json['level']);

  dynamic toJson() => {
        'educationId': this.educationId,
        'level': this.level,
      };
}

class Expectance {
  dynamic educationId;
  int level;

  Expectance({this.educationId, this.level});

  factory Expectance.fromJson(dynamic json) =>
      Expectance(educationId: json['educationId'], level: json['level']);

  dynamic toJson() => {
        'educationId': this.educationId,
        'level': this.level,
      };
}

class IUser extends Model {
  dynamic id;
  String userName;
  String firstName;
  String lastName;
  DateTime birthDate;
  bool teacher;
  bool student;
  int graduation;

  String email;
  String displayname;
  String password;
  String token;
  Location location;

  List<Competence> competences = List();
  List<Expectance> expectances = List();

  @override
  get identity => this.id;

  IUser(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.birthDate,
      this.teacher,
      this.student,
      this.graduation,
      this.location,
      Iterable<Competence> competences,
      Iterable<Expectance> expectances});

  factory IUser.fromJson(dynamic json) => IUser(
        id: json['id'],
        userName: json['userName'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        birthDate: DateTime.parse(json['birthDate']),
        teacher: json['teacher'],
        student: json['student'],
        graduation: json['graduation'],
        location: Location.fromJson(json['location']),
        competences:
            json['competences'].map((e) => Competence.fromJson(e)).toList(),
        expectances:
            json['expectances'].map((e) => Expectance.fromJson(e)).toList(),
      );

  @override
  dynamic toJson() => {
        'id': this.id,
        'userName': this.userName,
        'firstName': this.firstName,
        'lastName': this.lastName,
        'birthDate': this.birthDate,
        'teacher': this.teacher,
        'student': this.student,
        'graduation': this.graduation,
        'location': this.location.toJson(),
        'competences': this.competences.map((e) => e.toJson()).toList(),
        'expectances': this.expectances.map((e) => e.toJson()).toList(),
      };
}



/// __________________________________________________TEMPORARY CLASS CREATED BY JORDY ________________________________
/// This class model is used as a example of different subjects That can be learned and are teached by teachers
/// This class will be deleted as soon as the real values will be entered taken fecthed from the firebase
///
class SubjectsModel {
  String name;
  String type;
  String usage;
  String image;

  SubjectsModel ({
    this.name,
    this.type,
    this.usage,
    this.image,
  });

  SubjectsModelcopyWith({
    String name,
    String type,
    String usage,

    String image,
  }) =>
      SubjectsModel(
        name: name ?? this.name,
        type: type ?? this.type,
        usage: usage ?? this.usage,
        image: image ?? this.image,
      );

  factory SubjectsModel.fromRawJson(String str) => SubjectsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubjectsModel.fromJson(Map<String, dynamic> json) => SubjectsModel(
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    usage: json["usage"] == null ? null : json["usage"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "usage": usage == null ? null : usage,
    "image": image == null ? null : image,
  };
}

final subjectMapList = [
  {
    "name": "Matematik",
    "type": "Ortaokul Öğrenci ",
    "usage": "3 öğretmen",
    "image":"assets/images/konu.jpg",
  }, {
    "name": "Fen Bilimleri",
    "type": "Ortaokul",
    "usage": "8 öğretmen",
    "image":"assets/images/konu.jpg",
  }, {
    "name": "Dil",
    "type": "Anaokul",
    "usage": "21 öğretmen",
    "image":"assets/images/konu.jpg",
  }, {
    "name": "Okuma - Yazma",
    "type": "Anaokul",
    "usage": "12 öğretmen",
    "image":"assets/images/konu.jpg",
  }, {
    "name": "İngilizce",
    "type": "Orta okul",
    "usage": "5 öğretmen",
    "image":"assets/images/konu.jpg",
  }, {
    "name": "Dil bilgisi",
    "type": "Orta Okul",
    "usage": "",
    "image":"assets/images/konu.jpg",
  }, {
    "name": "Fizik",
    "type": "Lise",
    "usage": "9 öğretmen",
    "image":"assets/images/konu.jpg",
  },
  {
    "name": "Sanat ve Müzik",
    "type": " Orta Okul",
    "usage": "3 öğretmen",
    "image":"assets/images/konu.jpg",
  },

  {
    "name": "Bilgisayar a Giris",
    "type": " Açık Eğitim",
    "usage": " 7 öğretmen",
    "image":"assets/images/konu.jpg",
  },
];


///-------------------------------------------------------------------------------------------------------------