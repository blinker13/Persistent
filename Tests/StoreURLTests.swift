
import XCTest
import Persistent


class StoreURLTests: XCTestCase {

	func testStoreURLByAppendingName() {
		let expectedPath = "foo/bar/test.sqlite"
		let startURL = Store.URL(string:"foo/bar")!
		
		let testURL = startURL.storeURLByAppendingName("test")
		
		XCTAssertEqual(testURL.absoluteString!, expectedPath)
	}
	
	func testStoreURLByAppendingNameWithEmptyURL() {
		let testURL = Store.URL().storeURLByAppendingName("test")
		XCTAssertNil(testURL.absoluteString, "An empty URL should not append the store name")
	}
}
