import Foundation

//pragma mark - strip slashes
public class FileHelper {
public static func stripSlashIfNeeded(stringWithPossibleSlash:String) -> String {
    var stringWithoutSlash:String = stringWithPossibleSlash
    // If the file name contains a slash at the beginning then we remove so that we don't end up with two
    if stringWithPossibleSlash.hasPrefix("/") {
        stringWithoutSlash = stringWithPossibleSlash.substringFromIndex(stringWithoutSlash.startIndex.advancedBy(1))
    }
    // Return the string with no slash at the beginning
    return stringWithoutSlash
}

public static func createSubDirectory(subdirectoryPath:String) -> Bool {
    var error:NSError?
    var isDir:ObjCBool=false;
    let exists:Bool = NSFileManager.defaultManager().fileExistsAtPath(subdirectoryPath, isDirectory:&isDir)
    if (exists) {
        /* a file of the same name exists, we don't care about this so won't do anything */
        if isDir {
            /* subdirectory already exists, don't create it again */
            return true;
        }
    }
    var success:Bool
    do {
        try NSFileManager.defaultManager().createDirectoryAtPath(subdirectoryPath, withIntermediateDirectories:true, attributes:nil)
        success = true
    } catch let error1 as NSError {
        error = error1
        success = false
    }
    
    if (error != nil) { print(error) }
    
    return success;
}
}