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
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Budget.self, configurations: config)

        let sut = TestView.ViewModel(modelContext: container.mainContext)

        XCTAssertEqual(sut.budgets.count, 0, "There should be 0 movies when the app is first launched.")
    }

}
