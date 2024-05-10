//
//  CPU.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct CPU {
    
    var registers: Registers
    var memory: Memory
    var pc: UInt16
    var sp: UInt16
    
    init(registers: Registers, memory: Memory, pc: UInt16, sp: UInt16) {
        self.registers = registers
        self.memory = memory
        self.pc = pc
        self.sp = sp
    }
    
    init() {
        self.init(registers: Registers(), memory: Memory(), pc: 0, sp: 0)
    }
    
    mutating func execute(instruction: Instruction) throws {
        try instruction.execute(with: &self)
    }
    
    mutating func step() throws {
        let instruction = memory.read(pc)
    }
}
