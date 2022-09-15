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
    
    @Published var IfRule: String = ""
    
    @Published var ThenRule: String = ""
    
    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)]
    )
    
    private var items: FetchedResults<Item>
    
    func CreateRule(context: NSManagedObjectContext) {
        
        let newItem = Item(context: context)
        newItem.content1 = IfRule
        newItem.content2 = ThenRule
        newItem.date = Date()
        newItem.category = selectionCategory.rawValue
        do {
            try context.save()
            IfRule = ""
            ThenRule = ""
        } catch {
            let error = error as Error
            print("error.localizedDescription:  \(error.localizedDescription)")
        }
    }
}
