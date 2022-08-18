//
//  BadHabitListView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/17.
//

import SwiftUI
import CoreData

struct BadHabitListView: View {
    
    @ObservedObject private var addRuleVM: AddRuleViewModel = AddRuleViewModel()
    
    @State private var isShowSheet: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Picker("", selection: $addRuleVM.selectionCategory) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                DataListRowView(category: addRuleVM.selectionCategory.rawValue)
            }
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        isShowSheet.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.backgroundColor)
                                .clipShape(Circle())
                            Text("ルールを追加")
                                .foregroundColor(Color.backgroundColor)
                                .padding(.bottom, 20)
                        }
                    }
                    .padding()
                    .sheet(isPresented: $isShowSheet) {
                        AddRuleView(isShowSheet: $isShowSheet)
                    }
                }
            }
        }
    }
}

struct BadHabitListView_Previews: PreviewProvider {
    static var previews: some View {
        BadHabitListView()
    }
}
