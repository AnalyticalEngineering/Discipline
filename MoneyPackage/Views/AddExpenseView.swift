//
//  AddExpenseView.swift
//  Discipline
//
//  Created by J. DeWeese on 10/30/23.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    //PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    ///View Properties
    @State private var expenseTitle: String = ""
    @State private var expenseSubTitle: String = ""
    @State private var date: Date = .init()
    @State private var expenseAmount: CGFloat = 0
    @State private var budget: Budget?
    
    @Query(animation: .snappy) private var allBudgets: [Budget]

    
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    TextField("Magic Keyboard", text: $expenseTitle )
                }
                Section("Description") {
                    TextField("M3 Max Macbook Pro", text: $expenseSubTitle )
                }
                Section("Amount Expensed") {
                    HStack{
                        Text("$")
                            .fontWeight(.semibold)
                        TextField("0.0", value: $expenseAmount, formatter: formatter)
                            .keyboardType(.numberPad)
                    }
                }
                Section("Date") {
                    DatePicker("", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                ///Category Picker
                if !allBudgets.isEmpty {
                    HStack{
                        Text("Budget")
                        Spacer()
                        
                        Menu{
                            ForEach(allBudgets) {budget in
                                Button(budget.budgetName) {
                                    self.budget = budget
                                }
                            }
                            
                            Button("None") {
                                budget = nil
                            }
                        }label:{
                            if let budgetName = budget?.budgetName {
                                Text(budgetName)
                            }else{
                                Text("None")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            ///MARK:  TOOL BAR
            .toolbar(content: {
                ///cancel dismiss
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                ///Add
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", action: addExpense)
                        .disabled(isAddButtonDisabled)
                    }
                }
            )}
        }
        
        /// Disabling Add Button, until all data has been entered
        var isAddButtonDisabled: Bool {
            return expenseTitle.isEmpty || expenseSubTitle.isEmpty || expenseAmount == .zero
        }
        func addExpense() {
            let expense = Expense(expenseTitle: expenseTitle, expenseSubTitle: expenseSubTitle, expenseAmount: expenseAmount, date: date, budget: budget)
            context.insert(expense)
            /// Closing View, Once the Data has been Added Successfully!
            dismiss()
        }
        /// Decimal Formatter
        var formatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            return formatter
        }
    }

        #Preview {
            AddExpenseView()
        }
    
