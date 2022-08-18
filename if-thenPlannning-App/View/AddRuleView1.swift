//
//  AddRuleView1.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/18.
//

import SwiftUI

struct AddRuleView1: View {
    
    enum Field: Hashable {
        case Rule1
        case Rule2
    }
    
    @FocusState private var focusedField: Field?
    
    @ObservedObject private var addRuleVM: AddRuleViewModel = AddRuleViewModel()
    
    @Environment(\.managedObjectContext) private var context
    @Binding var isShowSheet: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    TextField("例：ご飯を食べているときは", text: $addRuleVM.inputRule1)
                        .padding()
                        .font(.title2)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.backgroundColor, lineWidth: 1))
                        .padding()
                        .focused($focusedField, equals: .Rule1)
                        .onTapGesture {
                            focusedField = .Rule1
                        }
                    TextField("例：スマホやテレビを見ない", text: $addRuleVM.inputRule2)
                        .padding()
                        .font(.title2)
                        .frame(height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.backgroundColor, lineWidth: 1))
                        .padding()
                        .focused($focusedField, equals: .Rule2)
                        .onTapGesture {
                            focusedField = .Rule2
                        }
                    HStack {
                        Text("タイプ")
                            .font(.title2)
                        Picker("", selection: $addRuleVM.selectionHabit) {
                            ForEach(Habit.allCases, id: \.self) { habit in
                                Text(habit.rawValue).tag(habit)
                            }
                        }
                        .frame(width: 250, height: 80)
                        .clipped()
                        .pickerStyle(WheelPickerStyle())
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
                        addRuleVM.badHabitaddRule(context: context)
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
                    .disabled(addRuleVM.inputRule1 == "" || addRuleVM.inputRule2 == "" ? true : false)
                    .opacity(addRuleVM.inputRule1 == "" || addRuleVM.inputRule2 == "" ? 0.5 : 1)
                    
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
                    focusedField = .Rule1
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
