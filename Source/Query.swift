
import CoreData


public extension Query {

    public static func require(info:[String:AnyObject?]) -> Query {
        var predicates = [NSPredicate]()

        for (key, value) in info {
            //TODO: NSNull must be handled correctly
            predicates.append(key == value)
        }

        return Compound(type:.AndPredicateType, subpredicates:predicates)
    }
}
