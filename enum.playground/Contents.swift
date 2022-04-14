import UIKit

// イニシャライザ
// enum ShopItem{
//    case apple
//    case orange
//    case meron
//    case other
//
//    init(fruit: String){
//        switch fruit{
//        case "Apple":
//            self = .apple
//        case "Orange":
//            self = .orange
//        case "Meron":
//            self = .meron
//        default:
//            self = .other
//        }
//    }
// }
//
// ShopItemのcase値からインスタンス生成
// let apple: ShopItem = .apple
// print(type(of: apple))
// print(apple)
//
// String型からインスタンス生成
// let orange: ShopItem = ShopItem(fruit: "Orange")
// print(type(of: orange))
// print(orange)
//
// let meron = ShopItem(fruit: "meron")
// print(meron)

// タイププロパティ　計算型プロパティ
// enum ShopItem{
//    case apple
//    case orange
//    case melon
//
//    var price: Int{
//        switch self{// selfを評価して、一致するケースを返却している
//        case .apple:
//            return 150
//        case .orange:
//            return 300
//        case .melon:
//            return 1000
//        }
//    }
//    // 「static」を付与して、タイププロパティを定義できます。
//    static let market: String = "日本"
// }
//
// let fruit: ShopItem = .apple
// print(type(of: fruit))
// print(fruit)
// print(fruit.price)
// print(ShopItem.market)
//
// インスタンス化せずに直接アクセス
// print(ShopItem.market)

// String型のデフォルト値を設定
enum Fruits: String {
    case apple = "りんご"
    case orange = "オレンジ"
    case melon = "メロン"
}

let fruit: Fruits = .orange
print(fruit)
print(fruit.rawValue)

// Int型のデフォルト値を設定
enum Fruits2: Int {
    case apple = 1
    case orange = 2
    case melon = 3
}
let fruit2: Fruits2 = .melon
print(fruit2)
print(fruit2.rawValue)

enum Fruits3: Int {
    case apple
    case orange
    case melon
}
let fruit3: Fruits3 = .apple
print(fruit3)
print(fruit3.rawValue)
print(type(of: fruit3.rawValue))

enum Fruits4: String {
    case apple
    case orange
    case melon
}
let fruit4: Fruits4 = .melon
print(fruit4)
print(fruit4.rawValue)
print(type(of: fruit4.rawValue))

enum Fruits5: Int {
    case apple = 1, orange, melon
}
let fruit5: Fruits5 = .melon
print(fruit5)
print(fruit5.rawValue)
print(type(of: fruit5.rawValue))

// Raw Valuesを設定している列挙型
enum Fruits6: Int {
    case apple = 1
    case orange = 2
    case melon = 3
}
let fruit6 = Fruits6(rawValue: 2)
print(fruit6)
print(fruit6?.rawValue)
print(type(of: fruit6))

// CaseIterbaleに準拠
enum Fruits7: CaseIterable {
    case apple
    case orange
    case melon
}
// allCasesプロパティですべてのcaseにアクセス可能
for fruit7 in Fruits7.allCases {
    print(fruit7)
}
// String型のRawValuesを設定して、CaseIterableに準拠
enum Fruits8: String, CaseIterable {
    case apple = "りんご"
    case orange = "オレンジ"
    case melon = "メロン"
}
for fruit8 in Fruits8.allCases {
    print("\(fruit8)は、\(fruit8.rawValue)だよ！")
}

enum Fruits9: String, CaseIterable {
    case apple = "りんご"
    case orange = "オレンジ"
    case melon = "メロン"
}

let fruitList: [String] = Fruits9.allCases.map {$0.rawValue}
print(type(of: fruitList))
print(fruitList)
