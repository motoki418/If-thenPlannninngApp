//
//  AddRuleView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

import SwiftUI

struct AddRuleView: View {
    // @FocusStateを使用する
    // フォーカスが当たるTextFieldを判断するためのenumを作成
    // @FocusStateの定義にもある通り、ValueはHashableである必要がある為、準拠している
    enum Field: Hashable{
        case Rule1
        case Rule2
    }// enum
    // @FocusStateとは、フォーカスに変更があった時に、
    // SwiftUIが更新する値を読み書きできるプロパティラッパー
    // @FocusStateを付与した値をnilにするとキーボードが閉じてくれるのでオプショナルにしている
    @FocusState private var focusedField: Field?

    @ObservedObject var viewModel: ViewModel = ViewModel()
    // 非管理オブジェクトコンテキスト(ManagedObjectContext)の取得
    // 非管理オブジェクトコンテキストはデータベース操作に必要な操作を行うためのオブジェクト
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("例：歯を磨いたら", text: $viewModel.inputRule1)  .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                // 第一引数には@FocusStateの値を渡し、
                // 第二引数には今回はどのfocusedFieldを指しているのかを渡す
                    .focused($focusedField, equals: .Rule1)
                    .onTapGesture {
                        focusedField = .Rule1
                    }
                TextField("例：15分散歩をする", text: $viewModel.inputRule2)  .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($focusedField, equals: .Rule2)
                    .onTapGesture {
                        focusedField = .Rule2
                    }
                Button {
                    //ルールを追加するaddRule()を呼び出す
                    viewModel.addRule(context: context)
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
                .disabled(viewModel.inputRule1 == "" || viewModel.inputRule2 == "" ? true : false)
                // 両方のTextFieldに、ルールが入力されていない場合は、ボタンの透明度を高くする
                .opacity(viewModel.inputRule1 == "" || viewModel.inputRule2 == "" ? 0.5 : 1)
                Spacer()
            }// VStackここまで
            // onTapGuestureでfocuedFieldの値をnilにすると、
            // 画面をタップ時にキーボードを閉じる事が出来る
            .onTapGesture {
                focusedField = nil
            }
            .navigationTitle("データの追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // シートを閉じる
                        viewModel.isShowSheet.toggle()
                        print("viewModel.isShowSheet: \(viewModel.isShowSheet)")
                    }label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    }// 「Cancel」ボタンここまで
                }// ToolbarItemここまで
            }// .toolbarここまで
        }// NavigationViewここまで
        
    }// bodyここまで
}// AddRuleViewここまで
