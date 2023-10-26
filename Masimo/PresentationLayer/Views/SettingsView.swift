//
//  SettingsView.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    
    init(showMockData: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: SettingsViewModel(showmockData: showMockData))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Toggle(isOn: $viewModel.showmockData, label: {
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
