//
//  AddRuleViewModel.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

import SwiftUI
import CoreData

class AddRuleViewModel: ObservableObject {
    
    @Published var selectionCategory: Category = .meal
    
    @Published var ifRule: String = ""
    
    @Published var thenRule: String = ""
        
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)]
    ) private var items: FetchedResults<Item>
    
    var isInvalid: Bool {
        ifRule.isEmpty || thenRule.isEmpty
    }
    
    func CreateNewRule(context: NSManagedObjectContext) {
        
        let newItem = Item(context: context)
        newItem.content1 = ifRule
        newItem.content2 = thenRule
        newItem.date = Date()
        newItem.category = selectionCategory.rawValue
        do {
            try context.save()
            ifRule = ""
            thenRule = ""
        } catch {
            let error = error as Error
            print("error.localizedDescription: \(error.localizedDescription)")
        }
    }
}
