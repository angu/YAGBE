//
//  File.swift
//  
//
//  Created by Andrea Tullis on 5/6/24.
//

import Foundation

enum JumpCondition {
  case notZero, zero, notCarry, carry, always
}

struct JUMP: Instruction {
    let cycles: UInt16 = 3
    let condition: JumpCondition
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        guard shouldExecute(cpu) else {
            return cycles
        }
        
        // Gameboy is little endian so read pc + 2 as most significant bit
        // and pc + 1 as least significant bit
        let least_significant_byte = UInt16(cpu.memory.read(cpu.pc + 1))
        let most_significant_byte = UInt16(cpu.memory.read(cpu.pc + 2))
        let newPc = (most_significant_byte << 8) | least_significant_byte
        return newPc
    }
    
    func shouldExecute(_ cpu: CPU) -> Bool {
        switch condition {
        case .notZero:
            return !cpu.registers.hasZeroFlag
        case .zero:
            return cpu.registers.hasZeroFlag
        case .notCarry:
            return !cpu.registers.hasCarryFlag
        case .carry:
            return cpu.registers.hasCarryFlag
        case .always:
            return true
        }
    }
}
