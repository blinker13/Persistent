
import CoreData


public struct Store {

    public typealias URL = NSURL
    public typealias Options = [NSObject : AnyObject]

    public var url:URL?
    public var type = Type.SQLite
    public var extensions:Options?
    public var configuration:String?
    public var ignoreVersioning = false
    public var autoInferMapping = true
    public var autoMigration = true
    public var readonly = false

    //MARK: -

    public init(url:URL? = URL.defaultStoreURL()) {
        self.url = url
    }

    //MARK: - Protected

    init(handle:NSPersistentStore) {
        self.type = Type.withString(handle.type)
        self.url = handle.URL
        self.configuration = handle.configurationName
        //TODO: extract the settings
//        self.settings =
    }

    var options:Options {
        var options = Options()

        options[NSIgnorePersistentStoreVersioningOption] = self.ignoreVersioning
        options[NSMigratePersistentStoresAutomaticallyOption] = self.autoMigration
        options[NSInferMappingModelAutomaticallyOption] = self.autoInferMapping
        options[NSReadOnlyPersistentStoreOption] = self.readonly

        if let extensions = self.extensions {
            for (key, value) in extensions {
                options.updateValue(value, forKey:key)
            }
        }

        return options
    }
}
