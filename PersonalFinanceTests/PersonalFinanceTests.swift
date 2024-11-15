//
//  PersonalFinanceTests.swift
//  PersonalFinanceTests
//
//  Created by Victor Marquez on 15/11/24.
//

import XCTest
import SwiftData
@testable import PersonalFinance

final class PersonalFinanceTests: XCTestCase {
    
    @MainActor 
    func testAppStartsEmpty() throws {
        
        let sut = try make(viewModel: TestView.ViewModel.self)

        XCTAssertEqual(sut.budgets.count, 0, "There should be 0 movies when the app is first launched.")
    }
    
    @MainActor
    func testCreatingAndClearingLeavesAppEmpty() throws {
        //GIVEN
        let sut = try make(viewModel: TestView.ViewModel.self)

        //WHEN
        sut.addSamples()
        sut.clear()

        //THEN
        XCTAssertEqual(sut.budgets.count, 0, "There should be 0 movies after deleting all data.")
    }
    
    @MainActor 
    func testCreatingSamplesWorks() throws {
        //GIVEN
        let sut = try make(viewModel: TestView.ViewModel.self)

        //WHEN
        sut.addSamples()

        //THEN
        XCTAssertEqual(sut.budgets.count, 2, "There should be 3 movies after adding sample data.")
        XCTAssertEqual(sut.budgets.first?.category.rawValue, "Bills", "The first budget category should match the sample data.")
    }

    
    @MainActor
    func make<T: ViewModelTestable>(viewModel: T.Type) throws -> T {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Budget.self, configurations: config)
        return T(modelContext: container.mainContext)
    }
}
