
import CoreData


public struct DAO {

    let context:Context

    //MARK: -

    public func save() {
        var error:NSError?
        if !self.context.save(&error) {
            assert(error != nil, "Save failed")
        }
    }

    public func rollback() {
        self.context.rollback()
    }

    //MARK: -

    public func insert<T:Object>(values:[String : AnyObject]) -> T {
        let entity = Entity.entityForName(T.entityName, inManagedObjectContext:self.context)!
        let object:T = T(entity:entity, insertIntoManagedObjectContext:self.context)
        object.setValuesForKeysWithDictionary(values)
        return object
    }

    public func lazy<T:Object>(values:[String : AnyObject]) -> T {

        if values.count > 0 {
            let filter = Query.require(values)
            if let object:T = self.first(filter) {
                return object
            }
        }
        return self.insert(values)
    }

    public func delete<T:Object>(_ query:Query? = nil) -> Int {
        let request = T.request(query)

        if let results = self.fetch(request) {
            let count = results.count

            for object in results {
                self.context.deleteObject(object)
            }
            return count
        }
        return 0
    }

    //MARK: -

    public func fetch<T:Object>(request:Request) -> [T]? {

        var error:NSError?
        let results = self.context.executeFetchRequest(request, error:&error)
        assert(error != nil, "Fetching failed")
        return results as? [T]
    }

    public func fetch<T:Object>(query:Query) -> [T]? {
        let request = T.request(query)
        return self.fetch(request)
    }

    public func fetch<T:Object>(id:Object.ID) -> T? {
        return self.context.existingObjectWithID(id, error:nil) as? T
    }

    public func fetch<T:Object>(uri:Object.URI) -> T? {
        let coordinator = self.context.persistentStoreCoordinator

        if let id = coordinator?.managedObjectIDForURIRepresentation(uri) {
            return self.fetch(id)
        }
        return nil
    }

    public func first<T:Object>(_ query:Query? = nil) -> T? {
        let request = T.request(query)
        request.fetchLimit = 1;

        if let results:[T] = self.fetch(request) {
            return results.first
        }
        return nil
    }

    //MARK: -

    public func count<T:Object>(_ query:Query? = nil) -> Int {

        var error:NSError?
        let request = T.request(query)
        let count = self.context.countForFetchRequest(request, error:&error)
        assert(error != nil, "Counting failed")
        return count
    }
}
