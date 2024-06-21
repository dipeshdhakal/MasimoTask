//
//  MasimoManager.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

class MasimoManager: MasimoManagable {
    
    var service: MasimoServiceable
    var dataIsLoading: Bool = true
    var displayablesSubject = CurrentValueSubject<[DeviceData], Error>([])
    var currentDeviceSubject = CurrentValueSubject<DeviceData?, Never>(nil)
    
    init(service: MasimoServiceable = MasimoService()) {
        self.service = service
    }
    
    func fetchDevices()  {
        Task {
            do {
                async let devices = try service.fetchDevices()
                async let nowPlaying = try service.fetchNowPlaying()
                
                var devicesMap = [Int: String]()
                try await devices.devices.forEach { item in
                    devicesMap[item.id] = item.name
                }
                
               let displayableDevices = try await nowPlaying.nowPlaying.map { item in
                    guard let deviceName = devicesMap[item.deviceID] else {
                        throw NetrowkError.unknown
                    }
                    
                    return DeviceData(deviceID: item.deviceID, deviceTitle: deviceName, artwork: item.artworkSmall, largeArtwork: item.artworkLarge, trackTitle: item.trackName, artistTitle: item.artistName)
                }
                dataIsLoading = false
                displayablesSubject.send(displayableDevices)
                currentDeviceSubject.send(nil)
            } catch {
                dataIsLoading = false
                displayablesSubject.send(completion: .failure(error))
            }
        }
    }
    
}

// default implementations because it has same behaviour in mock implementation as well
extension MasimoManagable {
    
    func fetchNowPlaying() {
        if let currentDevice = displayablesSubject.value.first(where: { $0.isSelected }) {
            currentDeviceSubject.send(currentDevice)
        } else {
            currentDeviceSubject.send(nil)
        }
    }
    
    func updateSelection(deviceID: Int) {
        let displayableDevices = displayablesSubject.value
        for device in displayableDevices {
            if device.deviceID == deviceID {
                device.isSelected.toggle()
            } else {
                device.isSelected = false
            }
        }
        displayablesSubject.send(displayableDevices)
        fetchNowPlaying()
    }
    
    func updateState(deviceID: Int) {
        let displayableDevices = displayablesSubject.value
        for device in displayableDevices {
            if device.deviceID == deviceID {
                device.isPlaying.toggle()
            }
        }
        displayablesSubject.send(displayableDevices)
        fetchNowPlaying()
    }
}
