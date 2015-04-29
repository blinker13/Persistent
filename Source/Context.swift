
import CoreData


public extension Context {

    public var dao:DAO {
        return DAO(context:self)
    }

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

    //MARK: -

    public func objectIDForURI(uri:Object.URI) -> Object.ID? {
        let coordinator = self.persistentStoreCoordinator
        return coordinator?.managedObjectIDForURIRepresentation(uri)
    }

    public func existingObjectWithURI<O:Object>(uri:Object.URI) -> O? {

        if let objectID = self.objectIDForURI(uri) {
            return self.existingObjectWithID(objectID, error:nil) as? O
        }

        return nil
    }
}
