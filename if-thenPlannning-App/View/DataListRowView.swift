//
//  DataListRowView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

import SwiftUI

struct DataListRowView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    // 非管理オブジェクトコンテキスト(ManagedObjectContext)の取得
    // 非管理オブジェクトコンテキストはデータベース操作に必要な操作を行うためのオブジェクト
    @Environment(\.managedObjectContext) private var context
    // データベースからデータを取得する処理(Fetch処理)
    // @FetchRequesプロパティラッパーを使って、データベースを検索し、対象データ群をtasksプロパティに格納
    // @ FetchRequestを使ってプロパティを宣言すると、プロパティ(data)に検索結果が格納されるとともに、
    // データの変更がViewに即時反映される
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Item.date,ascending: false)], predicate: nil)
    
    private var items: FetchedResults<Item>

    var body: some View {
        List{
            Section(header: Text("食事")){
                ForEach(items){ item in
                    VStack(alignment: .leading, spacing: 5){
                        // 入力したメモを表示
                        HStack{
                            Text("if")
                                .foregroundColor(.keyColor)
                                .font(.title3)
                                .fontWeight(.bold)
                            Text(item.wrappedContent1)
                                .font(.title3)
                                .fontWeight(.bold)
                        }// HStackここまで
                        HStack{
                            Text("then")
                                .foregroundColor(.keyColor)
                                .font(.title3)
                                .fontWeight(.bold)
                            Text(item.wrappedContent2)
                                .font(.title3)
                                .fontWeight(.bold)
                        }// HStackここまで
                        // 日付を表示
                        Text(item.stringUpdatedAt)
                            .fontWeight(.bold)
                    }// VStackここまで
                }// ForEachここまで
                // データの削除
                .onDelete(perform: removeData)
            }// Listここまで
        }// Sectionここまで
    }// bodyここまで

    // データの削除を行うメソッド
    private func removeData(at offsets: IndexSet) {
        // offsetsには削除対象の要素番号が入るので、これを使って要素番号に対応するエンティティを削除する。
        for index in offsets {
            let putItem = items[index]
            context.delete(putItem)
        }
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }// removeData
}// DataListRowViewここまで
