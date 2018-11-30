//
//  ConstantsUtil.swift
//  IMBDMovies
//
//  Created by Hoff Henry Pereira da Silva on 30/11/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
struct ConstantsUtil {
    
    private func getPlistPath() -> String? {
        let nameOfPlistFile = "Constants.plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let documentsPath = paths.first else {
            return nil
        }
        return documentsPath.appending(nameOfPlistFile)
    }
    
    private func getFile() -> NSMutableDictionary? {
        if let filePath = getPlistPath() {
            if FileManager.default.fileExists(atPath: filePath) {
                return NSMutableDictionary(contentsOfFile: filePath)
            }
            return nil
        } else {
            return nil
        }
    }
    
    //Implementing the get values from plist file.
    
    
}
