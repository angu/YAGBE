//
//  ADDHL.swift
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
struct ADC: Instruction {
    let cycles: UInt16 = 1
    let target: Target
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        switch target {
        case .bit8(let uInt8):
            try Utils.add(cpu: &cpu, value: uInt8, target: \.a, carry: true)
        case .bit16(let uInt16):
            try Utils.add(cpu: &cpu, value: UInt8(uInt16 & 0xF), target: \.a, carry: true)
        case .bit8Target(let bit8Target):
            try Utils.add(cpu: &cpu, value: cpu.registers[keyPath: bit8Target.registerKeypath], target: \.a, carry: true)
        case .bit16Target(let bit16Target):
            let value = cpu.registers[keyPath: bit16Target.registerKeypath]
            try Utils.add(cpu: &cpu, value: UInt8(value & 0xF), target: \.a, carry: true)
        }
        return cycles
    }
}
