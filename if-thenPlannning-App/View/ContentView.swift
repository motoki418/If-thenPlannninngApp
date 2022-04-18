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
        appearance.backgroundColor = UIColor.backgroundColor
        // タイトルの色設定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.shadowColor = UIColor(Color.backgroundColor)
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }// init()
    var body: some View {
        TabView {
            GoodHabitListView()
                .tabItem {
                    Label("身に付けたい", systemImage: "hand.thumbsup.fill")
                }

            BadHabitListView()
                .tabItem {
                    Label("やめたい", systemImage: "hand.thumbsdown.fill")
                }

            SettingView()
                .tabItem {
                    Label("設定", systemImage: "gearshape.fill")
                }
        }// TabViewここまで
        // tabItemの色指定
        .accentColor(Color.backgroundColor)
    }// bodyここまで
}// ContentViewここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
