//
//  GoodHabitListView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/17.
//

import SwiftUI
import CoreData

struct RuleListView: View {
    
    @ObservedObject private var addRuleVM = AddRuleViewModel()
    
    @State private var isShowSheet = false
    
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
            plusButton
        }
    }
    
    private var plusButton: some View {
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
                            .background(Color.BlueColor)
                            .clipShape(Circle())
                        Text("ルールを追加")
                            .foregroundColor(Color.BlueColor)
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

struct RuleListView_Previews: PreviewProvider {
    static var previews: some View {
        RuleListView()
    }
}
