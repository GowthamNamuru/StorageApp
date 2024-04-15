//
//  DownloadView.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 14/04/24.
//

import SwiftUI

struct DownloadView: View {
    let file: DownloadFile
    @EnvironmentObject var model: SuperStorageModel

    /// The downloaded Data
    @State var fileData: Data?

    /// Should display download activity indicatior
    @State var isDownloadActive = false

    var body: some View {
        List {
            FileDetails(
                file: file,
                isDownloading: false,
                isDownloadActive: $isDownloadActive,
                downloadSingleAction: {
                    isDownloadActive = true
                    Task {
                        do {
                            fileData = try await model.download(file: file)
                        } catch { }
                    }
                    isDownloadActive = false
                }, downloadWithUpdatesAction: {

                }, downloadMultipleAction: {

                }
            )
            if !model.downloads.isEmpty {
                Downloads(downloads: model.downloads)
            }
        }
        .toolbar(content: {
            Button(action: {
                // TODO: Yet to add button action
            }, label: {
                Text("Cancel All")
            })
            .disabled(true)
        })
    }
}

#Preview {
    DownloadView(file: DownloadFile.empty).environmentObject(SuperStorageModel())
}
