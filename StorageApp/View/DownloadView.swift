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

    @State var downloadTask: Task<Void, Error>?

    var body: some View {
        List {
            FileDetails(
                file: file,
                isDownloading: !model.downloads.isEmpty,
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
                    isDownloadActive = true
                    downloadTask = Task {
                        do {
                            fileData = try await model.downloadWithProgress(file: file)
                        } catch { }
                        isDownloadActive = false
                    }
                }, downloadMultipleAction: {

                }
            )
            if !model.downloads.isEmpty {
                Downloads(downloads: model.downloads)
            }

            if let fileData = fileData {
                FilePreview(fileData: fileData)
            }
        }
        .animation(.easeInOut(duration: 0.33), value: model.downloads)
        .listStyle(InsetGroupedListStyle())
        .toolbar(content: {
            Button(action: {
                model.stopDownloads = true
            }, label: {
                Text("Cancel All")
            })
            .disabled(model.downloads.isEmpty)
        })
        .onDisappear {
            fileData = nil
            model.reset()
            downloadTask = nil
        }
    }
}

#Preview {
    DownloadView(file: DownloadFile.empty).environmentObject(SuperStorageModel())
}
