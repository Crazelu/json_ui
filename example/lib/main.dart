import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_ui/json_ui.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JsonUI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'JsonUI Demo Home Page'),
      navigatorKey: navigationKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _json;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  void loadJson() async {
    // String data =
    //     await DefaultAssetBundle.of(context).loadString("assets/netflix.json");
    // _json = json.decode(data);
    JsonUI.init(
        url: "https://json-ui-server-crazelu.vercel.app/netflix",
        // jsonData:_json,
        // context:context,
        navigationKey: navigationKey);
    //you can use context instead of a navigationKey
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 30),
            TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.resolveWith(
                      (states) => Size(0, 50)),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.blueAccent),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.white),
                  overlayColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.lightBlueAccent),
                ),
                onPressed: () => loadJson(),
                child: Text('Show full screen JSON to UI dialog'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
