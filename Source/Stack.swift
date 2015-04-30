
import CoreData


public class Stack {

    public let mainContext:Context
    public let coordinator:Coordinator

    public var model:Model {
        return self.coordinator.managedObjectModel
    }

    //MARK: -

    public init(model:Model = Model.main()) {
        self.coordinator = Coordinator(managedObjectModel:model)
        self.mainContext = Context(concurrencyType:.MainQueueConcurrencyType)
        self.mainContext.persistentStoreCoordinator = self.coordinator
    }

    //MARK: -

    public func addStore(info:Store.Info) -> Store {
        self.coordinator.createStoreDirectory(info)
        return self.coordinator.insertStore(info)
    }

    public func removeStore(store:Store) {
        var error:NSError?
        self.coordinator.removePersistentStore(store, error:&error)
        assert(error == nil, "Removing the store failed")
    }
}
