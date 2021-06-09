import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

String baseUrl = "https://api.aglty.io/860094d3-u/fetch/en-us/list/people";

Map<String, String> headers = {
  'APIKey':
      'defaultlive.2cc773eb03979a879194593aeb5c7d90c67bc21e84204914e63044d753fa8bef'
};

Future<String> _getPosts() async {
  final response = await http.get(Uri.parse(baseUrl), headers: headers);
  Map responseMap = json.decode(response.body);
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(responseMap);
  return prettyprint;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agility Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Agility Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<String> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder<String>(
            future: _postsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text("Error"),
                );
              if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
