//
//  Memory.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct Memory {
    let buffer: [UInt8]
    
    init(buffer: [UInt8]) {
        self.buffer = buffer
    }
    
    init() {
        self.init(buffer: [UInt8](repeating: 0, count: 0xFFFF))
    }
    
    func read(_ at: UInt16) -> UInt8 {
        return buffer[Int(at)]
    }
}
