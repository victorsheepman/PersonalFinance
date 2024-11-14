//
//  PieChart.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 22/10/24.
//

import SwiftUI
import Charts


struct PieChart: View {
     var budgets: [Budget] = []
    
    @State private var rawSelectedChartValue: Double? = 0
    
    var selectedBudget: Budget? {
        guard let rawSelectedChartValue else { return nil }
        
        var total = 0.0
        return budgets.first {
            total += $0.max
            return rawSelectedChartValue <= total
        }
    }

    
    var body: some View {
        Chart(budgets) { budget in
            SectorMark(
                angle: .value("Value", budget.max),
                innerRadius: .ratio(0.610),
                outerRadius: selectedBudget?.id == budget.id ? 140 : 110,
                angularInset: 1
            )
            .foregroundStyle(budget.theme.color.gradient)
            .cornerRadius(6)
            .opacity(selectedBudget?.id == budget.id ? 1.0 : 0.3)
        }
        .chartAngleSelection(value: $rawSelectedChartValue.animation(.easeInOut))
        .sensoryFeedback(.selection, trigger: selectedBudget)
        .frame(height: 240)
        .chartBackground { ChartProxy in
            GeometryReader {  geometry in
                if let plotFrame = ChartProxy.plotFrame{
                    let frame: CGRect = geometry[plotFrame]
                    if let selectedBudget {
                        BudgetInfoView (
                            budget: selectedBudget,
                            frame: frame
                        )
                    }
                }
            }
        }
        .overlay {
            if budgets.isEmpty {
                chartEmpty
            }
        }
    }
    
    var chartEmpty: some View {
        ContentUnavailableView {
            Image(systemName: "chart.pie")
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.bottom, 8)
                
            Text("No Data")
                .font(.callout.bold())
            
            Text("There is no step count data from the Health App")
                .font(.footnote)
        }
        .foregroundStyle(.secondary)
        .offset(y:-12)
    }
}

fileprivate struct BudgetInfoView: View {
    
    var budget: Budget
    var frame: CGRect
    
    var body: some View {
        VStack {
            Group {
                Text("$\(budget.spent, specifier: "%.2f")")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                Text("of $\(budget.max, specifier: "%.2f") limit")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .contentTransition(.numericText())
        }
        .position(x: frame.midX, y: frame.midY)
    }
}
