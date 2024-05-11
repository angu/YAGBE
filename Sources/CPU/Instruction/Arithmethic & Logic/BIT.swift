//
//  BIT.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct BIT: Instruction {
    let cycles: UInt16 = 1
    let target: Target
    let bit: UInt16
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        switch target {
        case .bit8(_):
            fatalError()
        case .bit16(let uInt16):
            fatalError()
        case .bit8Target(let bit8Target):
            assert(bit < 8)
            let flag = (cpu.registers[keyPath: bit8Target.registerKeypath] & UInt8(1 << bit)) == UInt8(1 << bit)
            cpu.registers.hasHalfCarryFlag = true
            cpu.registers.hasSubtractionFlag = false
            cpu.registers.hasZeroFlag = flag
        case .bit16Target(let bit16Target):
            assert(bit < 16)
            let flag = (cpu.registers[keyPath: bit16Target.registerKeypath] & UInt16(1 << bit)) == UInt16(1 << bit)
            cpu.registers.hasHalfCarryFlag = true
            cpu.registers.hasSubtractionFlag = false
            cpu.registers.hasZeroFlag = flag
        }
        
        return cycles
    }
}
