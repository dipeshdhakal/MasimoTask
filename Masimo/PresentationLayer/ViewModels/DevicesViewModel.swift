//
//  DevicesViewModel.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import SwiftUI
import Combine


class DevicesViewModel: ObservableObject {
    
    @Published var devices: [DeviceDisplayable] = []
    @Published var viewState: DataState = .loading
    
    var masimoManager: MasimoManagable
    private var cancellabels = Set<AnyCancellable>()
    
    init(masimoManager: MasimoManagable) {
        
        self.masimoManager = masimoManager
        self.devices = masimoManager.displayablesSubject.value
        
        masimoManager.displayablesSubject
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
        } receiveValue: { items in
            self.devices = items
        }
        .store(in: &cancellabels)
        
        masimoManager.statePublisher
            .assign(to: &viewState, on: RunLoop.main)
                
        masimoManager.fetchDevices()

    }

    
    func didTapOnDevice(deviceID: Int) {
        masimoManager.updateState(deviceID: deviceID)
    }
    
}
