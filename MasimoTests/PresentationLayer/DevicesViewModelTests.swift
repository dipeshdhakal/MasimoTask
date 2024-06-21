//
//  DevicesViewModelTests.swift
//  MasimoTests
//
//  Created by Dipesh Dhakal on 27/10/2023.
//

import XCTest
@testable import Masimo

final class DevicesViewModelTests: XCTestCase {

    var viewModel: DevicesViewModel!

    override func setUpWithError() throws {
        viewModel = DevicesViewModel(masimoManager: MockMasimoManager())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialStateSuccess() async throws {
        viewModel = DevicesViewModel(masimoManager: MockMasimoManager())
        XCTAssertEqual(viewModel.devices.count, 0)
        if case .loading = viewModel.deviceState {
            XCTAssertTrue(true)
        } else {
            XCTFail("wrong state")
        }
        
        try await Task.sleep(nanoseconds: 1_000_000_000) // leting to finish async task
        
        XCTAssertEqual(viewModel.devices.count, 3)
        if case .success = viewModel.deviceState {
            XCTAssertTrue(true)
        } else {
            XCTFail("wrong state")
        }
        XCTAssertEqual(viewModel.devices.first(where: { $0.deviceID == 200 })?.isSelected, false)
        XCTAssertEqual(viewModel.devices.first(where: { $0.deviceID == 201 })?.isSelected, false)
        XCTAssertEqual(viewModel.devices.first(where: { $0.deviceID == 202 })?.isSelected, false)
    }
    
    func testUpdateStateSuccess() async throws {
        viewModel = DevicesViewModel(masimoManager: MockMasimoManager())
        XCTAssertEqual(viewModel.devices.count, 0)
        try await Task.sleep(nanoseconds: 1_000_000_000) // leting to finish async task
        XCTAssertEqual(viewModel.devices.count, 3)
        viewModel.didTapOnDevice(deviceID: 200)
        try await Task.sleep(nanoseconds: 1_000_000_000) // leting to finish async task
        XCTAssertEqual(viewModel.devices.first(where: { $0.deviceID == 200 })?.isSelected, true)
        XCTAssertEqual(viewModel.devices.first(where: { $0.deviceID == 201 })?.isSelected, false)
        XCTAssertEqual(viewModel.devices.first(where: { $0.deviceID == 202 })?.isSelected, false)
        viewModel.didTapOnDevice(deviceID: 201)
        try await Task.sleep(nanoseconds: 1_000_000_000) // leting to finish async task
        XCTAssertEqual(viewModel.devices.first(where: { $0.deviceID == 200 })?.isSelected, false)
        XCTAssertEqual(viewModel.devices.first(where: { $0.deviceID == 201 })?.isSelected, true)
        XCTAssertEqual(viewModel.devices.first(where: { $0.deviceID == 202 })?.isSelected, false)
        
    }

}
