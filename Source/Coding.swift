
import CoreData


public extension NSCoder {

    public func encodeManagedObject<O:Object>(object:O, key:String) {
        self.encodeObject(object.uri, forKey:key)
    }
    
    public func decodeManagedObject<O:Object>(key:String, context:Context) -> O? {
        
        if let uri = self.decodeObjectForKey(key) as! O.URI? {
            return context.dao.fetch(uri)
        }
        
        return nil
    }
}
