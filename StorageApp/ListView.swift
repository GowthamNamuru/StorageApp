//
//  ListView.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 14/04/24.
//

import SwiftUI

struct ListView: View {
    @State var isDisplayingDownload = false
    let model: SuperStorageModel

    @State var files: [DownloadFile] = []
    @State var lastErrorMessage = "None" {
        didSet {
            isDisplayingError = true
        }
    }

    @State var isDisplayingError = false

    var body: some View {
        NavigationStack {
            VStack {
                // The List of files available for download
                List {
                    Section {
                        if files.isEmpty {
                            ProgressView().padding()
                        }
                        ForEach(files) { file in
                            Button {
                                // action
                            } label: {
                                FileListItem()
                            }

                        }
                    } header: {
                        Label(" SuperStorage", systemImage: "externaldrive.badge.icloud")
                            .font(.custom("SerreriaSobria", size: 27))
                            .foregroundColor(Color.accentColor)
                            .padding(.bottom, 20)

                    } footer: {
                        // TODO: -  Yet to update status
                        Text("Using 37% of available space, 221 duplicate files.")
                    }

                }
                .alert("Error", isPresented: $isDisplayingError, actions: {
                    Button("Close", role: .cancel, action: {
                        isDisplayingError = false
                    })
                }, message: {
                    Text(lastErrorMessage)
                })
                .task {
                    guard files.isEmpty else { return }

                    do {
                        files = try await model.availableFiles()
                    } catch {
                        lastErrorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}

#Preview {
    ListView(model: SuperStorageModel())
}

func getMockData() -> [DownloadFile] {
    var data = [DownloadFile]()
    for i in 1...6 {
        data.append(DownloadFile(name: "name \(i)", size: 0, date: Date()))
    }
    return data
}
