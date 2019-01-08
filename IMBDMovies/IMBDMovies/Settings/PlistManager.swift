//
//  PlistManager.swift
//  IMBDMovies
//
//  Created by Cast Group on 08/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

protocol PlistManager {
    static var plistName: String { get }
    func getValue() -> String
    func setValue(value: String)
}
