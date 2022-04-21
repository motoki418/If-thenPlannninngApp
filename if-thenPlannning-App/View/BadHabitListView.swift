//
//  BadHabitListView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/17.
//

import SwiftUI
import CoreData

struct BadHabitListView: View {
    // AddRuleViewModelクラスのインスタンス変数
    @ObservedObject private var addRuleVM: AddRuleViewModel = AddRuleViewModel()
    // ContentView ⇄ AddRuleViewのシートを管理する状態変数
    @State private var isShowSheet: Bool = false

    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
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
            }// VStackここまで
            // 画面右下に「＋」ボタンを配置する
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    Button {
                        isShowSheet.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.backgroundColor)
                                .clipShape(Circle())
                            // ボタンの下に余白を入れる
                            Text("ルールを追加")
                                .foregroundColor(Color.backgroundColor)
                                .padding(.bottom, 20)
                        }// VStackここまで
                    }// 「＋」ボタンここまで
                    .padding()
                    .sheet(isPresented: $isShowSheet) {
                        AddRuleView(isShowSheet: $isShowSheet)
                    }// .sheetここまで
                }// HStackここまで
            }// VStackここまで
        }// ZStackここまで
    }// bodyここまで
}// GoodHabitListViewここまで

struct BadHabitListView_Previews: PreviewProvider {
    static var previews: some View {
        BadHabitListView()
    }
}