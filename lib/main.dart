import 'package:flutter/material.dart';
import 'package:flutter_app/src/test.dart'as scan;
import 'package:flutter_app/src/wall_screen.dart' as collection;




void main() {
  runApp(new MaterialApp(
    home: new tabbar(),
    ),
  );
}
class tabbar extends StatefulWidget {
  @override
  _tabbarState createState() => _tabbarState();
}
class _tabbarState extends State<tabbar>with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.pink[200],
        title: new Text('Dita Hijrah App'),
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.collections),),
            new Tab(icon: new Icon(Icons.camera_alt),)

          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new collection.wallscreen() ,
          new scan.hometest()
        ],
      )
    );
  }
}
