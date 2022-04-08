//
//  ViewModel.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

//パブリッシャー(配信)
import SwiftUI
import CoreData

class ViewModel: ObservableObject{
    //入力されたルールを保持する状態変数(if)
    @Published var inputRule1: String = ""
    // 入力されたルールを保持する状態変数(then)
    @Published var inputRule2: String = ""
    // 選択した日付を保持する状態変数
    @Published var date: Date = Date()
    // シート表示を管理する状態変数
    @Published var isShowSheet: Bool = false
    // CoreDataに保存されているデータを保持して、
    // データ編集用のメソッドと、データを書き込む時に新規登録or編集なのかを判断する際に使用する変数
    private var updateItem: Item!

    @Environment(\.managedObjectContext) private var context
    //@FetchRequest変数を利用してCoreData(データベース)に登録されているデータを取得する（Fetch処理）
    //@FetchRequestを使ってプロパティを宣言すると、プロパティ(memos)に検索結果が格納されるとともに、データの変更がViewに即時反映される
    //データベースの検索結果とViewを紐付けることができる
    @FetchRequest(
        //今回の取得条件は、sortDescriptorsでMemo.dateをキーとして昇順(日付が近いメモが上）でフェッチするように指定
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)]
    )
    //検索結果が配置されるmemosプロパティは FetchedResults<エンティティクラス> のコレクション型で、1レコードに該当するMemoエンティティクラス（NSManagedObjectの派生クラス）の配列を保持します。
    private var items: FetchedResults<Item>
    // メモの新規登録と編集を行うメソッド
    func addRule(context: NSManagedObjectContext)  {
        // データの編集処理
        // contenxtMenuで編集がタップされたときにeditItem()が呼び出されて、メモの内容をupdateItemに格納する
        // updateItemがnilじゃない(編集するデータがある)時にif文内のコードが利用されて、
        // CoreDataに編集したルールの内容と選択した日付が書き込まれる
        if updateItem != nil{
            print("--------編集時の値---------")
            updateItem.content1 = inputRule1
            updateItem.content2 = inputRule2
            updateItem.date = date
            print("inputRule1には\(inputRule1)")
            print("inputRule2には\(inputRule2)")
            print("dateには\(date)")
            // データベース(CoreData)への保存処理
            // 保存処理にNSManagedObjectContextのsave()メソッドを使用する
            // saveメソッドはエラーを返す可能性があるため必ずtry文とdo-catch文と使用して例外処理をする
            if context.hasChanges{
                do{
                    // 保存処理にはNSManagedObjectContextのsave()メソッドを使用
                    try context.save()
                    // データの書き込み後はSheet(メモの追加画面)を閉じて、
                    // 次回のデータの登録に向けてメモの内容・日付を初期化する
                    updateItem = nil
                    isShowSheet.toggle()
                    inputRule1 = ""
                    inputRule2 = ""
                    date = Date()
                    print("inputRule1には\(inputRule1)")
                    print("inputRule2には\(inputRule2)")
                    print("dateには\(date)")
                    print("--------編集時の値---------")
                    return
                }catch{
                    //エラー処理
                    let error = error as Error
                    print(error.localizedDescription)
                }
            }
        }//データの編集処理
        
        //データの新規登録処理
        //データの新規登録は、Memoエンティティクラス（NSManagedObjectの派生クラス）のインスタンスを生成して実現
        //Itemクラスのイニシャライザには、ManagedObjectContextを渡す必要がある
        let newItem = Item(context: context)
        print("--------新規登録の値---------")
        //ItemクラスのインスタンスであるnewItemを生成し、content1属性に入力した値inputRule1を設定
        newItem.content1 = inputRule1
        print("inputRule1には\(inputRule1)")
        //ItemクラスのインスタンスであるnewItemを生成し、conten2属性に入力した値inputRule2を設定
        newItem.content2 = inputRule2
        print("inputRule2には\(inputRule2)")
        //date属性に選択した日付を設定
        newItem.date = date
        print("dateには\(date)")
        //データベース(CoreData)への保存処理
        //hasChanges(NSManagedObjectContextに変更に変更があるかをboolで返す)でデータに変更があった場合のみ保存
        if context.hasChanges{
            //保存処理にNSManagedObjectContextのsave()メソッドを使用する
            //saveメソッドはエラーを返す可能性があるため必ずtry文とdo-catch文と使用して例外処理をする
            do{
                // 保存処理にはNSManagedObjectContextのsave()メソッドを使用
                // データの書き込み後はSheet(ルールの追加画面)を閉じて、
                // 次回のデータの登録に向けてメモの内容・日付を初期化する
                try context.save()
                isShowSheet.toggle()
                inputRule1 = ""
                inputRule2 = ""
                date = Date()
                print("inputRule1には\(inputRule1)")
                print("inputRule2には\(inputRule2)")
                print("dateに\(date)")
                print("--------新規登録の値---------")
            }catch{
                //エラー処理
                let error = error as Error
                print(error.localizedDescription)
            }
        }//データの新規登録処理
    }//addItem()
    
    //データ編集用のメソッド
    //編集するメモの内容と選択した日付を表示して、登録用のSheet(addRuleView.swift)を表示する。
    //データの書き込みに関しては、新規登録用のaddItem()を利用する。
    func editItem(item:Item){
        print("------editItem-----")
        updateItem = item
        inputRule1 = item.content1!
        inputRule2 = item.content2!
        date = item.date!
        isShowSheet.toggle()
        print("isShowSheetには\(isShowSheet)")
        print("inputRule1には\(inputRule1)")
        print("inputRule2には\(inputRule2)")
        print("dateに\(date)")
        print("------editMemo------")
    }//editItem()
}// ViewModel
