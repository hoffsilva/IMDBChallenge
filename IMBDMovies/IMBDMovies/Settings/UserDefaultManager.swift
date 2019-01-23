//
//  PlistManager.swift
//  IMBDMovies
//
//  Created by Cast Group on 08/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

enum UserDefaultManager {
    func get(valueFrom key: String) -> String {
        guard let valueFromKey = UserDefaults.standard.string(forKey: key) else {
            return ""
        }
        return valueFromKey
    }

    func set(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
