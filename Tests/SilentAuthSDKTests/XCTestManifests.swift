import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SilentAuthSDKHTTPCommandTests.allTests),
        testCase(SilentAuthSDKParseRedirectTests.allTests),
        testCase(SilentAuthSDKCheckTests.allTests),
    ]
}
#endif
