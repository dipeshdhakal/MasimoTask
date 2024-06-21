//
//  NowPlayingViewModel.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

class NowPlayingViewModel: ObservableObject {
    
    // Device that is currently selected from Devices screen; Nil of no selection yet
    @Published var currentDevice: DeviceData?
    
    var masimoManager: MasimoManagable
    private var cancellabels = Set<AnyCancellable>()
    
    // Dependency injection
    init(masimoManager: MasimoManagable) {
        
        self.masimoManager = masimoManager
        self.currentDevice = masimoManager.currentDeviceSubject.value
        
        // Update changes in Domain layer to update UI
        masimoManager.currentDeviceSubject
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { item in
                self.currentDevice = item
            }
            .store(in: &cancellabels)
        
        masimoManager.fetchNowPlaying()
    }
    
    // User updated play / pause state
    func updateState() {
        guard let currentDevice = currentDevice else {
            return
        }
        masimoManager.updateState(deviceID: currentDevice.deviceID)
    }
}
