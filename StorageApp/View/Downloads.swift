//
//  Downloads.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 15/04/24.
//

import SwiftUI

struct Downloads: View {
    let downloads: [DownloadInfo]
    var body: some View {
        ForEach(downloads) { download in
            VStack(alignment: .leading, content: {
                Text(download.name)
                ProgressView(value: download.progress)
            })
        }
    }
}

#Preview {
    Downloads(downloads: [DownloadInfo(id: UUID(), name: "Some Name", progress: 0.5)])
}
