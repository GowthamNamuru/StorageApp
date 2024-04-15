//
//  SuperStorageModel.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 15/04/24.
//

import Foundation

class SuperStorageModel {
    func availableFiles() async throws -> [DownloadFile] {
        guard let url = URL(string: "http://localhost:8080/files/list") else {
            throw "Could not create the URL"
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with error"
        }

        guard let list = try? JSONDecoder().decode([DownloadFile].self, from: data) else {
            throw "The server response was not recognised"
        }

        return list
    }

    func status() async throws -> String {
        guard let url = URL(string: "http://localhost:8080/files/status") else {
            throw "Could not create the URL"
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with error"
        }

        return String(decoding: data, as: UTF8.self)
    }
}

extension String: Error {}
