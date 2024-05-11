//
//  PUSH.swift
//
//
//  Created by Andrea Tullis on 5/7/24.
//

import Foundation

struct PUSH: Instruction {
    
    let cycles: UInt16 = 1
    let source: KeyPath<Registers, UInt16>
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        cpu.sp = cpu.sp.subtractingReportingOverflow(1).partialValue
        let upper = ((cpu.registers[keyPath: source] & 0xFF00) >> 8)
        cpu.memory.write(UInt8(upper), at: cpu.sp)
        cpu.sp = cpu.sp.subtractingReportingOverflow(1).partialValue
        let lower = (cpu.registers[keyPath: source] & 0xFF)
        cpu.memory.write(UInt8(lower), at: cpu.sp)
        return cycles
    }
}
