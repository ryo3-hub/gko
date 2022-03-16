import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String playerName;
  bool isPlayerMaru = true;
  int pattern = 0;

  List<FieldModel> fieldList = [
    FieldModel(no: 1),
    FieldModel(no: 2),
    FieldModel(no: 3),
    FieldModel(no: 4),
    FieldModel(no: 5),
    FieldModel(no: 6),
    FieldModel(no: 7),
    FieldModel(no: 8),
    FieldModel(no: 9),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    setState(() {
      playerName = "⭕️";
      isPlayerMaru = true;
      pattern = 0;
    });
  }

  void _togglePlayer() {
    setState(() {
      isPlayerMaru = !isPlayerMaru;
      playerName = isPlayerMaru ? "⭕️" : "✖️";
    });
  }

  void check() {
    var resultList = fieldList
        .where(
            (element) => element.isResult && element.isPlayer == isPlayerMaru)
        .map((e) => e.no);

    if (resultList.contains(1)) {
      if (resultList.contains(2)) {
        if (resultList.contains(3)) {
          pattern = 1;
        }
      }
    }

    if (resultList.contains(4)) {
      if (resultList.contains(5)) {
        if (resultList.contains(6)) {
          pattern = 2;
        }
      }
    }

    if (resultList.contains(7)) {
      if (resultList.contains(8)) {
        if (resultList.contains(9)) {
          pattern = 3;
        }
      }
    }

    if (resultList.contains(1)) {
      if (resultList.contains(4)) {
        if (resultList.contains(7)) {
          pattern = 4;
        }
      }
    }

    if (resultList.contains(2)) {
      if (resultList.contains(5)) {
        if (resultList.contains(8)) {
          pattern = 5;
        }
      }
    }

    if (resultList.contains(3)) {
      if (resultList.contains(6)) {
        if (resultList.contains(9)) {
          pattern = 6;
        }
      }
    }

    if (resultList.contains(1)) {
      if (resultList.contains(5)) {
        if (resultList.contains(9)) {
          pattern = 7;
        }
      }
    }

    if (resultList.contains(3)) {
      if (resultList.contains(5)) {
        if (resultList.contains(7)) {
          pattern = 8;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GKO ⭕️✖️ゲーム'),
      ),
      body: Column(
        children: [
          if (pattern == 0)
            SizedBox(
              height: 48,
              child: Text(
                '$playerNameの番です。',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          if (pattern > 0)
            Text(
              '$playerNameの勝ちです。',
              style: const TextStyle(fontSize: 48),
            ),
          Center(
            child: CustomPaint(
              painter: _MyPainter(pattern),
              child: SizedBox(
                height: 600,
                child: Column(
                  children: <Widget>[
                    _rowField(0),
                    Container(
                      color: Colors.black,
                      width: double.infinity,
                      height: 1,
                    ),
                    _rowField(3),
                    Container(
                      color: Colors.black,
                      width: double.infinity,
                      height: 1,
                    ),
                    _rowField(6),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
              child: const Text('最初から'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                init();
                setState(() {
                  for (var element in fieldList) {
                    element.isResult = false;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowField(int startIndex) {
    return Expanded(
      child: Row(
        children: [
          Expanded(child: _tapField(fieldList[startIndex])),
          Container(
            color: Colors.black,
            width: 1,
            height: double.infinity,
          ),
          Expanded(child: _tapField(fieldList[startIndex + 1])),
          Container(
            color: Colors.black,
            width: 1,
            height: double.infinity,
          ),
          Expanded(child: _tapField(fieldList[startIndex + 2])),
        ],
      ),
    );
  }

  Widget _tapField(FieldModel fieldModel) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Center(
        child: Text(
          fieldModel.isResult
              ? fieldModel.isPlayer
                  ? "⭕️"
                  : "✖️"
              : "",
          style: const TextStyle(fontSize: 100),
        ),
      ),
      onTap: () {
        setState(() {
          fieldModel.isResult = true;
          fieldModel.isPlayer = isPlayerMaru;
        });
        check();
        if (pattern == 0) {
          _togglePlayer();
        }
      },
    );
  }
}

class FieldModel {
  late int no;
  bool isResult = false;
  late bool isPlayer;
  FieldModel({required this.no});
}

class _MyPainter extends CustomPainter {
  // ※ コンストラクタに引数を持たせたい場合はこんな感じで
  int patttern = 0;
  _MyPainter(this.patttern);

  // 実際の描画処理を行うメソッド
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    paint.strokeWidth = 10;
    if (patttern == 1)
      canvas.drawLine(const Offset(0, 0), const Offset(430, 600), paint);
  }

  // 再描画のタイミングで呼ばれるメソッド
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
