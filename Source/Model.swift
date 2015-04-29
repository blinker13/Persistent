
import CoreData


extension Model {

    public static func all() -> Model {
        return self.mergedModelFromBundles(nil)!
    }

    public static func main() -> Model {
        let bundle = NSBundle.mainBundle()
        return self.mergedModelFromBundles([bundle])!
    }

    //MARK: -

    public convenience init?(models:Model ...) {
        self.init(byMergingModels:models)
    }
}
