//
//  DataListRowView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

import SwiftUI

struct DataListRowView: View {
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
        VStack{
            if items.isEmpty{
                Spacer()
                //画面の中央に表示
                Text("ADD IF THEN RULE")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            //CoreDataに登録されたデータがある場合
            else{
                ScrollView(.vertical, showsIndicators: true){
                    //１件分のメモのテキストと日付の位置を左寄せにして文字の間にスペースを入れる
                    LazyVStack(alignment: .leading, spacing: 5){
                        ForEach(items){ item in
                                //入力したメモを表示
                                Text("\(item.wrappedContent1) \(item.wrappedContent2)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                // 日付を表示
                             Text(item.stringUpdatedAt)
                                    .fontWeight(.bold)
                                //区切り線を引く
                                Divider()
                            //.contextMenuを使用して、メモを長押しすると削除と編集が選べるように設定
                            .contextMenu{
                                Button{
                                    context.delete(item)
                                }label:{
                                    Label("削除",systemImage:"trash")
                                }//削除ボタン
                            }//contextMenu
                        }// ForEachここまで
                    }// LazyVStack
                    .padding()
                }// ScrollView
            }// if文ここまで
        }// VStackここまで
    }// bodyここまで
}// DataListRowViewここまで

struct DataListRowView_Previews: PreviewProvider {
    static var previews: some View {
        DataListRowView()
    }
}

