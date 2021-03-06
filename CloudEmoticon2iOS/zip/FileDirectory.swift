import Foundation

public struct FileDirectory {
    public static func applicationDirectory(directory:NSSearchPathDirectory) -> NSURL? {
        
        var appDirectory:String?
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(directory, NSSearchPathDomainMask.UserDomainMask, true);
        if paths.count > 0 {
            if let pathString = paths[0] as? String {
                appDirectory = pathString
            }
        }
        if let dD = appDirectory {
            return NSURL(string:dD)
        }
        return nil
    }
    
    public static func applicationTemporaryDirectory() -> NSURL? {
        
        if let tD:String = NSTemporaryDirectory() {
            return NSURL(string:tD)
        }
        
        return nil
        
    }
}