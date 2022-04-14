//
//  Persistence.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

// CoreData 関連のコードがまとめられたファイル
import CoreData

struct PersistenceController {
    // PersistenceControllerのインスタンスを生成
    static let shared = PersistenceController()
    // 定数の宣言
    let container: NSPersistentContainer
    // containerの初期化
    init() {
        // NSPersistentContainerのインスタンスを作成し、プロジェクト名をそのイニシャライザに渡す
        container = NSPersistentContainer(name: "if_thenPlannning_App")
        container.loadPersistentStores(completionHandler: { ( _, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
