//
//  ContentView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

import SwiftUI
import CoreData

struct ContentView: View {
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
        }// TabViewここまで
        // タブバーの色指定
        .accentColor(Color.backgroundColor)
    }// bodyここまで
}// ContentViewここまで

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
