//
//  MasimoManager.swift
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
    case success(data: [DeviceDisplayable])
}

enum NowPlayingState: Error {
    case loading
    case failure(error: String)
    case notSet
    case success(data: DeviceDisplayable)
}

class MasimoManager: MasimoManagable {    
    
    var service: MasimoServiceable
    var displayablesSubject = CurrentValueSubject<[DeviceDisplayable], Error>([])
    var currentDeviceSubject = CurrentValueSubject<DeviceDisplayable?, Error>(nil)
    
    init(service: MasimoServiceable = MasimoService()) {
        self.service = service
    }
    
    func fetchDevices() -> AnyPublisher<[DeviceDisplayable], Error>  {
        Task {
            do {
                displayablesSubject.send(completion: .failure(MasimoError.dataStillLoading))
                
                async let devices = try service.fetchDevices()
                async let nowPlaying = try service.fetchNowPlaying()
                
                var devicesMap = [Int: String]()
                try await devices.devices.forEach { item in
                    devicesMap[item.id] = item.name
                }
                
               let displayableDevices = try await nowPlaying.nowPlaying.map { item in
                    guard let deviceName = devicesMap[item.deviceID] else {
                        throw RequestError.unknown
                    }
                    
                    return DeviceDisplayable(deviceID: item.deviceID, deviceTitle: deviceName, artwork: item.artworkSmall, largeArtwork: item.artworkLarge, trackTitle: item.trackName, artistTitle: item.artistName)
                }
                
                stateSubject.send(displayableDevices.isEmpty ? .empty : .success)
                displayablesSubject.send(displayableDevices)
            } catch {
                stateSubject.send(.failure(error: error.localizedDescription))
                displayablesSubject.send(completion: .failure(error))
            }
        }
    }    
}

extension MasimoManagable {
    
    func fetchNowPlaying() {
        if let currentDevice = displayablesSubject.value.first(where: { $0.isPlaying }) {
            currentDeviceSubject.send(currentDevice)
        } else {
            currentDeviceSubject.send(nil)
        }
    }
    
    func updateState(deviceID: Int) {
        let displayableDevices = displayablesSubject.value
        for device in displayableDevices {
            if device.deviceID == deviceID {
                device.isPlaying.toggle()
            } else {
                device.isPlaying = false
            }
        }
        displayablesSubject.send(displayableDevices)
        fetchNowPlaying()
    }
}


class DeviceDisplayable: Identifiable {
    
    var id: Int {
        return deviceID
    }
    
    var deviceID: Int
    var deviceTitle: String
    var artwork: String
    var largeArtwork: String
    var trackTitle: String
    var artistTitle: String
    var isPlaying: Bool
    
    init(deviceID: Int, deviceTitle: String, artwork: String, largeArtwork: String, trackTitle: String, artistTitle: String, isPlaying: Bool = false) {
        self.deviceID = deviceID
        self.deviceTitle = deviceTitle
        self.artwork = artwork
        self.largeArtwork = largeArtwork
        self.trackTitle = trackTitle
        self.artistTitle = artistTitle
        self.isPlaying = isPlaying
    }
}

