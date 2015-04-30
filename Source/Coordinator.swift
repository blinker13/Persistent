
import CoreData


public extension Coordinator {

    func createStoreDirectory(info:Store.Info) {
        if let url = info.url?.URLByDeletingLastPathComponent {
            var error:NSError?
            let fileManager = NSFileManager.defaultManager()
            fileManager.createDirectoryAtURL(url, withIntermediateDirectories:true, attributes:nil, error:&error)
            assert(error == nil, "Creating the directory failed")
        }
    }

    func insertStore(info:Store.Info) -> Store {

        var error:NSError?
        let type = info.type.value, config = info.configuration, url = info.url, options = info.options
        let store = self.addPersistentStoreWithType(type, configuration:config, URL:url, options:options, error:&error)
        assert(error == nil, "Inserting the store failed")

        return store!
    }
}
