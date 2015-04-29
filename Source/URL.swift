
import Foundation


extension Store.URL {

	public static func defaultStoreURL() -> Store.URL {
		let bundle = NSBundle.mainBundle()
		let name = bundle.infoDictionary?[kCFBundleExecutableKey] as! NSString
		return self.storeURLWithName(name as! String)
	}
	
	public static func storeURLWithName(name:String) -> Store.URL {
		let fileManager = NSFileManager.defaultManager()
		let mainBundle = NSBundle.mainBundle()
		
		let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains:.UserDomainMask)
		let url = urls[0].URLByAppendingPathComponent(mainBundle.bundleIdentifier!, isDirectory:true) as NSURL
		return url.storeURLByAppendingName(name)
	}
	
	public func storeURLByAppendingName(name:String) -> Store.URL {
		let url = self.URLByAppendingPathComponent(name, isDirectory:false)
		return url.URLByAppendingPathExtension("sqlite")
	}
}
