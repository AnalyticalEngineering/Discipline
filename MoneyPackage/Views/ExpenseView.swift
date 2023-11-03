//
//  ExpenseView.swift
//  Discipline
//
//  Created by J. DeWeese on 10/30/23.
//

import SwiftUI
import SwiftData



struct ExpensesView: View {
    //MARK:  PROPERTIES
    /// Grouped Expenses Properties
    @Query(sort: [SortDescriptor(\Expense.date, order: .reverse)], animation: .snappy) private var allExpenses: [Expense]
    @Environment(\.modelContext) private var context
    /// Grouped Expenses
    /// This will also be used for filtering purpose
    @State private var groupedExpenses: [GroupedExpenses] = []
    @State private var originalGroupedExpenses: [GroupedExpenses] = []
    @State private var addExpense: Bool = false
    @State private var addCategory: Bool = false

    /// Search Text
    @State private var searchText: String = ""
    
    var body: some View {
        
        NavigationStack{
            List {
                ForEach($groupedExpenses)  { $group in
                    Section(group.groupTitle) {
                        ForEach(group.expenses) { expense in
                            //MARK:  EXPENSE CARD VIEW
                           ExpenseCardView(expense: expense)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button{
                                        context.delete(expense)
                                        withAnimation {
                                            group.expenses.removeAll(where: { $0.id == expense.id})
                                            if group.expenses.isEmpty {
                                                groupedExpenses.removeAll(where: { $0.id == group.id})
                                            }
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                }
            }
            .navigationTitle("Expenses")
            /// Search Bar
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: Text("Search"))
            .overlay {
                if allExpenses.isEmpty || groupedExpenses.isEmpty {
                    ContentUnavailableView {
                        Label("No Expenses", systemImage: "tray.fill")
                            .font(.title2)
                        Text("Press '+' button to add expenses.")
                            .font(.callout)
                    }
                }
            }
            /// New Expense Add Button
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addExpense.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
               //menu
            }
        }
        .onChange(of: searchText, initial: false) { oldValue, newValue in
            if !newValue.isEmpty {
                filterExpenses(newValue)
            } else {
                groupedExpenses = originalGroupedExpenses
            }
        }
        .onChange(of: allExpenses, initial: true) { oldValue, newValue in
            if newValue.count > oldValue.count || groupedExpenses.isEmpty {
                createGroupedExpenses(newValue)
            }
        }
        .sheet(isPresented: $addExpense) {
            //MARK:  ADD EXPENSE VIEW
            AddExpenseView()
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $addCategory) {
            //MARK:  ADD EXPENSE VIEW
            CategoriesView()
                .interactiveDismissDisabled()
        }
    }
    
    /// Filtering Expenses
    func filterExpenses(_ text: String) {
        Task.detached(priority: .high) {
            let query = text.lowercased()
            let filteredExpenses = originalGroupedExpenses.compactMap { group -> GroupedExpenses? in
                let expenses = group.expenses.filter({ $0.expenseTitle.lowercased().contains(query) })
                if expenses.isEmpty {
                    return nil
                }
                return .init(date: group.date, expenses: expenses)
            }
            
            await MainActor.run {
                groupedExpenses = filteredExpenses
            }
        }
    }
    
    /// Creating Grouped Expenses (Grouping By Date)
    func createGroupedExpenses(_ expenses: [Expense]) {
        Task.detached(priority: .high) {
            let groupedDict = Dictionary(grouping: expenses) { expense in
                let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: expense.date)
                
                return dateComponents
            }
            
            /// Sorting Dictionary in Descending Order
            let sortedDict = groupedDict.sorted {
                let calendar = Calendar.current
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            /// Adding to the Grouped Expenses Array
            /// UI Must be Updated on Main Thread
            await MainActor.run {
                groupedExpenses = sortedDict.compactMap({ dict in
                    let date = Calendar.current.date(from: dict.key) ?? .init()
                    return .init(date: date, expenses: dict.value)
                })
                originalGroupedExpenses = groupedExpenses
            }
        }
    }
}

#Preview {
    ExpensesView()
}
