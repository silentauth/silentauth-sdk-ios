//
//  SilentAuthSDKHTTPCommandTests.swift
//
//


import XCTest
@testable import SilentAuthSDK
#if canImport(UIKit)
import UIKit
#endif

final class SilentAuthSDKHTTPCommandTests: XCTestCase {

    var connectionManager: CellularConnectionManager!

    static var allTests = [
        ("testCreateHTTPCommand_ShouldReturn_URL", testCreateHTTPCommand_ShouldReturn_URL),
        ("testCreateHTTPCommand_URLWithQuery_ShouldReturn_URL", testCreateHTTPCommand_URLWithQuery_ShouldReturn_URL),
        ("testCreateHTTPCommand_PathOnlyURL_ShouldReturn_Nil", testCreateHTTPCommand_PathOnlyURL_ShouldReturn_Nil),
        ("testCreateHTTPCommand_SchemeOnlyURL_ShouldReturn_Nil", testCreateHTTPCommand_SchemeOnlyURL_ShouldReturn_Nil),
        ("testCreateHTTPCommand_URLWithOutAHost_ShouldReturn_Nil", testCreateHTTPCommand_URLWithOutAHost_ShouldReturn_Nil),
        ("testHTTPStatus_ShouldReturn_200",testHTTPStatus_ShouldReturn_200),
        ("testHTTPStatus_ShouldReturn_302",testHTTPStatus_ShouldReturn_302),
        ("testHTTPStatus_ShouldReturn_0_WhenResponseIsCorrupt",testHTTPStatus_ShouldReturn_0_WhenResponseIsCorrupt)
    ]

    override func setUpWithError() throws {
           // It is called before each test method begins.
        connectionManager = CellularConnectionManager()
    }

    override func tearDownWithError() throws {
        // It is called after each test method completes.
    }

}

// MARK: - Unit Tests for createHttpCommand(..)
extension SilentAuthSDKHTTPCommandTests {

    func testCreateHTTPCommand_ShouldReturn_URL() {

        let urlString = "https://swift.org"
        let url = URL(string: urlString)!
        let expectation = httpCommand(url: url, sdkVersion: SilentAuthSdkVersion)

        let httpCommand = connectionManager.createHttpCommand(url: url, operators: nil, cookies: nil, requestId: nil)
        XCTAssertEqual(expectation, httpCommand)
    }

    func testCreateHTTPCommand_URLWithQuery_ShouldReturn_URL() {

        let urlString = "https://swift.org/index.html?search=keyword"

        let url = URL(string: urlString)!

        let expectation = httpCommand(url: url, sdkVersion: SilentAuthSdkVersion)

        let httpCommand = connectionManager.createHttpCommand(url: url, operators: nil, cookies: nil, requestId: nil)
        XCTAssertEqual(expectation, httpCommand)
    }

    func testCreateHTTPCommand_PathOnlyURL_ShouldReturn_Nil() {

        let urlString = "/"

        let url = URL(string: urlString)!

        let httpCommand = connectionManager.createHttpCommand(url: url, operators: nil, cookies: nil, requestId: nil)

        XCTAssertNil(httpCommand)
    }

    func testCreateHTTPCommand_SchemeOnlyURL_ShouldReturn_Nil() {
        let urlString = "http://"

        let url = URL(string: urlString)!

        let httpCommand = connectionManager.createHttpCommand(url: url, operators: nil, cookies: nil, requestId: nil)

        XCTAssertNil(httpCommand)
    }

    func testCreateHTTPCommand_URLWithOutAHost_ShouldReturn_Nil() {
        let connectionManager = CellularConnectionManager()

        let urlString = "/user/comments/msg?q=key"

        let url = URL(string: urlString)!

        let httpCommand = connectionManager.createHttpCommand(url: url, operators: nil, cookies: nil, requestId: nil)

        XCTAssertNil(httpCommand)
    }

}

// MARK: - Unit tests for httpStatusCode(..)
extension SilentAuthSDKHTTPCommandTests {
    func testHTTPStatus_ShouldReturn_200() {
        let response = http2xxResponse()
        let actualStatus = connectionManager.parseHttpStatusCode(response: response)
        XCTAssertEqual(200, actualStatus)
    }

    func testHTTPStatus_ShouldReturn_302() {
        let response = http3XXResponse(code: .found, url: "https://test.com")
        let actualStatus = connectionManager.parseHttpStatusCode(response: response)
        XCTAssertEqual(302, actualStatus)
    }

    func testHTTPStatus_ShouldReturn_0_WhenResponseIsCorrupt() {
        let response = corruptHTTPResponse()
        let actualStatus = connectionManager.parseHttpStatusCode(response: response)
        XCTAssertEqual(0, actualStatus)
    }
}
