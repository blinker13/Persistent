
import CoreData


public extension Store {

    public enum Type {

        case SQLite
        case Memory
        case Custom(String)

        static func withString(string:String) -> Type {
            switch string {
            case NSSQLiteStoreType: return .SQLite
            case NSInMemoryStoreType: return .Memory
            default: return Type.Custom(string)
            }
        }

        var value:String {
            switch self {
            case .SQLite: return NSSQLiteStoreType
            case .Memory: return NSInMemoryStoreType
            case .Custom(let name): return name
            }
        }
    }
}
