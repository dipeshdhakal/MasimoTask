//
//  MasimoManagable.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

// Abstraction for domain layer
protocol MasimoManagable {
    // Indicates if data is still being loaded from the API
    var dataIsLoading: Bool { get set }
    // Holds current state of list of `DeviceData` or Error
    var displayablesSubject: CurrentValueSubject<[DeviceData], Error> { get set }
    // Holds selected `DeviceData`, nil otherwise
    var currentDeviceSubject: CurrentValueSubject<DeviceData?, Never> { get set }
    // Fetches devices and now playing list from API and creates list of formatted `DeviceData` and sets it to displayablesSubject
    func fetchDevices()
    // Fetches currently playing Device
    func fetchNowPlaying()
    // Updates the play / pause state of current now playing device
    func updateState(deviceID: Int)
    // Updates the selection state of Device
    func updateSelection(deviceID: Int)
}
