//
//  DataListRowView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//

import SwiftUI

struct DataListRowView: View {
    
    private var fetchRequest: FetchRequest<Item>
    
    init(category: String) {
        fetchRequest = FetchRequest<Item>(
            entity: Item.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)],
            predicate: NSPredicate(format: "category == %@", category))
    }
    
    @Environment(\.managedObjectContext) private var context
    
    var items: FetchedResults<Item> {
        fetchRequest.wrappedValue
    }
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                VStack(alignment: .leading) {
                    Text("if: \(item.content1!)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("then: \(item.content2!)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("タイプ: \(item.habit ?? "")")
                    Text("登録日: \(item.stringUpdatedAt)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .onDelete(perform: deleteRule)
        }
    }
    
    private func deleteRule(offsets: IndexSet) {
        for index in offsets {
            context.delete(items[index])
        }
        do {
            try context.save()
        } catch {
            let error = error as Error
            print("error.localizedDescription:  \(error.localizedDescription)")
        }
    }
}
