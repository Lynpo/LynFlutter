class Point {
  num x, y;
  Point() : this.make(0,0);
  Point.left(x) : this.make(x,0);
  Point.right(y) : this.make(0,y);
  Point.make(this.x, this.y);
  void printInfo() => print('($x,$y)');
}

class Vector extends Point{
  num z = 0;
//  Vector.left();
//  Vector.middle();
//  Vector();
//  Vector.left();
//  Vector.middle();
//  Vector.right();
//  Vector.make();
/*5 个构造函数
*/
  @override
  void printInfo() => print('($x,$y,$z)'); // 覆写了 printInfo 实现
}

class TestAction {
  void run(){
    Vector v = Vector();


/*5 个构造函数
  Vector
  Vector.left;
  Vector.middle
  Vector.right
  Vector.make
*/
  }
}