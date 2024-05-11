//
//  SWAP.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct SWAP<T: FixedWidthInteger & UnsignedInteger>: Instruction {
    
    var cycles: UInt16 {
        return UInt16(MemoryLayout<T>.size * 2)
    }
    let target:  WritableKeyPath<Registers, T>
    
    func execute(with cpu: inout CPU) throws {
        try Utils.swap(cpu: &cpu, target: target)
    }
}
