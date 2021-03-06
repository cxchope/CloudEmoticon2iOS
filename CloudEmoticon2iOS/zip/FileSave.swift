import Foundation


public struct FileSave {
    
    
    public static func saveData(fileData:NSData, directory:NSSearchPathDirectory, path:String, subdirectory:String?) -> Bool
    {
        
        let savePath = buildPath(path, inDirectory: directory, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let ok:Bool = NSFileManager.defaultManager().createFileAtPath(savePath,contents:fileData, attributes:nil)
        
        // Return status of file save
        return ok
        
    }
    
    public static func saveDataToTemporaryDirectory(fileData:NSData, path:String, subdirectory:String?) -> Bool
    {
        
        let savePath = buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let ok:Bool = NSFileManager.defaultManager().createFileAtPath(savePath,contents:fileData, attributes:nil)
        
        // Return status of file save
        return ok
    }
    
    
    // string methods
    
    public static func saveString(fileString:String, directory:NSSearchPathDirectory, path:String, subdirectory:String) -> Bool {
        let savePath = buildPath(path, inDirectory: directory, subdirectory: subdirectory)
        var error:NSError?
        // Save the file and see if it was successful
        let ok:Bool
        do {
            try fileString.writeToFile(savePath, atomically:false, encoding:NSUTF8StringEncoding)
            ok = true
        } catch let error1 as NSError {
            error = error1
            ok = false
        }
        
        if (error != nil) {print(error)}
        
        // Return status of file save
        return ok
        
    }
    public static func saveStringToTemporaryDirectory(fileString:String, path:String, subdirectory:String) -> Bool {
        
        let savePath = buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        
        var error:NSError?
        // Save the file and see if it was successful
        var ok:Bool
        do {
            try fileString.writeToFile(savePath, atomically:false, encoding:NSUTF8StringEncoding)
            ok = true
        } catch let error1 as NSError {
            error = error1
            ok = false
        }
        
        if (error != nil) {
            print(error)
        }
        
        // Return status of file save
        return ok;
        
    }
    
    
    
    
    // private methods
    public static func buildPath(path:String, inDirectory directory:NSSearchPathDirectory, subdirectory:String?) -> String  {
        // Remove unnecessary slash if need
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var newSubdirectory:String?
        if let sub = subdirectory {
            newSubdirectory = FileHelper.stripSlashIfNeeded(sub)
        }
        // Create generic beginning to file save path
        var savePath:String = ""
        if let direct = FileDirectory.applicationDirectory(directory),
            path = direct.path {
                savePath = path + "/"
        }
        
        if (newSubdirectory != nil) {
            //NSCharacterSet *character= [NSCharacterSet whitespaceCharacterSet];
            //return [self stringByTrimmingCharactersInSet:character];
            //savePath.extend(newSubdirectory!)
            
            //修正:去除特殊字符
            savePath = newSubdirectory!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            //
            FileHelper.createSubDirectory(savePath)
            savePath += "/"
        }
        
        // Add requested save path
        savePath += newPath
        
        return savePath
    }
    
    public static func buildPathToTemporaryDirectory(path:String, subdirectory:String?) -> String {
        // Remove unnecessary slash if need
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var newSubdirectory:String?
        if let sub = subdirectory {
            newSubdirectory = FileHelper.stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file save path
        var savePath = ""
        if let direct = FileDirectory.applicationTemporaryDirectory(),
            path = direct.path {
                savePath = path + "/"
        }
        
        if let sub = newSubdirectory {
            savePath += sub
            FileHelper.createSubDirectory(savePath)
            savePath += "/"
        }
        
        // Add requested save path
        savePath += newPath
        return savePath
    }
    
    
    
    
}
