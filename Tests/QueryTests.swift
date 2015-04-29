
import XCTest
import Persistent


class QueryTests: XCTestCase {

    func testRequire() {
        let expectation = "age == 13 AND name == \"Felix\""
        let result = Query.require(["age":13, "name":"Felix"])
        XCTAssertEqual(result.predicateFormat, expectation)
    }

    func testRequireWithNilValue() {
        let expectation = "age == 13 AND name == nil"
        let result = Query.require(["age":13, "name":nil])
        XCTAssertEqual(result.predicateFormat, expectation)
    }

	func testLessThanOperator() {
		let result:Query = "age" < 21
		
		XCTAssertEqual(result.predicateFormat, "age < 21")
		
		XCTAssertTrue(result.evaluateWithObject(["age":20]))
		XCTAssertFalse(result.evaluateWithObject(["age":21]))
		XCTAssertFalse(result.evaluateWithObject(["age":22]))
	}
	
	func testLessThanOrEqual() {
		let result:Query = "age" <= 21
		
		XCTAssertEqual(result.predicateFormat, "age <= 21")
		
		XCTAssertTrue(result.evaluateWithObject(["age":20]))
		XCTAssertTrue(result.evaluateWithObject(["age":21]))
		XCTAssertFalse(result.evaluateWithObject(["age":22]))
	}
	
	func testGreaterThanOperator() {
		let result:Query = "age" > 21
		
		XCTAssertEqual(result.predicateFormat, "age > 21")
		
		XCTAssertFalse(result.evaluateWithObject(["age":20]))
		XCTAssertFalse(result.evaluateWithObject(["age":21]))
		XCTAssertTrue(result.evaluateWithObject(["age":22]))
	}
	
	func testGreaterThanOrEqual() {
		let result:Query = "age" >= 21
		
		XCTAssertEqual(result.predicateFormat, "age >= 21")
		
		XCTAssertFalse(result.evaluateWithObject(["age":20]))
		XCTAssertTrue(result.evaluateWithObject(["age":21]))
		XCTAssertTrue(result.evaluateWithObject(["age":22]))
	}
	
	func testEqualOperator() {
		let result:Query = "age" == 21
		
		XCTAssertEqual(result.predicateFormat, "age == 21")
		
		XCTAssertFalse(result.evaluateWithObject(["age":20]))
		XCTAssertTrue(result.evaluateWithObject(["age":21]))
		XCTAssertFalse(result.evaluateWithObject(["age":22]))
		
		let nilResult:Query = "name" == nil
		XCTAssertEqual(nilResult.predicateFormat, "name == nil")
	}
	
	func testNotEqualOperator() {
		let result:Query = "age" != 21
		
		XCTAssertEqual(result.predicateFormat, "age != 21")
		
		XCTAssertTrue(result.evaluateWithObject(["age":20]))
		XCTAssertFalse(result.evaluateWithObject(["age":21]))
		XCTAssertTrue(result.evaluateWithObject(["age":22]))
		
		let nilResult:Query = "name" != nil
		XCTAssertEqual(nilResult.predicateFormat, "name != nil")
	}
	
	
	//MARK: - Compounds
	
	func testAndOperator() {
		let result:Query = "name" == "Foo" && "age" > 13
		XCTAssertEqual(result.predicateFormat, "name == \"Foo\" AND age > 13")
	}
	
	func testInfixAndOperator() {
		var result:NSPredicate = "name" == "Foo"
		result &&= "age" > 13
		
		XCTAssertEqual(result.predicateFormat, "name == \"Foo\" AND age > 13")
	}
	
	func testOrOperator() {
		let result:Query = "name" == "Foo" || "age" > 13
		XCTAssertEqual(result.predicateFormat, "name == \"Foo\" OR age > 13")
	}
	
	func testInfixOrOperator() {
		var result:Query = "name" == "Foo"
		result ||= "age" > 13
		
		XCTAssertEqual(result.predicateFormat, "name == \"Foo\" OR age > 13")
	}
	
	func testNotOperator() {
		let result:Query = !("name" == "Foo")
		XCTAssertEqual(result.predicateFormat, "NOT name == \"Foo\"")
	}
	
	func testNestedOperators() {
		let result:Query = "name" == "Foo" && ("age" < 13 || "age" > 18)
		XCTAssertEqual(result.predicateFormat, "name == \"Foo\" AND (age < 13 OR age > 18)")
	}
	
	
	//MARK: - Modifier
	
	func testAnyModifier() {
		let result = ANY("age" == 21)
		XCTAssertEqual(result.predicateFormat, "ANY age == 21")
	}
	
	func testAllModifier() {
		let result = ALL("age" == 21)
		XCTAssertEqual(result.predicateFormat, "ALL age == 21")
	}
}
