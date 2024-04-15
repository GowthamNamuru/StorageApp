//
//  DownloadFile.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 14/04/24.
//

import Foundation

struct DownloadFile: Identifiable, Codable {
    var id: String { return name }
    let name: String
    let size: Int
    let date: Date
    static let empty = DownloadFile(name: "", size: 0, date: Date())
}

struct DownloadInfo: Identifiable {
    let id: UUID
    let name: String
    var progress: Double
}
