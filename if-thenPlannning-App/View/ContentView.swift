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

    @ObservedObject private var viewModel: ViewModel = ViewModel()
    // SafariViewの表示有無を管理する状態変数
    @State private var isShowSafari = false
    
    var body: some View {
        NavigationView {
            // 背景色の上にメモの内容と＋ボタンを重ねて表示する
            ZStack {
                //SwiftUIではColor構造体を使って色を指定する
                //背景色に［Assets.xcassets］に登録したbackgroundの色を適用する
                Color.gray
                //背景色を画面下いっぱいまで広げる　画面上部は塗らない
                    .edgesIgnoringSafeArea(.bottom)
                //メモの内容と＋ボタンを縦方向にレイアウト
                //CoreDataに登録されたデータがない場合の処理
                VStack{
                    DataListRowView()
                    Spacer()
                    // 画面右下に「＋」ボタンを配置するするためにVStackとHStackで囲んで、
                    // Spacer()でボタンの上と左側にスペースを入れる
                    HStack {
                        Spacer()
                        Button {
                            viewModel.isShowSheet.toggle()
                            print("viewModel.isShowSheet: \(viewModel.isShowSheet)")
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
                        .sheet(isPresented: $viewModel.isShowSheet) {
                            AddRuleView(viewModel: viewModel)
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
