//
//  HomeViewModel.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

enum HomeTab: String, CaseIterable, Identifiable {
    
    var id: String {
        return rawValue
    }
    
    case devices
    case nowPlaying
    case settings
    
    var title: String {
        switch self {
        case .devices:
            return "Devices"
        case .nowPlaying:
            return "Now Playing"
        case .settings:
            return "Settings"
        }
    }
    
    var iconName: String {
        switch self {
        case .devices:
            return "tabbar_icon_block_rooms"
        case .nowPlaying:
            return "tabbar_icon_now_playing"
        case .settings:
            return "tabbar_icon_settings"
        }
    }
}

class HomeViewModel: ObservableObject {
    
    @Published var tabs = HomeTab.allCases
    @Published var isMockData = false
    
    var masimoManager: MasimoManagable
    
    init(masimoManager: MasimoManagable = MasimoManager()) {
        self.masimoManager = masimoManager
        if isPreview {
            isMockData = true
        }
        if isMockData {
            self.masimoManager = MockMasimoManager()
        }
    }
        
}
