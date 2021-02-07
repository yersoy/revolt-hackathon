import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models.dart';
import '../../services.dart';

class Details extends StatefulWidget {
  final Lesson lesson;

  Details(this.lesson, {Key key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Future<AppUser> getuser(uid) {
    return Services().users().get(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(this.widget.lesson.title)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(FontAwesomeIcons.signInAlt),
        ),
        body: ListView(
          children: [
            Card(
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FutureBuilder<AppUser>(
                    future: getuser(this.widget.lesson.userId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                              'https://i.pinimg.com/564x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg'),
                        ),
                        title: Text(snapshot.data.displayName),
                        subtitle: Text('Dersin Hocası'),
                      );
                    },
                  )),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Ders Hakkında Notlar'),
                  subtitle: Text(this.widget.lesson.description),
                ),
              ),
            ),
            if (this.widget.lesson.participants.isNotEmpty)
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Derse Katılmak İsteyenler'),
                      trailing: Text('3'),
                    ),
                    Container(
                      width: double.infinity,
                      height: 180,
                      child: ListView.builder(
                        itemCount: this.widget.lesson.participants.length,
                        itemBuilder: (context, index) {
                          Participant _partici =
                              this.widget.lesson.participants[index];
                          return ListTile(
                            title: FutureBuilder<AppUser>(
                              future: getuser(_partici.userId),
                              builder: (context, snapshot) {
                                return Text(snapshot.data.displayName);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }
}
