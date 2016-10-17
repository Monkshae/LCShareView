//: Playground - noun: a place where people can play

import UIKit

class Person: NSObject {
    
    var name: String?
    // 如果属性是基本数据类型, 并且是可选类型, 系统不会自动分配存储空间
    var age: Int = 0

//    override init() {
//        // 注意: 在构造方法中必须先初始化本类再初始化父类
//        name = "gcy"
//        age = 24
//        // 当我们重写一个类的构造方法时, 系统内部会悄悄的帮我们调用super.init()
//       // super.init()
//        
//    }
//    
//    
//    // 自定义构造方法
//    init(name: String, age: Int)
//    {
//        self.name = name
//        self.age = age
//        //以下这一句代码, 能不写就不写
//        //super.init()
//    }
//    
//    init(dict: [String: AnyObject])
//    {
//        // 注意:Swift中如果想在构造方法中使用KVC转换模型, 必须先调用 super.init()
//        super.init()
//        setValuesForKeysWithDictionary(dict)
//    }
//    
//    // Swift中打印对象会调用下面这个属性
//    override var description: String {
//        let property = ["name", "age"]
//        let dict = dictionaryWithValuesForKeys(property)
//        return "\(dict)"
//    }
    
}

//let person = Person()
//person.hash
//
//let str: String = "beixinke"
//var subStr = str.substringWithRange(Range<String.Index>(start: str.startIndex, end: str.endIndex))
//print(subStr)

//let a = String(describing: Person.self)
//print(a)


var a = [1, 2]
a.reserveCapacity(256) // swift 3.0
a += sequence(first: 3, next: {$0 < 1000 ? ($0 + 3) * 2 : nil})
a

var i = 1
repeat {
    print(i)
    i = i * 2
} while i <= 100
