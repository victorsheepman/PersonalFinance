//
//  PieChart.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import SwiftUI
import Charts

struct PieChart: View {
    var budgets: [Budget]
    
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
                angularInset: 1.5
            )
            .foregroundStyle(budget.theme.color)
        }
        .frame(width: 300, height: 300)
        .chartBackground { ChartProxy in
            GeometryReader {  geometry in
                
                if let plotFrame = ChartProxy.plotFrame{
                    let frame = geometry[plotFrame]
                    VStack {
                       
                        Text("$\(totalSpent, specifier: "%.2f")")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                        Text("of $\(totalMax, specifier: "%.2f") limit")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
                
            }
        }
        
    }
}

#Preview {
    PieChart(budgets: budgetMock)
}
