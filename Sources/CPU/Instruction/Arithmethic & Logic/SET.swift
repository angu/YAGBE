//
//  SET.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct SET: Instruction {
    var cycles: UInt16 {
        switch target {
        case .bit8(_):
            return 2
        case .bit16(_):
            return 4
        case .bit8Target(_):
            return 2
        case .bit16Target(_):
            return 4
        }
    }
    
    let target: Target
    let bit: UInt16
    
    func execute(with cpu: inout CPU) throws {
        switch target {
        case .bit8(_):
            throw InstructionError.invalidInstruction
        case .bit16(_):
            throw InstructionError.invalidInstruction
        case .bit8Target(let bit8Target):
            assert(bit < 8)
            cpu.registers[keyPath: bit8Target.registerKeypath] = cpu.registers[keyPath: bit8Target.registerKeypath]
            | UInt8(1 << bit)
        case .bit16Target(let bit16Target):
            assert(bit < 16)
            cpu.registers[keyPath: bit16Target.registerKeypath] = cpu.registers[keyPath: bit16Target.registerKeypath] | UInt16(1 << bit)
        }
    }
}
