
import XCTest
import Persistent
import Dispatch


class ContextTests: XCTestCase {

    func testSync() {
        let subject = Context(concurrencyType:.MainQueueConcurrencyType)

        subject.sync { dao in
            XCTAssertEqual(dao, subject.dao)
        }
    }

    func testAsync() {
        let subject = Context(concurrencyType:.PrivateQueueConcurrencyType)
        let semaphore = dispatch_semaphore_create(0)

        subject.async { dao in
            XCTAssertEqual(dao, subject.dao)
            dispatch_semaphore_signal(semaphore)
        }

        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        let result = dispatch_semaphore_wait(semaphore, time)
        XCTAssertEqual(result, 0)
    }

    //MARK: -

    //TODO: Add tests for notification forwarding
}
