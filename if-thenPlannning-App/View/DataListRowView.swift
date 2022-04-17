//
//  DataListRowView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

import SwiftUI

struct DataListRowView: View {
    // ①FetchRequestの保存用
    // 構造体のプロパティとして作成される@ FetchRequestは、
    // Swiftの制限により、他のプロパティを参照する事ができないため、
    // @FetchRequestは使用せず、代わりにカスタムFetchRequestを保存する次のようなプロパティを宣言する。
    private var fetchRequest: FetchRequest<Item>
    // ②FetchRequestの生成
    // イニシャライザの引数(category)で受け取った検索キーを使って、FetchRequestを生成する。
    init(category: String) {
        // カスタムFetchRequestの保存用として作成したfetchRequest変数に、
        // カスタムFetchRequestを格納する。
        fetchRequest = FetchRequest<Item>(
            // 検索対象entityを"エンティティ名.entity()"で指定する。
            entity: Item.entity(),
            // 検索結果のソート順は、NSSortDescriptorクラスを使用して指定する。
            // 引数keyPathで並べ替える属性を、引数ascendingで昇順（true）か降順（false）を指定する。
            // 古いデータ　→ 新しいデータの順番で表示する。
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)],
            // 抽出条件は、NSPredicateクラスを使用して指定する。
            // データに引用符が含まれていると複雑になるので、代わりに次のような構文を使用するのが一般的。
            // %@は「ここに文字列を挿入する」という意味で、
            // そのデータをインラインではなく、パラメータとして提供することが出来る。
            // 今回は、Pikcerで選択したカテゴリ名と一致するデータのみ抽出する。
            predicate: NSPredicate(format: "category == %@", category))
    }// init()ここまで
    // 非管理オブジェクトコンテキスト(ManagedObjectContext)の取得
    @Environment(\.managedObjectContext) private var context
    // wrappedValueを使わず検索結果を取得する為に、計算プロパティを作成
    // deleteRuleメソッドでも使用する
    var items: FetchedResults<Item> {
        fetchRequest.wrappedValue
    }

    var body: some View {
        List {
            // 検索結果(抽出条件)を取得する場合は、fetchRequestのwrappedValueを使って、
            // データを引き出す必要がある。
            ForEach(items, id: \.self) { item in
                VStack(alignment: .leading) {
                    // ifルール
                    Text("if: \(item.content1!)")
                        .font(.title2)
                        .fontWeight(.bold)
                    // thenルール
                    Text("then: \(item.content2!)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("タイプ: \(item.habit!)")
                    // 日付
                    Text("登録日: \(item.stringUpdatedAt)")
                        .font(.title2)
                        .fontWeight(.bold)
                }// VStackここまで
            }// ForEachここまで
            .onDelete(perform: deleteRule)
        }// Listここまで
    }// bodyここまで

    // データ削除を行うメソッド
    private func deleteRule(offsets: IndexSet) {
        // レコードの削除
        // offsetsには、削除対象の要素番号のコレクションが渡ってくるので、
        // 各要素番号に対応したエンティティを、for文で回して削除する
        for index in offsets {
            context.delete(items[index])
        }
        // データベースの保存
        do {
            try context.save()
        } catch {
            // エラー処理
            let error = error as Error
            print("error.localizedDescription:  \(error.localizedDescription)")
        }
    }// deleteRule()ここまで
}// DataListRowViewここまで
