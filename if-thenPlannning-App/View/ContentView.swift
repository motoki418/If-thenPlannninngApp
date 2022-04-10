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
        appearance.backgroundColor = UIColor.keyColor
        // タイトルの色設定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
    }// init()

    // ContentView ⇄ AddRuleViewのシートを管理する状態変数
    @State var isShowSheet: Bool = false
    // 非管理オブジェクトコンテキスト(ManagedObjectContext)の取得
    // 非管理オブジェクトコンテキストはデータベース操作に必要な操作を行うためのオブジェクト
    @Environment(\.managedObjectContext) private var context

    let categores = ["食事", "睡眠", "運動", "勉強"]

    @State private var selectionCategory = 0

    var body: some View {
        VStack {
            // カテゴリの選択
            Picker("", selection: $selectionCategory) {
                ForEach(0 ..< categores.count, id: \.self) { index in
                    // カテゴリ名を表示
                    Text(categores[index])
                }// ForEach
            }// Picker
            .pickerStyle(SegmentedPickerStyle())
            // ルール一覧表示View
            // 引数categoryには、Pikcerで選択したカテゴリ名を渡す
            DataListRowView(category: categores[selectionCategory])
            Spacer()
            // 画面右下に「＋」ボタンを配置するする
            HStack {
                Spacer()
                Button {
                    isShowSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.keyColor)
                        .clipShape(Circle())
                    // ボタンの下に余白を入れる
                        .padding(.bottom, 20)
                }// 「＋」ボタンここまで
                .padding()
                .sheet(isPresented: $isShowSheet) {
                    AddRuleView(isShowSheet: $isShowSheet)
                }// .sheetここまで
            }// HStackここまで
        }// VStack
    }// bodyここまで
}// ContentViewここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
