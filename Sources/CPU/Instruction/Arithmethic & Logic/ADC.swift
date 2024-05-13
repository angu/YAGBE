//
//  ADC.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

/**
 Add the value in r8 plus the carry flag to A.
 Cycles: 1
 Bytes: 1
 Flags:
 Z -> Set if result is 0.
 N -> 0
 H -> Set if overflow from bit 3.
 C -> Set if overflow from bit 7.
 */
struct ADC<T: UnsignedInteger & FixedWidthInteger>: Instruction {
    
    var cycles: UInt16 {
        return UInt16(MemoryLayout<T>.size)
    }
    
    let register: KeyPath<Registers, T>
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        try Utils.add(cpu: &cpu, value: UInt8(cpu.registers[keyPath: register] & 0xFF), target: .a, carry: true)
        return cycles
    }
}
