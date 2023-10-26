//
//  Color+Named.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import Foundation
import SwiftUI

extension Color {
    static var bgColor: Color {
        Color("BGColor")
    }
}

extension UIColor {
    static var bgColor: UIColor {
        UIColor(named: "BGColor")!
    }
}
