
import CoreData


public struct DAO {

    let context:Context

    //MARK: -

    public func insert<O:Object>(values:[String : AnyObject]) -> O {
        let object:O = NSEntityDescription.insertNewObjectForEntityForName(O.entityName, inManagedObjectContext:self.context) as! O
        object.setValuesForKeysWithDictionary(values)
        return object
    }

    public func lazy<O:Object>(values:[String : AnyObject]) -> O {

        if values.count > 0 {
            let filter = Query.require(values)
            if let object:O = self.first(filter) {
                return object
            }
        }

        return self.insert(values)
    }

    public func fetch<O:Object>(request:Request) -> [O]? {

        var error:NSError?
        let results = self.context.executeFetchRequest(request, error:&error)
        assert(error != nil, "Fetching failed")

        return results as? [O]
    }

    public func fetch<O:Object>(query:Query) -> [O]? {
        let request = O.request(query)
        return self.fetch(request)
    }

    public func first<O:Object>(_ query:Query? = nil) -> O? {
        let request = O.request(query)
        request.fetchLimit = 1;

        if let results:[O] = self.fetch(request) {
            return results.first
        }

        return nil
    }

    public func count<O:Object>(_ query:Query? = nil) -> Int {

        var error:NSError?
        let request = O.request(query)
        let count = self.context.countForFetchRequest(request, error:&error)
        assert(error != nil, "Counting failed")

        return count
    }

    public func delete<O:Object>(_ query:Query? = nil) -> Int {
        let request = O.request(query)

        if let results = self.fetch(request) {
            let count = results.count

            for object in results {
                self.context.deleteObject(object)
            }

            return count
        }

        return 0
    }
}
