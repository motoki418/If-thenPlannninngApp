//
//  Persistence.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

// CoreData 関連のコードがまとめられたファイル
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "if_thenPlannning_App")
        container.loadPersistentStores(completionHandler: { ( _, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
