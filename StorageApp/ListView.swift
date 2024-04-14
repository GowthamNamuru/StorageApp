//
//  ListView.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 14/04/24.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List {
            Section {
                ForEach(getMockData()) { file in
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
    }
}

#Preview {
    ListView()
}

func getMockData() -> [DownloadFile] {
    var data = [DownloadFile]()
    for i in 1...6 {
        data.append(DownloadFile(name: "name \(i)", size: 0, date: Date()))
    }
    return data
}
