//
//  DataListRowView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

import SwiftUI

struct DataListRowView: View {
    // AddRuleViewModelクラスのインスタンス変数
    @ObservedObject var addRuleVM: AddRuleViewModel = AddRuleViewModel()
    // ①FetchRequestの保存用
    // 構造体のプロパティとして作成される@ FetchRequestは、
    // Swiftの制限により、他のプロパティを参照する事ができないため、
    // @FetchRequestは使用せず、代わりにカスタムFetchRequestを保存する次のようなプロパティを宣言する。
    var fetchRequest: FetchRequest<Item>
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

    var body: some View {
        List {
            // 検索結果(抽出条件)を取得する場合は、次のようにfetchRequestのwrappedValueを使って、
            // データを引き出す必要がある。
            ForEach(fetchRequest.wrappedValue, id: \.self) { item in
                    VStack(alignment: .leading) {
                        // ifルール
                        Text("if: \(item.content1!)")
                        // thenルール
                        Text("then: \(item.content2!)")
                        // 日付
                        Text(item.stringUpdatedAt)
                    }// VStackここまで
            }// ForEachここまで
        }// Listここまで
    }// bodyここまで
}// DataListRowViewここまで
