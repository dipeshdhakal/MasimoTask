//
//  MasimoManagable.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation
import Combine

protocol MasimoManagable {
    var displayablesSubject: CurrentValueSubject<[DeviceDisplayable], Error> { get set }
    var currentDeviceSubject: CurrentValueSubject<DeviceDisplayable?, Error> { get set }
    func fetchDevices()
    func fetchNowPlaying()
    func updateState(deviceID: Int)
}