//
//  DeviceDisplayable+Mocks.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import Foundation
import Combine

extension DeviceDisplayable {
    
    static var mockDevices: [DeviceDisplayable] {
        return [DeviceDisplayable(deviceID: 0, deviceTitle: "Bedroom Device", artwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+small.jpg", largeArtwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+large.jpg", trackTitle: "Test title", artistTitle: "Test artist"), DeviceDisplayable(deviceID: 1, deviceTitle: "Kitchen Device", artwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+small.jpg", largeArtwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Brothers+In+Arms+-+large.jpg", trackTitle: "Test title", artistTitle: "Test artist"), DeviceDisplayable(deviceID: 2, deviceTitle: "Bathroom Device", artwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Brothers+In+Arms+-+small.jpg", largeArtwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Brothers+In+Arms+-+large.jpg", trackTitle: "Test title", artistTitle: "Test artist")]
    }
    
    static var mockCurrentDevice: DeviceDisplayable {
        return DeviceDisplayable(deviceID: 0, deviceTitle: "Test Device", artwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+small.jpg", largeArtwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+large.jpg", trackTitle: "Test title", artistTitle: "Test artist")
    }
}

class MockMasimoManager: MasimoManagable {
    
    var displayablesSubject = CurrentValueSubject<DeviceState, Never>(.loading)
    var currentDeviceSubject = CurrentValueSubject<NowPlayingState, Never>(.loading)
    
    func fetchDevices() {
        displayablesSubject.send(.success(data: DeviceDisplayable.mockDevices))
    }
    
}
