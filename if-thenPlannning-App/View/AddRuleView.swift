//
//  AddRuleView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

import SwiftUI

struct AddRuleView: View {
    
    @Environment(\.managedObjectContext) private var context
    
    @FocusState private var focusedField: RuleType?
    
    @ObservedObject private var addRuleVM = AddRuleViewModel()
    
    @Binding var isShowSheet: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    inputIfRuleTextField
                    
                    inputThenRuleTextFiled
                    
                    categorySelection
                    
                    addRuleButton
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .contentShape(RoundedRectangle(cornerRadius: 10))
            .onTapGesture {
                focusedField = nil
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    focusedField = .ifRule
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    closeSheetButton
                }
            }
            .navigationTitle("データの追加")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var inputIfRuleTextField: some View {
        TextField("例：ご飯を食べる前に", text: $addRuleVM.ifRule)
            .padding()
            .font(.title2)
            .frame(height: 50)
            .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.BlueColor, lineWidth: 1))
            .padding()
            .focused($focusedField, equals: .ifRule)
            .onTapGesture {
                focusedField = .ifRule
            }
    }
    
    private var inputThenRuleTextFiled: some View {
        TextField("例：20回スクワットをする", text: $addRuleVM.thenRule)
            .padding()
            .font(.title2)
            .frame(height: 50)
            .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.BlueColor, lineWidth: 1))
            .padding()
            .focused($focusedField, equals: .thenRule)
            .onTapGesture {
                focusedField = .thenRule
            }
    }
    
    private var categorySelection: some View {
        HStack {
            Text("カテゴリ")
                .font(.title2)
            Picker("", selection: $addRuleVM.selectionCategory) {
                ForEach(Category.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .frame(width: 250, height: 150)
            .clipped()
            .pickerStyle(WheelPickerStyle())
        }
    }
    
    private var addRuleButton: some View {
        Button {
            addRuleVM.CreateRule(context: context)
            isShowSheet.toggle()
        } label: {
            Label("If-thenルールの追加", systemImage: "plus")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.BlueColor)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
        }
        .disabled(addRuleVM.isInvalid ? true : false)
        .opacity(addRuleVM.isInvalid ? 0.3 : 1)
    }
    
    private var closeSheetButton: some View {
        Button {
            isShowSheet.toggle()
        } label: {
            Text("画面を閉じる")
        }
    }
}
