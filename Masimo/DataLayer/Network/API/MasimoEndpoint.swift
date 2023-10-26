//
//  MasimoEndpoint.swift
//  Masimo
//
//  Created by Dipesh Dhakal on 25/10/2023.
//

import Foundation

enum MasimoEndpoint {
    case listDevices
    case listNowPlaying
}

extension MasimoEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .listDevices:
            return "/heos_app/code_test/nowplaying.json"
        case .listNowPlaying:
            return "/heos_app/code_test/devices.json"
        }
    }

    var method: RequestMethod {
        return .get
    }

    var header: [String: String]? {
        return nil
    }
    
    var body: [String: String]? {
        return nil
    }
}
