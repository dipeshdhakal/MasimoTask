//
//  Device.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation

// MARK: - DeviceResponse
public struct DeviceResponse: Codable {
    
    public let devices: [Device]

    enum CodingKeys: String, CodingKey {
        case devices = "Devices"
    }
}

// MARK: - Device
public struct Device: Codable {
    public let id: Int
    public let name: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}
