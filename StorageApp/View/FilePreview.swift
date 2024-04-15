//
//  FilePreview.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 15/04/24.
//

import SwiftUI

struct FilePreview: View {
    let fileData: Data
    var body: some View {
        Section("Preview") {
            VStack(alignment: .center, content: {
                if let image = UIImage(data: fileData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: 200)
                        .cornerRadius(10)
                } else {
                    Text("No Preview")
                }
            })
        }
    }
}

#Preview {
    FilePreview(fileData: Data())
}
