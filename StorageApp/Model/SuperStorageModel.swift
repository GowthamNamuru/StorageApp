//
//  SuperStorageModel.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 15/04/24.
//

import Foundation

class SuperStorageModel: ObservableObject {
    @Published var downloads: [DownloadInfo] = []

    func download(file: DownloadFile) async throws -> Data? {
        guard let url = URL(string: "http://localhost:8080/files/download?\(file.name)") else {
            throw "Could not create URL"
        }
        addDownload(name: file.name)

        let (data, response) = try await URLSession.shared.data(from: url)
        
        updateDownload(name: file.name, progress: 1.0)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with an error"
        }

        return data
    }


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

extension SuperStorageModel {
    func addDownload(name: String) {
        let downloadInfo = DownloadInfo(id: UUID(), name: name, progress: 0.0)
        downloads.append(downloadInfo)
    }

    func updateDownload(name: String, progress: Double) {
        if let index = downloads.firstIndex(where: { $0.name == name }) {
            var info = downloads[index]
            info.progress = progress
            downloads[index] = info
        }
    }
}

extension String: Error {}
