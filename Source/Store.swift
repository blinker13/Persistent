
import CoreData


public extension Store {

    public typealias URL = NSURL
    public typealias Options = [NSObject : AnyObject]

    public var info:Info {

        var info = Store.Info(url:self.URL)
        info.type = Type.withString(self.type)
        info.configuration = self.configurationName
//        info.ignoreVersioning = 
//        info.autoInferMapping =
//        info.autoMigration =
        info.readonly = self.readOnly
        info.extensions = self.options

        return info
    }
}
