
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

    public convenience init?(name:String, bundle:NSBundle = NSBundle.mainBundle()) {

        if let url = bundle.URLForResource(name, withExtension:"") {
            self.init(contentsOfURL:url)

        } else {
            self.init()
            return nil
        }
    }

    public convenience init?(_ models:Model ...) {
        self.init(byMergingModels:models)
    }
}
