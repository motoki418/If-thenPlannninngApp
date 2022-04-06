//
//  AddRuleView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

import SwiftUI

struct AddRuleView: View {
    // ContentView　⇄ AddRuleViewのシートを管理する状態変数
    @Binding var isShowSheet: Bool
    // 入力したルール1(if)を格納
    @State private var inputRule1: String = ""
    // 入力したルール2(then)を格納
    @State private var inputRule2: String = ""
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("例：歯を磨いたら", text: $inputRule1)  .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("例：15分散歩をする", text: $inputRule2)  .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button {
                    // データの新規登録は、エンティティクラス（NSManagedObjectの派生クラス）のインスタンスを生成して実現する
                    // インスタンス生成時の引数contextにはNSManagedObjectContextを指定する
                    let newItem = Item(context: context)
                    newItem.content1 = inputRule1
                    newItem.content2 = inputRule2
                    print("newItem.content1:  \(newItem.content1)")
                    print("newItem.content2:  \(newItem.content2)")
                    newItem.date = Date()
                    do{
                        // ManagedObjectContextのsave()メソッドで、データベースを保存（コミット）する
                        // このメソッドはエラーを返す可能性がある為、tryを使ったエラーキャッチが必要
                        try context.save()
                        print("newItem:  \(newItem)")
                    }catch{
                        print(error.localizedDescription)
                    }
                    // 画面を閉じる
                    isShowSheet.toggle()
                }label: {
                    Label("If-thenルールの追加", systemImage: "plus")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.blue)
                        .cornerRadius(10)
                    // 左右に余白を入れる
                        .padding(.horizontal, 20)
                    // 上下に余白を入れる
                        .padding(.vertical, 30)
                }// 「ブックマークの追加」Buttonここまで
                // 両方のTextFieldに、ルールが入力されていない場合は、ボタンを押せなくする
                .disabled(inputRule1 == "" || inputRule2 == "" ? true : false)
                // 両方のTextFieldに、ルールが入力されていない場合は、ボタンの透明度を高くする
                .opacity(inputRule1 == "" || inputRule2 == "" ? 0.5 : 1)
                Spacer()
            }// VStackここまで
            .navigationTitle("データの追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                     
                        isShowSheet.toggle()
                    }label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    }// 「Cancel」ボタンここまで
                }// ToolbarItemここまで
            }// .toolbarここまで
        }// NavigationViewここまで
    }// bodyここまで
}// AddRuleViewここまで
