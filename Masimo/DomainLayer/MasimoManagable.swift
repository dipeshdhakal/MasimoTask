//
//  MasimoManagable.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

protocol MasimoManagable {
    var dataIsLoading: Bool { get set }
    var displayablesSubject: CurrentValueSubject<[DeviceData], Error> { get set }
    var currentDeviceSubject: CurrentValueSubject<DeviceData?, Never> { get set }
    func fetchDevices()
    func fetchNowPlaying()
    func updateState(deviceID: Int)
    func updateSelection(deviceID: Int)
}
