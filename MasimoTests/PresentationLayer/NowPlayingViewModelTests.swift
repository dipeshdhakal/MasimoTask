//
//  NowPlayingViewModelTests.swift
//  MasimoTests
//
//  Created by Dipesh Dhakal on 27/10/2023.
//

import XCTest
import Combine
@testable import Masimo

final class NowPlayingViewModelTests: XCTestCase {

    var viewModel: NowPlayingViewModel!

    override func setUpWithError() throws {
        viewModel = NowPlayingViewModel(masimoManager: MockMasimoManager())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialStateSuccess() async throws {
        viewModel = NowPlayingViewModel(masimoManager: MockMasimoManager())
        viewModel.masimoManager.fetchNowPlaying()
        try await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNil(viewModel.currentDevice)
        viewModel.masimoManager.fetchDevices()
        viewModel.masimoManager.updateSelection(deviceID: 200)
        try await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNotNil(viewModel.currentDevice)
    }
    
    func testUpdateStateState() async throws {
        viewModel = NowPlayingViewModel(masimoManager: MockMasimoManager())
        try await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertNil(viewModel.currentDevice)
        viewModel.masimoManager.fetchDevices()
        viewModel.masimoManager.updateSelection(deviceID: 200)
        try await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertEqual(viewModel.currentDevice?.isPlaying, false)
        viewModel.updateState()
        try await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertEqual(viewModel.currentDevice?.isPlaying, true)
    }

}
