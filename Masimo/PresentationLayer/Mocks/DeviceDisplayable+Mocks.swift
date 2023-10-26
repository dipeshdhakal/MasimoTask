//
//  DeviceDisplayable+Mocks.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import Foundation
import Combine

extension DeviceData {
    
    static var mockDevices: [DeviceData] {
        return [DeviceData(deviceID: 200, deviceTitle: "Bedroom Device", artwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+small.jpg", largeArtwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+large.jpg", trackTitle: "Test title", artistTitle: "Test artist"), DeviceData(deviceID: 201, deviceTitle: "Kitchen Device", artwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+small.jpg", largeArtwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Brothers+In+Arms+-+large.jpg", trackTitle: "Test title", artistTitle: "Test artist"), DeviceData(deviceID: 202, deviceTitle: "Bathroom Device", artwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Brothers+In+Arms+-+small.jpg", largeArtwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Brothers+In+Arms+-+large.jpg", trackTitle: "Test title", artistTitle: "Test artist")]
    }
    
    static var mockCurrentDevice: DeviceData {
        return DeviceData(deviceID: 0, deviceTitle: "Test Device", artwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+small.jpg", largeArtwork: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+large.jpg", trackTitle: "Test title", artistTitle: "Test artist")
    }
}

class MockMasimoManager: MasimoManagable {
    
    var dataIsLoading: Bool = false
    var displayablesSubject = CurrentValueSubject<[DeviceData], Error>([])
    var currentDeviceSubject = CurrentValueSubject<DeviceData?, Never>(nil)
    
    func fetchDevices() {
        displayablesSubject.send(DeviceData.mockDevices)
        currentDeviceSubject.send(nil)
    }
    
}
