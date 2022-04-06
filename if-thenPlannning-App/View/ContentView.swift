//
//  ContentView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

import SwiftUI
import CoreData
struct ContentView: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.blue
        // タイトルの色設定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
    }// init()
    // SafariViewの表示有無を管理する状態変数
    @State private var isShowSafari = false
    // シートの状態を管理する状態変数
    @State private var isShowSheet = false
    // 非管理オブジェクトコンテキスト(ManagedObjectContext)の取得
    // 非管理オブジェクトコンテキストはデータベース操作に必要な操作を行うためのオブジェクト
    @Environment(\.managedObjectContext) private var context
    // データベースからデータを取得する処理(Fetch処理)
    // @FetchRequesプロパティラッパーを使って、データベースを検索し、対象データ群をtasksプロパティに格納
    // @ FetchRequestを使ってプロパティを宣言すると、プロパティ(data)に検索結果が格納されるとともに、
    // データの変更がViewに即時反映される
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)], predicate: nil)
    private var datas: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            // 背景色の上にメモの内容と＋ボタンを重ねて表示する
            ZStack {
                VStack {
                    List{
                        ForEach(datas){ data in
                            //１件分のメモのテキストと日付の位置を左寄せにして文字の間にスペースを入れる
                            VStack(alignment: .leading, spacing: 5){
                                //入力したメモを表示
                                //wrappedContentはMemo+CoreDataProperties.swiftでMemoをextentionした時に宣言した変数
                                //contentはオプショナル変数なので事前にnilだった時の処理を決めている
                                Text("\(data.wappedContent1) \(data.wappedContent2)")
                                    .fontWeight(.bold)
                                //選択した日付を表示
                                //wrappedDateはMemo+CoreDataProperties.swiftでMemoをextentionした時に宣言した変数
                                //dateはオプショナル変数なので事前にnilだった時の処理を決めている
                                Text(data.wrappedDate, style: .date)
                                    .fontWeight(.bold)
                            }// VStackここまで
                            //.contextMenuを使用して、メモを長押しすると削除と編集が選べるように設定
                            .contextMenu{
                                Button{
                                    context.delete(data)
                                }label:{
                                    Label("削除",systemImage:"trash")
                                }//削除ボタン
                            }//contextMenu
                        }// ForEachここまで
                    }// Listここまで
                    // 画面右下に「＋」ボタンを配置するするためにVStackとHStackで囲んで、
                    // Spacer()でボタンの上と左側にスペースを入れる
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            isShowSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.blue)
                                .clipShape(Circle())
                            // ボタンの下に余白を入れる
                                .padding(.bottom, 20)
                        }// 「＋」ボタンここまで
                        .padding()
                        .sheet(isPresented: $isShowSheet) {
                            AddRuleView(isShowSheet: $isShowSheet)
                        }// .sheetここまで
                    }// HStackここまで
                }// VStackここまで
            }// ZStackここまで
            .navigationTitle("データ一覧")
            .navigationBarTitleDisplayMode(.inline)
        }// NavigationViewここまで
    }// bodyここまで
}// ContentViewここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
