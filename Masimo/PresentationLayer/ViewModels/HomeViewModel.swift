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
    @Published var isMockData: Bool
    @Published var devicesViewModel: DevicesViewModel
    @Published var nowPlayingViewModel: NowPlayingViewModel
    
    var masimoManager: MasimoManagable
    private var cancellabels = Set<AnyCancellable>()
    
    init(masimoManager: MasimoManagable = MasimoManager(), isMockData: Bool = false) {
                
        if isMockData || isPreview {
            self.masimoManager = MockMasimoManager()
        } else {
            self.masimoManager = masimoManager
        }
        self.isMockData = isMockData
        self.devicesViewModel = DevicesViewModel(masimoManager: self.masimoManager)
        self.nowPlayingViewModel = NowPlayingViewModel(masimoManager: self.masimoManager)
        
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
    
    func setViewModels() {
        self.devicesViewModel = DevicesViewModel(masimoManager: masimoManager)
        self.nowPlayingViewModel = NowPlayingViewModel(masimoManager: masimoManager)
        self.objectWillChange.send() // force reload views
    }
        
}
