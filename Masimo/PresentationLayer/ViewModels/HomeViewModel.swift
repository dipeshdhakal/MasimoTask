//
//  HomeViewModel.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

// Home Tab item
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
    @Published var isMockData: Bool = false
    @Published var devicesViewModel: DevicesViewModel
    @Published var nowPlayingViewModel: NowPlayingViewModel
    
    var masimoManager: MasimoManagable
    private var cancellabels = Set<AnyCancellable>()
    
    // Dependency injection
    init(masimoManager: MasimoManagable = MasimoManager()) {
        
        self.masimoManager = masimoManager
        self.devicesViewModel = DevicesViewModel(masimoManager: self.masimoManager)
        self.nowPlayingViewModel = NowPlayingViewModel(masimoManager: self.masimoManager)
        
        // observe "show mock data" setting
        $isMockData
            .dropFirst()
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { isMockData in
                self.masimoManager = isMockData ? MockMasimoManager() : MasimoManager()
                self.setViewModels()
            }
            .store(in: &cancellabels)
    }
    
    // When the data sources changes to mock data (or vise versa), we need to completely reload datasource
    func setViewModels() {
        self.devicesViewModel = DevicesViewModel(masimoManager: masimoManager)
        self.nowPlayingViewModel = NowPlayingViewModel(masimoManager: masimoManager)
        self.objectWillChange.send() // force reload views
    }
        
}
