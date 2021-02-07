import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revolt/i18n.dart';

import '../constants.dart';
import '../models.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState  extends State<Welcome> {
  final List<Disclaimer> _disclaimers = [
    Disclaimer(title: 'welcome.one.title', description: 'welcome.one.description', image: 'assets/svg/teaching_opening.svg'),
    Disclaimer(title: 'welcome.two.title', description: 'welcome.two.description', image: 'assets/svg/world_opening.svg'),
    Disclaimer(title: 'welcome.three.title', description: 'welcome.three.description', image: 'assets/svg/school_opening.svg'),
  ];
  int _current = 0;

  Widget _page(Disclaimer disclaimer) {
    final theme = Theme.of(context), text = theme.textTheme;
    final resources = GlobalCustomLocalizations.of(context);

    return Stack(alignment: Alignment.topCenter,
      children: [
        Center(
          child: SvgPicture.asset(disclaimer.image),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 36.0, horizontal: 24.0),
          child: Column(
            children: [
              Text(resources.get(disclaimer.title), style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: text.bodyText1.color)),
              Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(resources.get(disclaimer.description), textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: text.bodyText2.color)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dot(i) {
    final theme = Theme.of(context);

    return Padding(padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 3.0),
      child: AnimatedContainer(width: (_current == i ? 20 : 6), height: 6, duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: (_current == i ? theme.primaryColor : theme.accentColor),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              itemCount: _disclaimers.length,
              itemBuilder: (context, i) => _page(_disclaimers[i]),
              onPageChanged: (i) => setState(() { _current = i; }),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(),
                Row(
                  children: List.generate(_disclaimers.length, _dot),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: (_current == (_disclaimers.length - 1) ? FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () { Navigator.pushReplacementNamed(context, Routes.ENTRANCE); },
      ) : null),
    );
  }
}