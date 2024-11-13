//
//  PieChart.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import SwiftUI
import Charts
import SwiftData

struct PieChart: View {
    @Query(sort: \Budget.id) var budgets: [Budget]
    
    
    @State private var rawSelectedChartValue: Double? = 0
    @State private var selectedDay: Date?
    
    var selectedBudget: Budget? {
        guard let rawSelectedChartValue else { return nil }
        var total = 0.0
        return budgets.first {
            total += $0.max
            return rawSelectedChartValue <= total
        }
    }
    
    
    var totalMax: Double {
        budgets.reduce(0) { $0 + $1.max }
    }
       
     
    var totalSpent: Double {
        budgets.reduce(0) { $0 + $1.spent }
    }
    
    var body: some View {
        Chart(budgets) { budget in
            SectorMark(
                angle: .value("Value", budget.max),
                innerRadius: .ratio(0.618),
                outerRadius: .inset(10),
                angularInset: 1
            )
            .foregroundStyle(budget.theme.color)
            .opacity(selectedBudget?.id == budget.id ? 1.0 : 0.3)
        }
        .chartAngleSelection(value: $rawSelectedChartValue.animation(.easeInOut))
        .frame(width: 300, height: 300)
        .chartBackground { ChartProxy in
            GeometryReader {  geometry in
                if let plotFrame = ChartProxy.plotFrame{
                    let frame = geometry[plotFrame]
                    if let selectedBudget {
                        VStack {
                           
                            Text("$\(selectedBudget.spent, specifier: "%.2f")")
                                .font(.title2.bold())
                                .foregroundStyle(.primary)
                            Text("of $\(selectedBudget.max, specifier: "%.2f") limit")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                            
                         
                        }
                        .position(x: frame.midX, y: frame.midY)
                    }
                }
            }
        }
    }
}

#Preview {
    PieChart()
        .modelContainer(Budget.preview)
}
