//
//  POP.swift
//
//
//  Created by Andrea Tullis on 5/7/24.
//

import Foundation

struct POP: Instruction {
    let cycles: UInt16 = 1
    let target: WritableKeyPath<Registers, UInt16>
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        let lsb = cpu.memory.read(cpu.sp)
        cpu.sp = cpu.sp.addingReportingOverflow(1).partialValue
        let msb = cpu.memory.read(cpu.sp)
        cpu.registers[keyPath: target] = (UInt16(msb << 8) | UInt16(lsb))
        cpu.sp = cpu.sp.addingReportingOverflow(1).partialValue
        return cycles
    }
}
