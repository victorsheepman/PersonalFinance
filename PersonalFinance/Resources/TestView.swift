//
//  TestView.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 15/11/24.
//

import SwiftUI
import SwiftData

protocol ViewModelTestable {
    init(modelContext: ModelContext)
}

struct TestView: View {
    @State private var viewModel: ViewModel
    
    var body: some View {
        Text("Esto solo es un test")
    }
}

extension TestView {
    @Observable
    final class ViewModel {
        private let modelContext: ModelContext
        private(set) var budgets = [Budget]()
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
        
        func addSamples() {
            
            let one = Budget( category: .bills, max: 100.0 , spent: 10.0, theme: .cyan)
            let two = Budget( category: .education, max: 100.0 , spent: 20.0, theme: .red)
            
            modelContext.insert(one)
            modelContext.insert(two)
            try? modelContext.save()
            fetchData()
        }
        
        func clear() {
            try? modelContext.delete(model: Budget.self)
            try? modelContext.save()
            fetchData()
        }
        
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Budget>(sortBy: [SortDescriptor(\.id)])
                budgets = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
    }
}


extension TestView.ViewModel: ViewModelTestable {
    
}
