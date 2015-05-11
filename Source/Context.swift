
import CoreData


public extension Context {

    public var dao:DAO {
        return DAO(context:self)
    }

    //MARK: -

    public func sync(block:(dao:DAO) -> Bool) {
        self.performBlockAndWait {
            block(dao:self.dao)
        }
    }

    public func async(block:(dao:DAO) -> Bool) {
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
