//
//  Memory.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct Memory {
    var buffer: [UInt8]
    
    init(buffer: [UInt8]) {
        self.buffer = buffer
    }
    
    init() {
        self.init(buffer: [UInt8](repeating: 0, count: 0xFFFF))
    }
    
    func read(_ address: UInt16) -> UInt8 {
        return buffer[Int(address)]
    }
    
    mutating func write(_ value: UInt8, at address: UInt16) {
        buffer[Int(address)] = value
    }
}
