//
//  SilentAuthSDKTraceCollectorTests.swift
//  
//


import XCTest
@testable import SilentAuthSDK

final class SilentAuthSDKTraceCollectorTests: XCTestCase {

    var connectionManager: CellularConnectionManager!

    static var allTests = [
        ("testTraceCollector_TimeZone", testTraceCollector_ShouldComplete_WithoutErrors),
    ]

    override func setUpWithError() throws {
           // It is called before each test method begins.
        connectionManager = CellularConnectionManager()
    }

    override func tearDownWithError() throws {
        // It is called after each test method completes.
    }

}

extension SilentAuthSDKTraceCollectorTests {
    func testTraceCollector_ShouldComplete_WithoutErrors() {
        let dateUtils = DateUtils()
        let dateFormatter = dateUtils.df
        let abv = dateFormatter.timeZone.abbreviation()
        print("Default: \(dateFormatter.timeZone.abbreviation()) vs current:\(TimeZone.current)")
        XCTAssertEqual("GMT", abv)
    }
}
