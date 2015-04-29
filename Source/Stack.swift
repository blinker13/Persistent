
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
}
