
import CoreData


extension Object {

    public typealias URI = NSURL
    public typealias ID = NSManagedObjectID

    public static var entityName:String {
//    public static func entityName() -> String {
        let name = NSStringFromClass(self)
        let nameParts = name.componentsSeparatedByString(".")
        return nameParts.last!
    }

    public static func request(query:Query?) -> Request {
        let request = Request(entityName:self.entityName)
        request.predicate = query
        return request
    }

    public var uri:URI {
        return self.objectID.URIRepresentation()
    }
}
