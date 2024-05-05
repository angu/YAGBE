//
//  CPU.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct CPU {
    var registers: Registers
    
    init(registers: Registers) {
        self.registers = registers
    }
    
    init() {
        self.init(registers: Registers())
    }
    
    mutating func execute(instruction: Instruction) throws {
        try instruction.execute(with: &self)
    }
}
