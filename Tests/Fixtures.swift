
import XCTest
import Persistent


extension XCTestCase {

	var fixtureModel:Model {
		let bundle = NSBundle(forClass:StackTests.self)
		return Model.mergedModelFromBundles([bundle])!
	}
	
	var fixtureMergedModel:Model {
		return Model.all()
	}
	
	var fixtureStackWithoutStore:Stack {
		return Stack(model:self.fixtureModel)
	}
	
	var fixtureStack:Stack {
		let stack = self.fixtureStackWithoutStore
		stack.coordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration:nil, URL:nil, options:nil, error:nil)
		return stack
	}
}
