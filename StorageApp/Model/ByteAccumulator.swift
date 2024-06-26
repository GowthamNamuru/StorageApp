//
//  ByteAccumulator.swift
//  StorageApp
//
//  Created by Gowtham Namuru on 16/04/24.
//

import Foundation

struct ByteAccumulator: CustomStringConvertible {
    private var offset = 0
    private var counter = -1
    private let name: String
    private let size: Int
    private let chunkCount: Int
    private var bytes: [UInt8]
    var data: Data { return Data(bytes[0..<offset]) }

    init(name: String, size: Int) {
        self.name = name
        self.size = size
        self.chunkCount = max(Int(Double(size) / 20), 1)
        self.bytes = [UInt8](repeating: 0, count: size)
    }

    mutating func append(_ byte: UInt8) {
        bytes[offset] = byte
        counter += 1
        offset += 1
    }
    
    var isBatchComplete: Bool {
        return counter >= chunkCount
    }
    
    mutating func checkCompleted() -> Bool {
        defer { counter = 0 }
        return counter == 0
    }

    var progress: Double {
        Double(offset) / Double(size)
    }

    var description: String {
        "[\(name)] \(sizeFormatter.string(fromByteCount: Int64(offset)))"
    }
}
