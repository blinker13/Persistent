
import CoreData


extension Comparison {

    convenience init(_ key:String, value:AnyObject, type:NSPredicateOperatorType) {

        let left = NSExpression(forKeyPath:key)
        let right = NSExpression(forConstantValue:value)
        let options = NSComparisonPredicateOptions(0)

        self.init(leftExpression:left, rightExpression:right, modifier:.DirectPredicateModifier, type:type, options:options)
    }

    convenience init(_ comparison:Comparison, modifier:NSComparisonPredicateModifier) {
        self.init(leftExpression:comparison.leftExpression, rightExpression:comparison.rightExpression, modifier:modifier, type:comparison.predicateOperatorType, options:comparison.options)
    }

    func foo() {
        let a = ANY("test" > 13)
    }
}

//MARK: -

public func < (key:String, value:AnyObject) -> Comparison {
    return Comparison(key, value:value, type:.LessThanPredicateOperatorType)
}

public func <= (key:String, value:AnyObject) -> Comparison {
    return Comparison(key, value:value, type:.LessThanOrEqualToPredicateOperatorType)
}

public func > (key:String, value:AnyObject) -> Comparison {
    return Comparison(key, value:value, type:.GreaterThanPredicateOperatorType)
}

public func >= (key:String, value:AnyObject) -> Comparison {
    return Comparison(key, value:value, type:.GreaterThanOrEqualToPredicateOperatorType)
}

public func == (key:String, value:AnyObject?) -> Comparison {
    if value != nil { return Comparison(key, value:value!, type:.EqualToPredicateOperatorType) }
    else { return Comparison(format:"%K == nil", key) }
}

public func != (key:String, value:AnyObject?) -> Comparison {
    if value != nil { return Comparison(key, value:value!, type:.NotEqualToPredicateOperatorType) }
    else { return Comparison(format:"%K != nil", key) }
}

//MARK: -

public func ALL(comparison:Comparison) -> Query {
    return Comparison(comparison, modifier:.AllPredicateModifier)
}

public func ANY(comparison:Comparison) -> Query {
    return Comparison(comparison, modifier:.AnyPredicateModifier)
}
