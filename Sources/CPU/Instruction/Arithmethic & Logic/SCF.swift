//
//  SCF.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct SCF: Instruction {
    let cycles: Int = 1
    
    func execute(with cpu: inout CPU) throws {
        cpu.registers.hasCarryFlag = true
    }
}
