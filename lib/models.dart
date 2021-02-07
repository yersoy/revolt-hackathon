import 'package:latlong/latlong.dart';

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

class AppUser extends Model {
  dynamic id;
  String userName;
  String password;
  String firstName;
  String lastName;
  String email;
  DateTime birthDate;
  int graduation;
  bool teacher;
  String token;

  String get displayName => [this.firstName, this.lastName].join(' ').trim();

  AppUser({this.id, this.userName, this.password, this.firstName, this.lastName, this.email, this.birthDate, this.teacher = false, this.graduation = 0, this.token});

  factory AppUser.fromJson(dynamic json) => AppUser(
    id: json['id'],
    userName: json['userName'],
    password: json['password'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    birthDate: Convert.to<DateTime>(json['birthDate']),
    teacher: json['teacher'],
    graduation: json['graduation'],
    token: json['token'],
  );

  @override
  dynamic toJson() => {
    'id': this.id,
    'userName': this.userName,
    'password': this.password,
    'firstName': this.firstName,
    'lastName': this.lastName,
    'email': this.email,
    'birthDate': this.birthDate,
    'teacher': this.teacher,
    'graduation': this.graduation,
    'token': this.token,
  };
}

class Participant {
  dynamic userId;
  
  Participant({this.userId});

  factory Participant.fromJson(dynamic json) => Participant(
    userId: json['userId'],
  );

  dynamic toJson() => {
    'userId': this.userId,
  };
}

class Lesson extends Model {
  dynamic id;
  dynamic userId;
  dynamic educationId;
  String title;
  String description;
  DateTime startDate;
  int duration;
  String link;
  LatLng location;
  
  final List<Participant> participants = List();

  Lesson({this.id, this.userId, this.educationId, this.title, this.description, this.startDate, this.duration,this.link,this.location, Iterable<Participant> participants = const []}) {
    this.participants.addAll(participants);
  }

  factory Lesson.fromJson(dynamic json) => Lesson(
    id: json['id'],
    userId: json['userId'],
    educationId: json['educationId'],
    title: json['title'],
    description: json['description'],
    startDate: Convert.to<DateTime>(json['startDate']),
    duration: Convert.to<int>(json['duration']),
    link: json["link"],
    location: json["location"],
    participants: json['participants']?.map<Participant>((json) => Participant.fromJson(json))?.toList(),
  );
  
  @override
  dynamic toJson() => {
    'id': this.id,
    'userId': this.userId,
    'educationId': this.educationId,
    'title': this.title,
    'description': this.description,
    'startDate': this.startDate,
    'duration': this.duration,
    'link':this.link,
    'location':this.location,
    'participants': this.participants.map((e) => e.toJson()).toList()
  };
}