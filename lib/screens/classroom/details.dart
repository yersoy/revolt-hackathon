import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models.dart';
import '../../services.dart';

class Details extends StatefulWidget {
  final Lesson lesson;

  Details(this.lesson, {Key key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  Future<AppUser> getuser(uid) {
    return Services().users().get(uid);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _insertZoom() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Zoom Linki Giriniz'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Zoom Linkini Giriniz'),
                  onChanged: (text) {
                    this.widget.lesson.link = text;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Gönder'),
              onPressed: () {
                final snackBar =
                    SnackBar(content: Text('Öğrenciler Bilgilendirildi !'));
                Services().lessons().save(this.widget.lesson).then((value) {
                  Navigator.pop(context);
                  _scaffoldkey.currentState.showSnackBar(snackBar);
                  setState(() {});
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(title: Text(this.widget.lesson.title)),
        body: ListView(
          children: [
            Card(
              margin: EdgeInsets.all(10),
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
              margin: EdgeInsets.all(10),
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
                margin: EdgeInsets.all(10),
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
            Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  _insertZoom();
                },
                leading: Icon(FontAwesomeIcons.signInAlt),
                title: Text(this.widget.lesson.link.isEmpty
                    ? "Dersi Başlat"
                    : "Ders Linkini Güncelle"),
                subtitle: Text(this.widget.lesson.link),
              ),
            ),
          ],
        ));
  }
}
