//
//  DataListRowView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

import SwiftUI

import SwiftUI

struct DataListRowView: View {
    // ①FetchRequestの保存用
    // @FetchRequestは使用せず、代わりにカスタムFetchRequestを保存する次のようなプロパティを宣言します。
    var fetchRequest: FetchRequest<Item>

    // ②FetchRequestの生成
    // イニシャライザの引数で受け取った検索キーを使って、FetchRequestを生成します
    init(category: String) {
        fetchRequest = FetchRequest<Item>(
            entity: Item.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)],
            predicate: NSPredicate(format: "category == %@", category))
    }

    var body: some View {
        List {
            // 検索結果を取得する場合は、次のようにfetchRequestのwrappedValueを使って
            // データを引き出す必要があります。
            ForEach(fetchRequest.wrappedValue, id: \.self) { item in
                Section {
                    VStack(alignment: .leading) {
                        Text("if: \(item.content1!)")
                        Text("then: \(item.content2!)")
                        Text(item.date!, style: .date)
                        Text(item.category!)
                    }// VStackここまで
                }// Sectionここまで
            }// ForEachここまで
        }// Listここまで
    }// bodyここまで
}// DataListRowViewここまで
