import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClassDetail extends StatefulWidget {
  final classid;
  final classname;
  ClassDetail({Key key, this.classid, this.classname}) : super(key: key);

  @override
  _ClassDetailState createState() => _ClassDetailState();
}

class _ClassDetailState extends State<ClassDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Matematik Geometri #4536"),
        ),
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
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                        "https://i.pinimg.com/564x/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"),
                  ),
                  title: Text("Juliette Winstown"),
                  subtitle: Text("Dersin Hocası"),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  title: Text("Ders Hakkında Notlar"),
                  subtitle: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Derse Katılmak İsteyenler"),
                    trailing: Text("3"),
                  ),
                  Container(
                    width: double.infinity,
                    height: 180,
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.verified_user),
                          title: Text("Yusuf Ersoy"),
                        ),
                        ListTile(
                          leading: Icon(Icons.verified_user),
                          title: Text("Ahmet Ertekin"),
                        ),
                        ListTile(
                          leading: Icon(Icons.data_usage_sharp),
                          title: Text("Jordy Hershel"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
