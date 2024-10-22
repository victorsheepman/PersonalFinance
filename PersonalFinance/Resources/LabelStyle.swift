//
//  LabelStyle.swift
//  PersonalFinance
//
//  Created by Victor Marquez on 21/10/24.
//

import Foundation
import SwiftUI


struct RightIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title // Texto a la izquierda
            configuration.icon // Ícono a la derecha
        }
    }
}

