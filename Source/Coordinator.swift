
import CoreData


public extension Coordinator {

    public var stores:[Store] {
        return self.storeHandles.map {
            return Store(handle:$0)
        }
    }

    public func addStore(store:Store) {
        self.createDirectory(store)
        self.insertStore(store)
    }

    public func removeStore(store:Store) {
        
    }

    //MARK: - Private

    private var storeHandles:[NSPersistentStore] {
        return self.persistentStores as! [NSPersistentStore]
    }

    private func createDirectory(store:Store) {
        if let url = store.url?.URLByDeletingLastPathComponent {
            var error:NSError?
            let fileManager = NSFileManager.defaultManager()
            fileManager.createDirectoryAtURL(url, withIntermediateDirectories:true, attributes:nil, error:&error)
            assert(error == nil, "Creating the directory failed")
        }
    }

    private func insertStore(store:Store) {

        var error:NSError?
        let type = store.type.value, config = store.configuration, url = store.url, options = store.options
        let handle = self.addPersistentStoreWithType(type, configuration:config, URL:url, options:options, error:&error)
        assert(handle == nil, "Inserting the store failed")
    }
}
