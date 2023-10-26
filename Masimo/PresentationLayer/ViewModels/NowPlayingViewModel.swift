//
//  NowPlayingViewModel.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

class NowPlayingViewModel: ObservableObject {
    
    @Published var currentDevice: DeviceData?
    
    var masimoManager: MasimoManagable
    private var cancellabels = Set<AnyCancellable>()
    
    init(masimoManager: MasimoManagable) {
        
        self.masimoManager = masimoManager
        self.currentDevice = masimoManager.currentDeviceSubject.value
        
        masimoManager.currentDeviceSubject
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { item in
                self.currentDevice = item
            }
            .store(in: &cancellabels)
        
        masimoManager.fetchNowPlaying()
    }
    
    func updateState() {
        guard let currentDevice = currentDevice else {
            return
        }
        masimoManager.updateState(deviceID: currentDevice.deviceID)
    }
}
