
import CoreData


public extension Compound {

    public convenience init(type:NSCompoundPredicateType, queries:Query ...) {
        self.init(type:type, subpredicates:queries)
    }
}

//MARK: -

public prefix func ! (query:Query) -> Query {
    return Compound(type:.NotPredicateType, queries:query)
}

public func && (left:Query, right:Query) -> Query {
    return Compound(type:.AndPredicateType, queries:left, right)
}

infix operator &&= {}
public func &&= (inout left:Query, right:Query) {
    left = Compound(type:.AndPredicateType, queries:left, right)
}

public func || (left:Query, right:Query) -> Query {
    return Compound(type:.OrPredicateType, queries:left, right)
}

infix operator ||= {}
public func ||= (inout left:Query, right:Query) {
    left = Compound(type:.OrPredicateType, queries:left, right)
}
