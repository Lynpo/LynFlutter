import 'package:flutter/material.dart';
import 'package:flutter_app/funclass/classinterface.dart';

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

class YourApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _YourAppState();
}

class _YourAppState extends State<YourApp>{
  @override
  void setState(fn) {
    super.setState(fn);
    print("_YourAppState::setState.");
  }
  @override
  Widget build(BuildContext context) {
    print("_YourAppState::build.");
    return Text('Root widget');
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_YourAppState::didChangeDependencies.");
  }
  @override
  void didUpdateWidget(YourApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_YourAppState::didChangeDependencies.");
  }
  @override
  void deactivate() {
    super.deactivate();
    print("_YourAppState::deactivate.");
  }
  @override
  void dispose() {
    super.dispose();
    print("_YourAppState::dispose.");
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = ""}) : super(key: key);

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
//  Point.right(int r):this(r, 0);
//  void printInfo() => print('($x, $y)');
  void printInfo() => print('($x, $y, $z)');
  static void printZValue() => print('$factor');
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;

  /// 生命周期方法测试
  /// 生命周期方法测试
  @override
  void initState() {
    super.initState();
    print("_MyHomePageState==initState.");
    WidgetsBinding.instance?.addObserver(this);
    // 单次 Frame 绘制回调，通过 addPostFrameCallback 实现。它会在当前 Frame 绘制完成后
    // 进行回调，并且只会回调一次，如果要再次监听则需要再设置一次
    WidgetsBinding.instance?.addPostFrameCallback((_){
      print(" 单次 Frame 绘制回调  ");
    });
    // 实时 Frame 绘制回调，则通过 addPersistentFrameCallback 实现。这个函数会在每次绘
    // 制 Frame 结束后进行回调，可以用做 FPS 监测。
    WidgetsBinding.instance?.addPersistentFrameCallback((_){
      print(" 实时 Frame 绘制回调  ");
    });
  }
  @override
  void setState(fn) {
    super.setState(fn);
    print("_MyHomePageState==setState.");
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("_MyHomePageState==didChangeDependencies.");
  }
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_MyHomePageState==didUpdateWidget.");
  }
  @override
  void deactivate() {
    super.deactivate();
    print("_MyHomePageState==deactivate.");
  }
  @override
  void dispose() {
    super.dispose();
    print("_MyHomePageState==dispose.");
    WidgetsBinding.instance?.removeObserver(this);
  }
  /// 生命周期方法测试
  /// 生命周期方法测试

  bool isZero(int num) {
    return num == 0;
  }

  // 要达到可选命名参数的用法，那就在定义函数的时候给参数加上 {}
  void enable1Flags({bool bold, bool hidden = false}) => print("$bold , $hidden");
  // 定义可选命名参数时增加默认值
  void enable2Flags({bool bold = true, bool hidden = false}) => print("$bold ,$hidden");
  // 可忽略的参数在函数定义时用 [] 符号指定
  void enable3Flags(bool bold, [bool hidden = false]) => print("$bold ,$hidden");
  // 定义可忽略参数时增加默认值
  void enable4Flags(bool bold, [bool hidden = false]) => print("$bold ,$hidden");

  void printInfo(int num, Function check) {
    print('$num is zero: ${check(num)}');
  }

  void _onFloatActionButtonPressed() {
    if (_counter % 2 == 0) {
      functionAsParam();
      // 可选命名参数函数调用
      functionParams(); // true, true
      classAccess();
    } else {
      classInterface();
    }

    _incrementCounter();
  }

  void _incrementCounter() {
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

  void functionAsParam() {
    Function f = isZero;
    printInfo(_counter, f);
    printInfo(0, f);
  }

  void classInterface() {
    var v = new VectorAction();
    v.run();
  }

  void classAccess() {
    var p = new Point(100,200); // new 关键字可以省略
    p.printInfo();  // 输出 (100, 200);
    Point.factor = 10;
    Point.printZValue(); // 输出 10
    
    var pb = Point.bottom(100);
    pb.printInfo();
  }

  void functionParams() {
    // 可选命名参数函数调用
    enable1Flags(bold: true, hidden: false); //true, false
    enable1Flags(bold: true); //true, null
    enable2Flags(bold: false); //false, false
    
    // 可忽略参数函数调用
    enable3Flags(true, false); //true, false
    enable3Flags(true,); //true, null
    enable4Flags(true); //true, false
    enable4Flags(true,true); // true, true
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
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFloatActionButtonPressed,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /// 生命周期回调测试，通过混入 WidgetsBindingObserver， 注册回调测试
  /// 生命周期回调测试，通过混入 WidgetsBindingObserver， 注册回调测试
  @override
  void didChangeAccessibilityFeatures() {
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // AppLifecycleState.inactive
    // AppLifecycleState.paused
    // AppLifecycleState.inactive
    // AppLifecycleState.resumed
    print("didChangeAppLifecycleState:new state:$state");
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        break;
      // case AppLifecycleState.suspending:
      //   break;
      case AppLifecycleState.detached:
        break;
    }
  }

  // @override
  // void didChangeLocales(List<Locale> locale) {
  // }

  @override
  void didChangeMetrics() {
  }

  @override
  void didChangePlatformBrightness() {
  }

  @override
  void didChangeTextScaleFactor() {
  }

  @override
  void didHaveMemoryPressure() {
  }

  @override
  Future<bool> didPopRoute() {
    return Future<bool>.value(false);
  }

  @override
  Future<bool> didPushRoute(String route) {
    return Future<bool>.value(true);
  }
/// 生命周期回调测试，通过混入 WidgetsBindingObserver， 注册回调测试
/// 生命周期回调测试，通过混入 WidgetsBindingObserver， 注册回调测试

}
