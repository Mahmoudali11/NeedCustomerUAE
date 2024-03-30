import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavManager {
  final BuildContext context;

  NavManager(this.context);

  navPush(Widget screen) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return screen;
    });
    Navigator.of(context).push(route);
  }
  navPushRep(Widget screen) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return screen;
    });
    Navigator.of(context).pushReplacement(route);
  }
  navPushNameRep(String screen) {

    Navigator.of(context).pushReplacementNamed(screen);
  }
  popCurrent() {
    Navigator.of(context).pop();
  }


  navPushName(String name) {

    Navigator.of(context).pushNamed(name);
  }
  navPopNameUntil(String name) {

    Navigator.of(context).popUntil(ModalRoute.withName(name));
  }
  navPushAndRemoveUntil(Widget name) {

    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return name;
    });
    Navigator.of(context).pushAndRemoveUntil(route,(e)=>false);
  }
}
