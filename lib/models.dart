import 'convert.dart';

abstract class Model {
  dynamic toJson();
}

class Disclaimer {
  final String title;
  final String description;
  final String image;

  Disclaimer({this.title, this.description, this.image});
}

class Credentials {
  String username;
  String password;

  Credentials({this.username, this.password});
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

  factory Competence.fromJson(dynamic json) => Competence(educationId: json['educationId'], level: json['level']);

  dynamic toJson() => {
    'educationId': this.educationId,
    'level': this.level,
  };
}

class Expectance {
  dynamic educationId;
  int level;

  Expectance({this.educationId, this.level});

  factory Expectance.fromJson(dynamic json) => Expectance(educationId: json['educationId'], level: json['level']);

  dynamic toJson() => {
    'educationId': this.educationId,
    'level': this.level,
  };
}

class AppUser extends Model {
  dynamic id;
  String userName;
  String password;
  String firstName;
  String lastName;
  String email;
  DateTime birthDate;
  bool teacher;
  bool student;
  int graduation;
  String token;

  List<Competence> competences = List();
  List<Expectance> expectances = List();

  String get displayName => [this.firstName, this.lastName].join(' ').trim();

  AppUser({this.id, this.userName, this.password, this.firstName, this.lastName, this.email, this.birthDate, this.teacher = false, this.student = false, this.graduation, this.token, Iterable<Competence> competences, Iterable<Expectance> expectances});

  factory AppUser.fromJson(dynamic json) => AppUser(
    id: json['id'],
    userName: json['userName'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    birthDate: Convert.to<DateTime>(json['birthDate']),
    teacher: json['teacher'],
    student: json['student'],
    graduation: json['graduation'],
    competences: json['competences'].map((e) => Competence.fromJson(e)).toList(),
    expectances: json['expectances'].map((e) => Expectance.fromJson(e)).toList(),
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
    'competences': this.competences.map((e) => e.toJson()).toList(),
    'expectances': this.expectances.map((e) => e.toJson()).toList(),
  };
}

class Participant {
  dynamic userId;

  dynamic toJson() => {
    'userId': this.userId,
  };
}

class Lesson extends Model {
  dynamic id;
  dynamic userId;
  DateTime start;
  
  final List<Participant> participants = List();
  
  @override
  dynamic toJson() => {
    'id': this.id,
    'userId': this.userId,
    'start': this.start,

    'participants': this.participants.map((e) => e.toJson()).toList()
  };
}