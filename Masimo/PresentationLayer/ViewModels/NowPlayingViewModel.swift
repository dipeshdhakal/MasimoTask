//
//  NowPlayingViewModel.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

class NowPlayingViewModel: ObservableObject {
    
    @Published var currentDevice: DeviceDisplayable?
    
    var masimoManager: MasimoManagable
    private var cancellabels = Set<AnyCancellable>()
    
    init(masimoManager: MasimoManagable) {
        
        self.masimoManager = masimoManager
        self.currentDevice = masimoManager.currentDeviceSubject.value
        
        masimoManager.currentDeviceSubject
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
        } receiveValue: { item in
            self.currentDevice = item
        }
        .store(in: &cancellabels)
        
        masimoManager.fetchNowPlaying()
    }
}
