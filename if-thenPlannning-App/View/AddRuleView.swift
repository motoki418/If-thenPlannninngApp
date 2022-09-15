//
//  AddRuleView.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//

import SwiftUI

struct AddRuleView: View {
    
    enum Field: Hashable {
        case IfRule
        case ThenRule
    }
    @Environment(\.managedObjectContext) private var context
    
    @FocusState private var focusedField: Field?
    
    @ObservedObject private var addRuleVM: AddRuleViewModel = AddRuleViewModel()
    
    @Binding var isShowSheet: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    TextField("例：ご飯を食べる前に", text: $addRuleVM.IfRule)
                        .padding()
                        .font(.title2)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.backgroundColor, lineWidth: 1))
                        .padding()
                        .focused($focusedField, equals: .IfRule)
                        .onTapGesture {
                            focusedField = .IfRule
                        }
                    TextField("例：20回スクワットをする", text: $addRuleVM.ThenRule)
                        .padding()
                        .font(.title2)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.backgroundColor, lineWidth: 1))
                        .padding()
                        .focused($focusedField, equals: .ThenRule)
                        .onTapGesture {
                            focusedField = .ThenRule
                        }
                    HStack {
                        Text("カテゴリ")
                            .font(.title2)
                        Picker("", selection: $addRuleVM.selectionCategory) {
                            ForEach(Category.allCases, id: \.self) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .frame(width: 250, height: 170)
                        .clipped()
                        .pickerStyle(WheelPickerStyle())
                    }
                    
                    Button {
                        addRuleVM.CreateRule(context: context)
                        isShowSheet.toggle()
                    }label: {
                        Label("If-thenルールの追加", systemImage: "plus")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.backgroundColor)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                    .disabled(addRuleVM.IfRule == "" || addRuleVM.ThenRule == "" ? true : false)
                    .opacity(addRuleVM.IfRule == "" || addRuleVM.ThenRule == "" ? 0.5 : 1)
                    
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .contentShape(RoundedRectangle(cornerRadius: 10))
            .onTapGesture {
                focusedField = nil
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    focusedField = .IfRule
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowSheet.toggle()
                    }label: {
                        Text("戻る")
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationTitle("データの追加")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
