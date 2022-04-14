//
//  AddRuleViewModel.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

// パブリッシャー(配信)
import SwiftUI
import CoreData

class AddRuleViewModel: ObservableObject {
    // この値をAddRuleViewとContentViewの、Pickerのselectionとバインドさせる
    @Published var selectionCategory: Category = .meal
    // 入力されたルールを保持する状態変数(if)
    @Published var inputRule1: String = ""
    // 入力されたルールを保持する状態変数(then)
    @Published var inputRule2: String = ""
    // 非管理オブジェクトコンテキスト(ManagedObjectContext)の取得
    @Environment(\.managedObjectContext) private var context
    // @FetchRequestを使ってプロパティを宣言すると、
    // プロパティ(items)に検索結果が格納されるとともに、データの変更がViewに即時反映される
    // 今回の取得条件は、昇順(日付が近いメモが上）でフェッチするように指定
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)]
    )
    // 検索結果が配置されるitemsプロパティは FetchedResults<エンティティクラス> のコレクション型で
    // 1レコードに該当するItemエンティティクラス（NSManagedObjectの派生クラス）の配列を保持します。
    private var items: FetchedResults<Item>
    // if-thenルールの新規登録を行うメソッド
    func addRule(context: NSManagedObjectContext) {
        // データの新規登録は、itemエンティティクラス（NSManagedObjectの派生クラス）
        // のインスタンスを生成して実現する。
        // Itemクラスのイニシャライザには、ManagedObjectContextを渡す必要がある
        let newItem = Item(context: context)
        // ItemクラスのインスタンスであるnewItemを生成し、content1属性に入力した値inputRule1を設定
        newItem.content1 = inputRule1
        // ItemクラスのインスタンスであるnewItemを生成し、conten2属性に入力した値inputRule2を設定
        newItem.content2 = inputRule2
        newItem.date = Date()
        // AddRuleViewの、Pickerで選択したカテゴリ名を保存する。
        newItem.category = selectionCategory.rawValue
        print("inputRule1には\(inputRule1)")
        print("inputRule2には\(inputRule2)")
        print("newItem.category:  \(String(describing: newItem.category))")
        // データベース(CoreData)への保存処理
        // 保存処理にNSManagedObjectContextのsave()メソッドを使用する
        // saveメソッドはエラーを返す可能性があるため必ずtry文とdo-catch文と使用して例外処理をする
        do {
            // 保存処理にはNSManagedObjectContextのsave()メソッドを使用
            // データの書き込み後は、次回のデータの登録に向けてルールの内容を初期化する
            try context.save()
            inputRule1 = ""
            inputRule2 = ""
        } catch {
            // エラー処理
            let error = error as Error
            print("error.localizedDescription:  \(error.localizedDescription)")
        }// do catch文ここまで
    }// addItem()ここまで
}// AddRuleViewModelここまで
