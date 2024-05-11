//
//  SCF.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct SCF: Instruction {
    let cycles: UInt16 = 1
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        cpu.registers.hasCarryFlag = true
        return cycles
    }
}
