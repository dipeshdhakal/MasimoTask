//
//  HomeViewModelTests.swift
//  MasimoTests
//
//  Created by Dipesh Dhakal on 27/10/2023.
//

import XCTest
@testable import Masimo

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        viewModel = HomeViewModel(masimoManager: MockMasimoManager())
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialSetupSuccess() throws {
        XCTAssertEqual(viewModel.tabs.count, 3)
        XCTAssertEqual(viewModel.tabs[0].title, "Devices")
        XCTAssertEqual(viewModel.tabs[1].title, "Now Playing")
        XCTAssertEqual(viewModel.tabs[2].title, "Settings")
        XCTAssertEqual(viewModel.isMockData, false)
        XCTAssertNotNil(viewModel.devicesViewModel)
        XCTAssertNotNil(viewModel.nowPlayingViewModel)
    }

}
