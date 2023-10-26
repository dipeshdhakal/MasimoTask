//
//  DevicesViewModel.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

enum DeviceState: Error {
    case loading
    case failure(error: String)
    case empty
    case success
}


class DevicesViewModel: ObservableObject {
    
    @Published var devices: [DeviceData] = []
    @Published var deviceState: DeviceState = .loading
    
    var masimoManager: MasimoManagable
    private var cancellabels = Set<AnyCancellable>()
    
    init(masimoManager: MasimoManagable) {
        
        self.masimoManager = masimoManager
        self.deviceState = masimoManager.dataIsLoading ? .loading : deviceState
        self.devices = masimoManager.displayablesSubject.value
        
        masimoManager.displayablesSubject
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.deviceState = .failure(error: error.localizedDescription)
                    print(error.localizedDescription)
                }
        } receiveValue: { items in
            self.devices = items
            self.deviceState = items.isEmpty ? .empty : .success
        }
        .store(in: &cancellabels)
        masimoManager.fetchDevices()
        
    }

    func didTapOnDevice(deviceID: Int) {
        masimoManager.updateSelection(deviceID: deviceID)
    }
    
}
