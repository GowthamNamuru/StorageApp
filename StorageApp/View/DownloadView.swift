//
//  DownloadView.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 14/04/24.
//

import SwiftUI

struct DownloadView: View {
    let file: DownloadFile
    @State var isDownloadActive = false
    var body: some View {
        List {
            FileDetails(file: file, isDownloading: false, isDownloadActive: $isDownloadActive) {

            } downloadWithUpdatesAction: {

            } downloadMultipleAction: {

            }

        }
    }
}

#Preview {
    DownloadView(file: DownloadFile.empty)
}
