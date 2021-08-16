import 'package:flutter/material.dart';
import 'package:list_pagination/animatedlist.dart';
import 'package:list_pagination/lists.dart';
import 'package:list_pagination/reorderable.dart';
import 'package:list_pagination/wheellist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListButtons(),
    );
  }
}

class ListButtons extends StatefulWidget {
  const ListButtons({Key? key}) : super(key: key);

  @override
  _ListButtonsState createState() => _ListButtonsState();
}

class _ListButtonsState extends State<ListButtons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListButtons"),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                title: "Normal List",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NormalList()));
                }),
            SizedBox(
              height: 20,
            ),
            Container(
                title: "Reordorable List",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReorderableLists()));
                }),
            SizedBox(
              height: 20,
            ),
            Container(
                title: "Animated List",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Animatedlists()));
                }),
            SizedBox(
              height: 20,
            ),
            Container(
                title: "WheelScroll List",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WheelScroll()));
                }),
          ],
        ),
      )),
    );
  }
}

class Container extends StatelessWidget {
  String? title;
  Function? onTap;
  Container({@required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 250,
        height: 80,
        child: ElevatedButton(
            onPressed: () {
              onTap!();
            },
            child: Text(
              title!,
              style: TextStyle(fontSize: 25),
            )));
  }
}
