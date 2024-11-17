//
//  Constants.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 9/11/24.
//

import Foundation
import SwiftUI

struct Constants {
    static let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
