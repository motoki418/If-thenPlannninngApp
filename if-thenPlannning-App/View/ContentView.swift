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
    
    // AddRuleViewModelクラスのインスタンス変数
    @ObservedObject var addRuleVM: AddRuleViewModel = AddRuleViewModel()
    // ContentView ⇄ AddRuleViewのシートを管理する状態変数
    @State var isShowSheet: Bool = false
    
    var body: some View {
        VStack {
            // カテゴリの選択
            // selectionで、AddRuleViewModel内のselectionCategoryとバインド
            Picker("", selection: $addRuleVM.selectionCategory) {
                // Category.allCasesで、カテゴリの全列挙値を取得し,
                // 取得した全列挙値をArrayに型変換を行って、Pickerの選択肢としている
                ForEach(Category.allCases, id: \.self) { category in
                    // rawValueの値をPickerの項目に表示
                    // カテゴリ名を表示
                    Text(category.rawValue)
                }// ForEach
            }// Picker
            .pickerStyle(SegmentedPickerStyle())
            // ルール一覧表示View
            // 引数categoryには、Pikcerで選択したカテゴリ名を渡す
            // これにより、Pickerで選択したカテゴリ名のデータのみが表示される
            DataListRowView(category: addRuleVM.selectionCategory.rawValue)
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
        }// VStackここまで
    }// bodyここまで
}// ContentViewここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
