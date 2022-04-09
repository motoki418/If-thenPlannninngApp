//
//  ViewModel.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

// パブリッシャー(配信)
import SwiftUI
import CoreData

class ViewModel: ObservableObject {
    // enumはrawValueとしてString
    // PickerのForeachで使えるようにCaseIterableに指定
    enum Category: String, CaseIterable {
        case meal = "食事"
        case sleep = "睡眠"
        case exercise = "運動"
        case study = "勉強"
    }
    // この値をPickerのselectionとバインドさせる
    @Published var selection: Category = .meal
    // 入力されたルールを保持する状態変数(if)
    @Published var inputRule1: String = ""
    // 入力されたルールを保持する状態変数(then)
    @Published var inputRule2: String = ""
    // シート表示を管理する状態変数
    @Published var isShowSheet: Bool = false
    // @FetchRequest変数を利用してCoreData(データベース)に登録されているデータを取得する（Fetch処理）
    // @FetchRequestを使ってプロパティを宣言すると、
    // プロパティ(items)に検索結果が格納されるとともに、データの変更がViewに即時反映される
    // データベースの検索結果とViewを紐付けることができる
    // 今回の取得条件は、昇順(日付が近いメモが上）でフェッチするように指定
    @FetchRequest(entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date,
                                           ascending: true)]
    )
    // 検索結果が配置されるmemosプロパティは FetchedResults<エンティティクラス> のコレクション型で
    // 1レコードに該当するMemoエンティティクラス（NSManagedObjectの派生クラス）の配列を保持します。
    private var items: FetchedResults<Item>

    // メモの新規登録と編集を行うメソッド
    func addRule(context: NSManagedObjectContext) {
        // データの新規登録処理
        // データの新規登録は、Memoエンティティクラス（NSManagedObjectの派生クラス）
        // のインスタンスを生成して実現
        // Itemクラスのイニシャライザには、ManagedObjectContextを渡す必要がある
        let newItem = Item(context: context)
        print("--------新規登録の値---------")
        // ItemクラスのインスタンスであるnewItemを生成し、content1属性に入力した値inputRule1を設定
        newItem.content1 = inputRule1
        // ItemクラスのインスタンスであるnewItemを生成し、conten2属性に入力した値inputRule2を設定
        newItem.content2 = inputRule2
        // date属性に現在の日付を設定
        newItem.date = Date()
        // データベース(CoreData)への保存処理
            // 保存処理にNSManagedObjectContextのsave()メソッドを使用する
            // saveメソッドはエラーを返す可能性があるため必ずtry文とdo-catch文と使用して例外処理をする
            do {
                // 保存処理にはNSManagedObjectContextのsave()メソッドを使用
                // データの書き込み後はSheet(ルールの追加画面)を閉じて、
                // 次回のデータの登録に向けてメモの内容・日付を初期化する
                try context.save()
                isShowSheet.toggle()
                inputRule1 = ""
                inputRule2 = ""
                print("inputRule1には\(inputRule1)")
                print("inputRule2には\(inputRule2)")
                print("--------新規登録の値---------")
            } catch {
                // エラー処理
                let error = error as Error
                print("error.localizedDescription:  \(error.localizedDescription)")
        }// do catch文ここまで
    }// addItem()ここまで
}// ViewModelここまで
