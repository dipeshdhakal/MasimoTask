//
//  MasimoManagerTests.swift
//  MasimoTests
//
//  Created by Dipesh Dhakal on 26/10/2023.
//

import XCTest
import Combine
@testable import Masimo

final class MasimoManagerTests: XCTestCase {
    
    private var manager = MasimoManager(service: MasimoServiceMock())
    private var cancellabels = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager = MasimoManager(service: MasimoServiceMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialStateIsLoading() throws {
        XCTAssertEqual(manager.dataIsLoading, true)
    }
    
    func testNowPlayingIsNilInitially() throws {
        XCTAssertEqual(manager.dataIsLoading, true)
        manager.fetchNowPlaying()
        XCTAssertNil(manager.currentDeviceSubject.value)
        XCTAssertEqual(manager.dataIsLoading, false)
    }
    
    func testFetchDevicesSuccess() async {
        manager.fetchDevices()
        try! await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNil(manager.currentDeviceSubject.value)
        XCTAssertEqual(manager.displayablesSubject.value.count, 4)
    }
    
    func testSelectDeviceSuccess() async {
        manager.fetchDevices()
        try! await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNil(manager.currentDeviceSubject.value)
        XCTAssertEqual(manager.displayablesSubject.value.count, 4)
        manager.updateSelection(deviceID: 1)
        XCTAssertNotNil(manager.currentDeviceSubject.value)
        XCTAssertEqual(manager.currentDeviceSubject.value?.deviceID, 1)
    }
    
    func testUpdateDeviceStateSuccess() async {
        manager.fetchDevices()
        try! await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNil(manager.currentDeviceSubject.value)
        XCTAssertEqual(manager.displayablesSubject.value.count, 4)
        manager.updateSelection(deviceID: 1)
        XCTAssertNotNil(manager.currentDeviceSubject.value)
        XCTAssertEqual(manager.currentDeviceSubject.value?.deviceID, 1)
        XCTAssertEqual(manager.currentDeviceSubject.value?.isPlaying, false)
        manager.updateState(deviceID: 1)
        XCTAssertEqual(manager.currentDeviceSubject.value?.isPlaying, true)
    }
    
    func testFetchDevicesFailed() {
        let expectation = expectation(description: "Wait for completion")
        manager = MasimoManager(service: MasimoServiceMock(shouldFail: true))
        manager.fetchDevices()
        manager.displayablesSubject.sink { completion in
            switch completion {
            case .finished:
                XCTFail("Should not finish")
            case .failure:
                XCTAssertTrue(true)
                expectation.fulfill()
            }
        } receiveValue: { data in
            XCTFail("Should not reveive value")
        }
        .store(in: &cancellabels)
        wait(for: [expectation], timeout: 2)
    }

}
