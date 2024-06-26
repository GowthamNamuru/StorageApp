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

    @State var downloadTask: Task<Void, Error>? {
        didSet {
            timerTask?.cancel()

            guard isDownloadActive else { return }
            let startTime = Date().timeIntervalSince1970

            let timerSequence = Timer
                .publish(every: 1, tolerance: 1, on: .main, in: .common)
                .autoconnect()
                .map { date -> String in
                    let duration = Int(date.timeIntervalSince1970 - startTime)
                    return "\(duration)s"
                }
                .values

            timerTask = Task {
                for await duration in timerSequence {
                    self.duration = duration
                }
            }
        }
    }

    @State var timerTask: Task<Void, Error>?
    @State var duration = ""

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
                            try await SuperStorageModel
                                .$supportsPartialDowloads
                                .withValue(file.name.hasSuffix(".jpeg")) {
                                    fileData = try await model.downloadWithProgress(file: file)
                                }
                        } catch { }
                        isDownloadActive = false
                    }
                }, downloadMultipleAction: {
                    isDownloadActive = true
                    Task {
                        do {
                            fileData = try await model.multiDownloadWithProgress(file: file)
                        } catch {}
                        isDownloadActive = false
                    }
                }
            )
            if !model.downloads.isEmpty {
                Downloads(downloads: model.downloads)
            }
            if !duration.isEmpty {
                Text("Duration: \(duration)")
                    .font(.caption)
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
            downloadTask?.cancel()
        }
    }
}

#Preview {
    DownloadView(file: DownloadFile.empty).environmentObject(SuperStorageModel())
}
