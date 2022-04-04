//
//  if_thenPlannning_AppApp.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

import SwiftUI

@main
struct if_thenPlannning_AppApp: App {
    // PersistenceControllerの共有インスタンスの初期化
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            // 設定が必要となる時は上位のViewで設定して、下位のViewから参照する
            // 上位のViewでは以下のように.environmentを使って設定する
            // データベース操作に使うManagedObjectContextを環境変数managedObjectContextに設定し、
            // アプリケーションの各Viewで使用可能にする
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
