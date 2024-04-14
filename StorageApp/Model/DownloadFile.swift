//
//  DownloadFile.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 14/04/24.
//

import Foundation

struct DownloadFile {
    var id: String { return name }
    let name: String
    let size: Int
    let date: Date
    static let empty = DownloadFile(name: "", size: 0, date: Date())
}
