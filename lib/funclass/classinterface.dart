class Point {
  num x = 0, y = 0;
  void printInfo(String tag) => print('-$tag:($x,$y)');
}

//Vector 继承自 Point
class Vector extends Point{
  num z = 0;
  @override
//  void printInfo() => this.printInfo1(""); // 覆写了 printInfo 实现
  void printInfo(String tag) => print(this.toString() +'-$tag:($x,$y,$z)'); // 覆写了 printInfo 实现
}

//Coordinate 是对 Point 的接口实现
class Coordinate implements Point {
  num x = 0, y = 0; // 成员变量需要重新声明
  void printInfo(String tag) => print(this.toString() + "-$tag:($x,$y)"); // 成员函数需要重新声明实现
}

/// NOTE: the extends clause must be before with clause
class CoordinateMixin extends Point with Point /*NOTE: the extends clause must be before with clause*/ {
//  @override
//  void printInfo(String tag) {
//    // TODO: implement printInfo
//    super.printInfo(tag);
//  }
//  void printInfo(String tag) => print(this.toString() +'-override-$tag:($x,$y)'); // 覆写了 printInfo 实现
}

class A {
  String getMessage() => 'A';
  void printAInfo(String tag) => print('$tag:this is A');
}

class B {
  String getMessage() => 'B';
  void printBInfo(String tag) => print('$tag:this is B');
}

class P {
  String getMessage() => 'P';
}

class AB extends P with A, B {}

class BA extends P with B, A {}

/// Vector 类中自定义 “+” 运算符和覆写"=="运算符的例子...
class OperatorVector {
  num x, y;
  OperatorVector(this.x, this.y);
  // 自定义相加运算符，实现向量相加
  OperatorVector operator + (OperatorVector v) =>  OperatorVector(x + v.x, y + v.y);
  // 覆写相等运算符，判断向量相等
  bool operator == (dynamic v) => x == v.x && y == v.y;
}


class VectorAction {
  void run() {
    print("VectorAction.run 运行");

    var xxx = Vector();
    xxx..x = 1
      ..y = 2..z = 3; // 级联运算符（可不换行，连着写：..x = 1..y = 2..z = 3），等同于 xxx.x=1; xxx.y=2;xxx.z=3;
    xxx.printInfo("xxx"); // 输出 (1,2,3)

    var yyy = Coordinate();
    yyy
      ..x = 1
      ..y = 2; // 级联运算符，等同于 yyy.x=1; yyy.y=2;
    yyy.printInfo("yyy"); // 输出 (1,2)
    print ("yyy is Point:" + (yyy is Point).toString()); //true
    print("yyy is Coordinate:" + (yyy is Coordinate).toString()); //true

    var yym = CoordinateMixin();
    yym.printInfo("yym");
    print ("yym is Point:" + (yym is Point).toString()); //true
    print ("yym is CoordinateMixin:" + (yym is CoordinateMixin).toString()); //true


    print("A, B, P mixin run...");
    String result = '';

    AB ab = AB();
    result += ab?.getMessage();
    ab.printAInfo("ab");
    ab.printBInfo("ab");
    print("ab.getMessage():"+result);


    BA ba = BA();
    ba.printAInfo("ba");
    ba.printBInfo("ba");
    result += ba.getMessage();

    print(result);

    /// 运算符：?.  ??=   ??
    print("运算符相关, operator run");

    AB c;
    c?.printAInfo("c");
    c ??= AB();
    c.printAInfo("new-c");
    AB d;
    d?.printAInfo("d");
    d ?? AB();
    d?.printAInfo("not=sure-new=d");
    d = d ?? AB();
    d?.printAInfo("new-d");


    /// Vector 类中自定义“+”运算符和覆写"=="运算符的例子...
    final x = OperatorVector(3, 3);
    final y = OperatorVector(2, 1);
    final z = OperatorVector(1, 1);
    print("x == (y + z):" + (x == (y + z)).toString()); //  输出 true
  }
}
