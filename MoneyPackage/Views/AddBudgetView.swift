//
//  AddBudgetView.swift
//  Discipline
//
//  Created by J. DeWeese on 11/11/23.
//

import SwiftUI
import SwiftData


import SwiftUI
import SwiftData

struct AddBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    /// View Properties
    @State private var budgetName: String = ""
    @State private var budgetAmount: CGFloat = 0
    @State private var budget: Budget?
    /// Categories
    @Query(animation: .snappy) private var allBudgets: [Budget]
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    TextField("Rent", text: $budgetName)
                }
                Section("Amount Budgeted") {
                    TextField("$800", value: $budgetAmount, formatter: formatter)
                        .keyboardType(.numbersAndPunctuation)
                }
            }
            /// Category Picker
            if !allBudgets.isEmpty {
                HStack {
                    Text("Budget")
                    Spacer()
                    Menu {
                        ForEach(allBudgets) { budget in
                            Button(budget.budgetName) {
                                self.budget = budget
                            }
                        }
                        /// None Button
                        Button("None") {
                            budget = nil
                        }
                    } label: {
                        if let budgetName = budget?.budgetName {
                            Text(budgetName)
                        } else {
                            Text("None")
                        }
                    }
                }
            }
        }
                .navigationTitle("Add Budget")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    /// Cancel & Add Button
                    
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add", action: addBudget)
                            .disabled(isAddButtonDisabled)
                    }
                }
        }
    
        /// Disabling Add Button, until all data has been entered
        var isAddButtonDisabled: Bool {
            return budgetName.isEmpty || budgetAmount == .zero
        }
        /// Adding Expense to the Swift Data
            func addBudget() {
            let budget = Budget(budgetName: budgetName, budgetAmount: budgetAmount)
            context.insert(budget)
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
    AddBudgetView()
}
