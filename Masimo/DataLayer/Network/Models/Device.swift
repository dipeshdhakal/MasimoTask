//
//  Device.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation

// MARK: - DeviceResponse
struct DeviceResponse: Codable {
    let devices: [Device]

    enum CodingKeys: String, CodingKey {
        case devices = "Devices"
    }
}

// MARK: - Device
struct Device: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}
