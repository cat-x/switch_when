import 'package:flutter/material.dart';
import 'package:switch_when/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tween_image_widget Demo',
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
      home: MyHomePage(title: 'Tween Image Widget Home Page'),
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

extension Stringx on String {
  String more() {
    return "$this more";
  }
}

class _MyHomePageState extends State<MyHomePage> {
  testWhenString() {
    int howManyFruits = 2;
    int? index = whenString<int>("banana🍌", {
      "water" + "melon".more(): () {
        return 1;
      },
      "apple".more(): () {
        return 2;
      },
      howManyFruits <= 1 ? "orange" : "oranges": () {
        return 3;
      },
      "banana" + "🍌": () {
        return 4;
      },
      "grape": () {
        return 5;
      },
    });
    return index;
  }

  testWhenInt() {
    String? status = whenInt<String>(1, {
      1: () {
        return "good";
      },
      1 + 1: () {
        return "nice";
      },
      int.parse("3"): () {
        return "better";
      },
    });
    return status;
  }

  testWhenDouble() {
    String? status = whenDouble<String>(2.0, {
      0.1: () {
        return "good";
      },
      1.0 + 1: () {
        return "nice";
      },
      double.parse("3.2"): () {
        return "better";
      },
    });
    return status;
  }

  testWhenValue() {
    String? kind = whenValue<List, String>(
      ["apple", "orange"],
      {
        ["cat", "dog"]: () {
          return "pets";
        },
        ["apple", "orange"]: () {
          return "fruits";
        },
        ["red", "white", "black"]: () {
          return "colors";
        },
      },
    );
    return kind;
  }

  testWhen() {
    String? winner = when<String>({
      "Dart is Language".contains("UI"): () {
        return "Flutter";
      },
      "Flutter is UI Framework".contains("UI"): () {
        return "Flutter";
      },
    });
    return winner;
  }

  testWhenTrue() {
    String? something = whenTrue<String>({
      () {
        if (1 + 100 * 1000 < 2000) {
          return false;
        } else if ("Who is my lovely baby?".length > 10) {
          return true;
        } else {
          return false;
        }
      }: () {
        return "Test OK";
      },
      () {
        return int.tryParse("3.14*") != null;
      }: () {
        return "PI get";
      }
    });
    return something;
  }

  Map<String, Function> get data => {
        """
    int howManyFruits = 2;
    int? index = whenString<int>("banana🍌", {
      "water" + "melon".more(): () {
        return 1;
      },
      "apple".more(): () {
        return 2;
      },
      howManyFruits <= 1 ? "orange" : "oranges": () {
        return 3;
      },
      "banana" + "🍌": () {
        return 4;
      },
      "grape": () {
        return 5;
      },
    });
    """: testWhenString,
        """
      String? status = whenInt<String>(1, {
      1: () {
        return "good";
      },
      1 + 1: () {
        return "nice";
      },
      int.parse("3"): () {
        return "better";
      },
    });
    """: testWhenInt,
        """
      String? status = whenDouble<String>(2.0, {
      0.1: () {
        return "good";
      },
      1.0 + 1: () {
        return "nice";
      },
      double.parse("3.2"): () {
        return "better";
      },
    });
    """: testWhenDouble,
        """
       String? kind = whenValue<List, String>(
      ["apple", "orange"],
      {
        ["cat", "dog"]: () {
          return "pets";
        },
        ["apple", "orange"]: () {
          return "fruits";
        },
        ["red", "white", "black"]: () {
          return "colors";
        },
      },
    );
    """: testWhenValue,
        """
    String? winner = when<String>({
      "Dart is Language".contains("UI"): () {
        return "Flutter";
      },
      "Flutter is UI Framework".contains("UI"): () {
        return "Flutter";
      },
    });
    """: testWhen,
        """
    String? something = whenTrue<String>({
      () {
        if (1 + 100 * 1000 < 2000) {
          return false;
        } else if ("Who is my lovely baby?".length > 10) {
          return true;
        } else {
          return false;
        }
      }: () {
        return "Test OK";
      },
      () {
        return int.tryParse("3.14*") != null;
      }: () {
        return "PI get";
      }
    });
    """: testWhenTrue,
      };

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
        child: ListView(
          children: data.entries
              .map((method) => Column(
                    children: [
                      Text(method.key),
                      Text("run result=> ${method.value()}"),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
