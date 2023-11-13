//
//  CategoriesView.swift
//  Discipline
//
//  Created by J. DeWeese on 11/1/23.
//

import SwiftUI
import SwiftData

struct BudgetView: View {
    @Query(animation: .snappy) private var allBudgets: [Budget]
    @Environment(\.modelContext) private var context
    /// View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var addBudget: Bool = false
    @State private var budgetName: String = ""
    @State private var budgetAmount: CGFloat = 0
    /// Category Delete Request
    @State private var deleteRequest: Bool = false
    @State private var requestedBudget: Budget?
    var body: some View {
        NavigationStack {
            List {
                ForEach(allBudgets.sorted(by: {
                    ($0.expenses?.count ?? 0) > ($1.expenses?.count ?? 0)
                })) { budget in
                    DisclosureGroup {
                        if let expenses = budget.expenses, !expenses.isEmpty {
                            ForEach(expenses) { expense in
                                ExpenseCardView(expense: expense, displayTag: false)
                            }
                        } else {
                            ContentUnavailableView {
                                Label("No Expenses", systemImage: "tray.fill")
                            }
                        }
                    } label: {
                        Text(budget.budgetName)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            deleteRequest.toggle()
                            requestedBudget = budget
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("My Budgets")
            .font(.title)
            .fontWeight(.heavy)
            .navigationBarTitleDisplayMode(.inline)
            
            
            /// New Budget Add Button
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addBudget.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundStyle(.colorBlue)
                    }
                }
                ///cancel dismiss
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.primary)
                }
            }
            .sheet(isPresented: $addBudget) {
                AddBudgetView()
                budgetName = ""
            } content: {
                NavigationStack {
                    List {
                        Section("Budget Name") {
                            TextField("Enter name of budget...", text: $budgetName)
                        }
                        Section("Amount") {
                            HStack(spacing: 4) {
                                Text("$")
                                    .fontWeight(.semibold)
                                
                                TextField("0.0", value: $budgetAmount, formatter: formatter)
                                    .keyboardType(.numberPad)
                            }
                        }
                        .navigationTitle("Add Budget")
                        .navigationBarTitleDisplayMode(.inline)
                        /// Add & Cancel Button
                    }
                }
            }
        }
        .alert("If you delete a category, all the associated expenses will be deleted too.", isPresented: $deleteRequest) {
            Button(role: .destructive) {
                /// Deleting Category
                if let requestedBudget {
                    context.delete(requestedBudget)
                    self.requestedBudget = nil
                }
            } label: {
                Text("Delete")
            }
            
            Button {
                addBudget.toggle()
            } label: {
                Image(systemName: "line.3.horizontal")
                
            }
        }
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
    BudgetView()
}
