//
//  ADD.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct ADD<T: UnsignedInteger & FixedWidthInteger>: Instruction {
    
    var cycles: UInt16 {
        return UInt16(MemoryLayout<T>.size)
    }
    
    let valueProvider: (CPU) -> T
    
    init(target: KeyPath<Registers, T>) {
        valueProvider = { return $0.registers[keyPath: target]}
    }
    
    init(value: T) {
        valueProvider = { _ in value }
    }
    
    func execute(with cpu: inout CPU) throws {
        let value = UInt8(valueProvider(cpu) & 0xFF)
        try Utils.add(cpu: &cpu, value: value, target: \.a)
    }
}
