
import CoreData


public extension Context {

    public typealias Handler = (dao:DAO) -> Void

    public var dao:DAO {
        return DAO(context:self)
    }

    //MARK: -

    public func sync(block:Handler) {
        self.performBlockAndWait {
            block(dao:self.dao)
        }
    }

    public func async(block:Handler) {
        self.performBlock {
            block(dao:self.dao)
        }
    }

    //MARK: -

    public func startForwardingChanges(context:Context) {
        let action = Selector("mergeChangesFromContextDidSaveNotification:")
        let name = NSManagedObjectContextDidSaveNotification;
        let center = NSNotificationCenter.defaultCenter()

        center.addObserver(context, selector:action, name:name, object:self)
    }

    public func stopForwardingChanges(context:Context) {
        let name = NSManagedObjectContextDidSaveNotification;
        let center = NSNotificationCenter.defaultCenter()

        center.removeObserver(context, name:name, object:self)
    }
}
