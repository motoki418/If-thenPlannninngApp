//
//  AddRuleView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

import SwiftUI

struct AddRuleView: View {
    // フォーカスが当たっているTextFieldを判断するためのenumを作成。
    // @FocusStateの定義にもある通り、ValueはHashableである必要がある為準拠している。
    enum Field: Hashable {
        case Rule1
        case Rule2
    }// enum
    // @FocusStateとは、フォーカスに変更があった時に、
    // SwiftUIが更新する値を読み書きできるプロパティラッパー。
    // @FocusStateを付与した値をnilにすると、キーボードが閉じてくれるので、オプショナルにしている。
    // 監視結果を保存する状態変数
    @FocusState private var focusedField: Field?
    // AddRuleViewModelクラスのインスタンス変数
    @ObservedObject private var addRuleVM: AddRuleViewModel = AddRuleViewModel()
    // 非管理オブジェクトコンテキスト(ManagedObjectContext)の取得
    // 非管理オブジェクトコンテキストはデータベース操作に必要な操作を行うためのオブジェクト
    @Environment(\.managedObjectContext) private var context
    // ContentView ⇄ AddRuleViewのシートを管理する状態変数
    @Binding var isShowSheet: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    TextField("例：ご飯を食べているときは", text: $addRuleVM.inputRule1)
                        .padding()
                        .font(.title2)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.backgroundColor, lineWidth: 1))
                        .padding()
                    // 別のTextFieldに移動した際に、キーボードを出した状態を保持する為に、
                    // 各TextFieldにもonTapGUestureを追加して、focusedFieldに値を入れるようにする
                    // これにより、別のTextFieldに移った際に、
                    // キーボードを出した状態を保持する事が、出来るようになる。
                    // 第一引数には@ FocusStateの値を渡し、
                    // 第二引数には、どのfocusedFieldを指しているのか
                    // (二つのTextFieldのうち、どちらのTextFieldなのか)を渡す
                        .focused($focusedField, equals: .Rule1)
                        .onTapGesture {
                            focusedField = .Rule1
                        }
                    TextField("例：スマホやテレビを見ない", text: $addRuleVM.inputRule2)
                        .padding()
                        .font(.title2)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.backgroundColor, lineWidth: 1))
                        .padding()
                    // 今回は、TextFieldのフォーカス状態を監視したいので、
                    // TextFieldに.focusedを付与する。
                    // バインディングされたfocusedFieldにフォーカスの状態が
                    // 自動的に保存される。
                        .focused($focusedField, equals: .Rule2)
                        .onTapGesture {
                            focusedField = .Rule2
                        }
                    HStack {
                        Text("タイプ")
                            .font(.title2)
                        Picker("", selection: $addRuleVM.selectionHabit) {
                            // Habit.allCasesで、カテゴリの全列挙値を取得し,
                            // 取得した全列挙値をArrayに型変換を行って、Pickerの選択肢としている
                            ForEach(Habit.allCases, id: \.self) { habit in
                                // rawValueの値をPickerの項目に表示
                                // 列挙体Habitのデフォルト値を取得
                                Text(habit.rawValue).tag(habit)
                            }// ForEachここまで
                        }// Pickerここまで
                        .frame(width: 250, height: 80)
                        .clipped()
                        .pickerStyle(WheelPickerStyle())
                    }// HStackここまで
                    HStack {
                        Text("カテゴリ")
                            .font(.title2)
                        Picker("", selection: $addRuleVM.selectionCategory) {
                            // Category.allCasesで、カテゴリの全列挙値を取得し,
                            // 取得した全列挙値をArrayに型変換を行って、Pickerの選択肢としている
                            ForEach(Category.allCases, id: \.self) { category in
                                // rawValueの値をPickerの項目に表示
                                // 列挙体Categoryのデフォルト値を取得
                                Text(category.rawValue).tag(category)
                            }// ForEachここまで
                        }// Pickerここまで
                        .frame(width: 250, height: 170)
                        .clipped()
                        .pickerStyle(WheelPickerStyle())
                    }// HStackここまで
                    // カテゴリの選択
                    // selectionで、AddRuleViewModel内のselectionCategoryとバインド
                    Button {
                        // ルールを追加するaddRule()を呼び出す
                        addRuleVM.goodHabitaddRule(context: context)
                        isShowSheet.toggle()
                    }label: {
                        Label("If-thenルールの追加", systemImage: "plus")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.backgroundColor)
                        // 左右に余白を入れる
                            .padding(.horizontal, 20)
                        // 上下に余白を入れる
                            .padding(.vertical, 10)
                    }// if-thenルールの追加ボタンここまで
                    // 両方のTextFieldにルールが入力されていない場合は、ボタンを押せなくする
                    .disabled(addRuleVM.inputRule1 == "" || addRuleVM.inputRule2 == "" ? true : false)
                    // 両方のTextFieldにルールが入力されていない場合は、ボタンの透明度を高くする
                    .opacity(addRuleVM.inputRule1 == "" || addRuleVM.inputRule2 == "" ? 0.5 : 1)
                    Spacer()
                }// VStackここまで
            }// ScrollViewここまで
            // タップ領域が狭い為、VStackにframeとcontentShapeを追加して、タップ領域を広げる。
            .frame(width: UIScreen.main.bounds.width)
            .contentShape(RoundedRectangle(cornerRadius: 10))
            // onTapGuestureでfocuedFieldの値をnilにすると、
            // 画面をタップ時にキーボードを閉じる事が出来る。
            .onTapGesture {
                focusedField = nil
            }// .onTapGestureここまで
            .onAppear {
                // シート表示のアニメーションの関係上、遅延をさせないとキーボードが表示されないため、
                // シートが表示されてから0.6秒後にキーボードを表示する。
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    // 1つ目のTextFieldにフォーカスを当てる
                    focusedField = .Rule1
                }
            }// .onAppearここまで
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // シートを閉じる
                        isShowSheet.toggle()
                    }label: {
                        Text("戻る")
                            .foregroundColor(.white)
                    }// Cancelボタンここまで
                }// ToolbarItemここまで
            }// .toolbarここまで
            .navigationTitle("データの追加")
            .navigationBarTitleDisplayMode(.inline)
        }// NavigationViewここまで
    }// bodyここまで
}// AddRuleViewここまで
