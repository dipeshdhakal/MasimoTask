//
//  Mockable.swift
//  MasimoTests
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import Foundation

enum NetworkError: Error {
    case genericError
}

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) throws -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON<T: Decodable>(filename: String, type: T.Type) throws -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            throw NetworkError.genericError
        }

        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)

            return decodedObject
        } catch {
            throw NetworkError.genericError
        }
    }
}
