//
//  CPL.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct CPL: Instruction {
    let cycles: Int = 1
    
    func execute(with cpu: inout CPU) throws {
        let newValue = ~cpu.registers.a
        cpu.registers.a = newValue
    }
}
