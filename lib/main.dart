import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LynFlutter',
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
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(title: 'Flutter-Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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

class Point {
  num x, y, z;
  static num factor = 0;
  // 语法糖，等同于在函数体内：this.x = x;this.y = y;
//  Point(this.x,this.y);
  Point(this.x,this.y) : z = 0;// 初始化变量 z
  Point.bottom(num x) : this(x, 0);// 重定向构造函数
//  void printInfo() => print('($x, $y)');
  void printInfo() => print('($x, $y, $z)');
  static void printZValue() => print('$factor');
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  bool isZero(int num) {
    return num == 0;
  }

  // 要达到可选命名参数的用法，那就在定义函数的时候给参数加上 {}
  void enable1Flags({bool bold, bool hidden}) => print("$bold , $hidden");
  // 定义可选命名参数时增加默认值
  void enable2Flags({bool bold = true, bool hidden = false}) => print("$bold ,$hidden");
  // 可忽略的参数在函数定义时用 [] 符号指定
  void enable3Flags(bool bold, [bool hidden]) => print("$bold ,$hidden");
  // 定义可忽略参数时增加默认值
  void enable4Flags(bool bold, [bool hidden = false]) => print("$bold ,$hidden");

  void printInfo(int num, Function check) {
    print('$num is zero: ${check(num)}');
  }

  void _incrementCounter() {
    Function f = isZero;
    printInfo(_counter, f);
    printInfo(0, f);

    if (_counter % 2 == 0) {
      // 可选命名参数函数调用
      enable1Flags(bold: true, hidden: false); //true, false
      enable1Flags(bold: true); //true, null
      enable2Flags(bold: false); //false, false

      // 可忽略参数函数调用
      enable3Flags(true, false); //true, false
      enable3Flags(true,); //true, null
      enable4Flags(true); //true, false
      enable4Flags(true,true); // true, true
    } else {
      var p = new Point(100,200); // new 关键字可以省略
      p.printInfo();  // 输出 (100, 200);
      Point.factor = 10;
      Point.printZValue(); // 输出 10

      var pb = Point.bottom(100);
      pb.printInfo();
    }

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
//      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var hello = 'Hello';
    var world = 'world';
    var helloWorld = hello + " " + world;
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
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$helloWorld',
            style: Theme.of(context).textTheme.button,
            textAlign: TextAlign.start),
            Text(
              'You have pushed the button this many times:',
              style: Theme.of(context).textTheme.body2,
              textAlign: TextAlign.start,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
