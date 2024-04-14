//
//  FileListItem.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 14/04/24.
//

import SwiftUI

struct FileListItem: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("graphics-project-ver-1.tiff")
                Spacer()
                Image(systemName: "chevron.right")
            }
            HStack {
                Image(systemName: "photo")
                Text("3 MB")
                Text(" ")
                Text(dateFormatter.string(from: Date()))
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.bottom, 10)
            .font(.caption)
            .foregroundColor(Color.primary)
        }
    }
}

#Preview {
    FileListItem()
}

let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .short
  return formatter
}()
