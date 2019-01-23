//
//  Extensions.swift
//  IMBDMovies
//
//  Created by Cast Group on 08/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

extension PlistManager where Self: RawRepresentable, Self.RawValue == String {
    func getValue() -> String {
        guard let path = Bundle.main.path(forResource: Self.plistName, ofType: "plist"),
            let configDictionary = NSDictionary(contentsOfFile: path),
            let value = configDictionary.value(forKey: rawValue) as? String else {
            return ""
        }
        return value
    }

    func setValue(value: String) {
        guard let path = Bundle.main.path(forResource: Self.plistName, ofType: "plist"),
            let configDictionary = NSMutableDictionary(contentsOfFile: path) else {
            return
        }
        configDictionary[rawValue] = value
        configDictionary.write(toFile: path, atomically: true)
    }
}

extension UserDefaults {
    enum Keys {
        static let languageChanged = "languageChanged"
        static let includeAdultValue = "includeAdultValue"
        static let queryValue = "queryValue"
        static let apiKeyParamValue = ""
        static let languageParamValue = "languageParamValue"
        static let lastPageNumberValue = "lastPageNumberValue"
        static let currentPageNumberValue = "currentPageNumberValue"
    }
}
