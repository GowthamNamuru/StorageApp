//
//  FileDetails.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 14/04/24.
//

import SwiftUI

struct FileDetails: View {
    let file: DownloadFile
    let isDownloading: Bool
    @Binding var isDownloadActive: Bool

    // Button Actions
    let downloadSingleAction: () -> Void
    let downloadWithUpdatesAction: () -> Void
    let downloadMultipleAction: () -> Void

    var body: some View {
        Section {
            VStack(alignment: .leading) {
                HStack(spacing: 8) {
                    if isDownloadActive {
                        ProgressView()
                    }
                    Text(file.name)
                        .font(.title3)
                }
                .padding(.leading, 8)

                Text(sizeFormatter.string(fromByteCount: Int64(file.size)))
                    .font(.body)
                    .foregroundStyle(.indigo)
                    .padding(.leading, 8)

                HStack {
                    // Silver button action
                    Button(action: downloadSingleAction) {
                        Image(systemName: "arrow.down.app")
                        Text("Silver")
                    }
                    .tint(Color.teal)

                    Button(action: downloadWithUpdatesAction) {
                        Image(systemName: "arrow.down.app.fill")
                        Text("Gold")
                    }
                    .tint(Color.pink)

                    Button(action: downloadMultipleAction) {
                        Image(systemName: "dial.max.fill")
                        Text("Cloud 9")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.purple)
                }
                .buttonStyle(.bordered)
                .font(.subheadline)
            }

        } header: {
            Label(" Download", systemImage: "arrow.down.app")
                .font(.custom("SerreriaSobria", size: 27))
                .foregroundColor(Color.accentColor)
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    FileDetails(file: DownloadFile.empty, isDownloading: true, isDownloadActive: .constant(true), downloadSingleAction: {}, downloadWithUpdatesAction: {}, downloadMultipleAction: {})
}

let sizeFormatter: ByteCountFormatter = {
  let formatter = ByteCountFormatter()
  formatter.allowedUnits = [.useMB]
  formatter.isAdaptive = true
  return formatter
}()
