//
//  Extensions.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 25/10/24.
//

import Foundation

extension Date {
    // Función para formatear la fecha en el formato deseado
    func formattedAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy" // Formato deseado: "19 Aug 2024"
        return formatter.string(from: self)
    }
}

extension Array where Element: Identifiable {
    func isLast(_ element: Element) -> Bool {
        guard let lastElement = self.last else { return false }
        return element.id == lastElement.id
    }
}
