abstract class PrintHelper {
  printInfo() => print(getInfo());
  String getInfo();
}

// 抽象商品、购物车基础信息
class Meta {
  int id;
  String name;
  double price;
//  int num;
  // 成员变量初始化语法糖
  Meta(this.name, this.price);
//  Meta(name, price): this.withNum(name, price, 1);
//  Meta.withNum(this.name, this.price, this.num);
}

// 定义商品 Item 类
class Item extends Meta with PrintHelper {
  int num;
//  Item(name, price) : super(name, price);
  Item(name, price) : this.withNum(name, price, 1);
  Item.withNum(name, price, this.num) : super(name, price);
  // 重载了 + 运算符，合并商品为套餐商品
  Item operator + (Item item) => Item('$name, ${item.name}', price * num + item.price * item.num);

  @override
  String getInfo([int index]) {
    return '\n\t 商品$index：$name, \t单价：$price, \t数量：$num, \t价格：${price * num}';
  }
}

// 定义购物车类
class ShoppingCart extends Meta with PrintHelper {
  DateTime date;
  String code;
  List<Item> bookings;

//  double get price {
//    double sum = 0.0;
//    for(var i in bookings) {
//      sum += i.price;
//    }
//    return sum;
//  }
  // 把迭代求和改写为归纳合并
  double get price => bookings.reduce((value, element) => value + element).price;
  String getProductLists() {
    String s;
    s ??= "";
    int index = 1;
    bookings.forEach((element) {s += element.getInfo(index=index); index++;});
    return s;
  }

  // 默认初始化方法，转发到 withCode 里
  ShoppingCart({name}) : this.withCode(name:name, code:null);
  //withCode 初始化方法，使用语法糖和初始化列表进行赋值，并调用父类初始化方法
  ShoppingCart.withCode({name, this.code}) : date = DateTime.now(), super(name, 0);

  // 使用多行字符串声明的方式，来完全抛弃不优雅的字符串拼接，运算符 '''...'''
  //?? 运算符表示为: code 不为 null，则用原值，否则使用默认值 " 没有 "
  @override
  String getInfo() => '''
  
    购物车信息:
    -----------------------------
     用户名:$name
     优惠码:${code ?? " 没有 "}
     商品列表：
     ${getProductLists()}

     总价:$price
     日期:$date
    -----------------------------
  ''';
}

void main() {
  // 对于调用方而言，还可以使用级联运算符“..”，在同一个对象上连续调用多个函数以及访问成员变量。
  // 使用级联操作符可以避免创建临时变量，让代码看起来更流畅：
  ShoppingCart(name:'张三')
    ..bookings = [Item.withNum('苹果',10.0, 3), Item.withNum('鸭梨',42.0, 5), Item('西瓜',20.0)]
//    ..bookings = [Item('苹果',10.0), Item('鸭梨',42.0), Item('西瓜',20.0)]
    ..printInfo();

  ShoppingCart.withCode(name:'李四', code:'123456')
    ..bookings = [Item.withNum('香蕉',8.0, 4), Item('榴莲',22.0), Item('凤梨',29.2)]
    ..printInfo();
}
