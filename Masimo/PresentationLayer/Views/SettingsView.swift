//
//  SettingsView.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    @Binding var showMockData: Bool
    
    init(showMockData: Binding<Bool>) {
        self._showMockData = showMockData
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Toggle(isOn: $showMockData, label: {
                    Text("Show Mock Data")
                })
                Spacer()
            }
            .padding()
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView(showMockData: Binding.constant(true))
}
