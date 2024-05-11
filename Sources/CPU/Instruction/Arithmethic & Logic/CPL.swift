//
//  CPL.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct CPL: Instruction {
    let cycles: UInt16 = 1
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        let newValue = ~cpu.registers.a
        cpu.registers.a = newValue
        return cycles
    }
}
