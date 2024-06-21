//
//  MasimoServiceTests.swift
//  MasimoTests
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import XCTest

final class MasimoServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDevicesServiceMock() async {
        let serviceMock = MasimoServiceMock()
        do {
            let deviceResponse = try await serviceMock.fetchDevices()
            XCTAssertEqual(deviceResponse.devices.count, 4)
        } catch {
            print(error.localizedDescription)
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNowPlayingServiceMock() async {
        let serviceMock = MasimoServiceMock()
        do {
            let nowPlayingResponse = try await serviceMock.fetchNowPlaying()
            XCTAssertEqual(nowPlayingResponse.nowPlaying.count, 4)
        } catch {
            print(error.localizedDescription)
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDevicesServiceMockFails() async {
        let serviceMock = MasimoServiceMock(shouldFail: true)
        do {
            _ = try await serviceMock.fetchDevices()
            XCTFail("Test should fail")
        } catch {
            XCTAssertTrue(true)
        }
    }
    
    func testNowPlayingServiceMockFails() async {
        let serviceMock = MasimoServiceMock(shouldFail: true)
        do {
            _ = try await serviceMock.fetchNowPlaying()
            XCTFail("Test should fail")
        } catch {
            XCTAssertTrue(true)
        }
    }

}

