//
//  SettingsViewModel.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var showmockData: Bool = false
    
    init(showmockData: Binding<Bool>) {
        self.showmockData = showmockData.wrappedValue
    }
    
}
