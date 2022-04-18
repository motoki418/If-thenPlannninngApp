//
//  SettingView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/18.
//

import SwiftUI

struct SettingView: View {

    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ExplanationView()) {
                    Text("アプリの使い方")
                }// NavigationLinkここまで
                Button {
                    openURL(URL(string: "https://twitter.com/motoki0418")!)
                }label: {
                    HStack {
                        Text("開発者にお問い合わせ")
                            .foregroundColor(Color.fontColor)
                    }
                }// お問い合わせボタンここまで
                Button {
                    openURL(URL(string: "https://apps.apple.com/jp/app/if-then%E3%83%97%E3%83%A9%E3%83%B3%E3%83%8B%E3%83%B3%E3%82%B0/id1619599235")!)
                }label: {
                    HStack {
                        Text("アプリのレビュー")
                            .foregroundColor(Color.fontColor)
                    }
                }// レビューボタンここまで
            }// Listここまで
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("設定・アプリ情報")
        }// NavigationViewここまで
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
