//
//  AddRuleViewModel.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

// パブリッシャー(配信)
import SwiftUI
import CoreData

class AddRuleViewModel: ObservableObject {
    
    @Published var selectionCategory: Category = .meal

    @Published var selectionHabit: Habit = .goodHabit

    @Published var inputRule1: String = ""

    @Published var inputRule2: String = ""

    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)]
    )
    
    private var items: FetchedResults<Item>

    func goodHabitaddRule(context: NSManagedObjectContext) {
        
        let newItem = Item(context: context)
        newItem.content1 = inputRule1
        newItem.content2 = inputRule2
        newItem.date = Date()
        newItem.habit = selectionHabit.rawValue
        newItem.category = selectionCategory.rawValue
        do {
            try context.save()
            inputRule1 = ""
            inputRule2 = ""
        } catch {
            let error = error as Error
            print("error.localizedDescription:  \(error.localizedDescription)")
        }
    }
    func badHabitaddRule(context: NSManagedObjectContext) {
        let newItem = Item(context: context)
        newItem.content1 = inputRule1
        newItem.content2 = inputRule2
        newItem.date = Date()
        newItem.habit = selectionHabit.rawValue
        newItem.category = selectionCategory.rawValue
        do {
            try context.save()
            inputRule1 = ""
            inputRule2 = ""
        } catch {
            let error = error as Error
            print("error.localizedDescription:  \(error.localizedDescription)")
        }
    }
}
