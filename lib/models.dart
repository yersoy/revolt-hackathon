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

class Education {
  dynamic id;
  String name;

  Education({this.id, this.name});

  factory Education.fromJson(dynamic json) => Education(
    id: json['id'],
    name: json['name'],
  );

  dynamic toJson() => {
    'id': this.id,
    'name': this.name,
  };
}

class Competence {
  dynamic id;
  dynamic userId;
  dynamic educationId;
  int level;

  Competence({this.id, this.userId, this.educationId, this.level});

  factory Competence.fromJson(dynamic json) => Competence(
      id: json['id'],
      userId: json['userId'],
      educationId: json['educationId'],
      level: json['level']
  );

  dynamic toJson() => {
    'id': this.id,
    'userId': this.userId,
    'educationId': this.educationId,
    'level': this.level,
  };
}

class Expectance {
  dynamic id;
  dynamic userId;
  dynamic educationId;
  int level;

  Expectance({this.id, this.userId, this.educationId, this.level});

  factory Expectance.fromJson(dynamic json) => Expectance(
      id: json['id'],
      userId: json['userId'],
      educationId: json['educationId'],
      level: json['level']
  );

  dynamic toJson() => {
    'id': this.id,
    'userId': this.userId,
    'educationId': this.educationId,
    'level': this.level,
  };
}

class User {
  dynamic id;
  String userName;
  String firstName;
  String lastName;
  DateTime birthDate;
  bool teacher;
  bool student;
  int graduation;

  Location location;

  List<Competence> competences = List();
  List<Expectance> expectances = List();

  User({this.id, this.userName, this.firstName, this.lastName, this.birthDate, this.teacher, this.student, this.graduation, this.location, Iterable<Competence> competences, Iterable<Expectance> expectances});

  factory User.fromJson(dynamic json) => User(
    id: json['id'],
    userName: json['userName'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    birthDate: DateTime.parse(json['birthDate']),
    teacher: json['teacher'],
    student: json['student'],
    graduation: json['graduation'],

    location: Location.fromJson(json['location']),

    competences: json['competences'].map((e) => Competence.fromJson(e)).toList(),
    expectances: json['expectances'].map((e) => Expectance.fromJson(e)).toList(),
  );

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