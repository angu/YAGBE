//
//  LD.swift
//
//
//  Created by Andrea Tullis on 5/6/24.
//

import Foundation

enum LDTarget {
    case a, b, c, d, e, h, l, hli
}
enum LDSource {
    case a, b, c, d, e, h, l, d8, hli
}

struct LD: Instruction {
    var cycles: UInt16 = 1
    
    let target: LDTarget
    let source: LDSource
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        Self.write(Self.read(at: source, 
                             cpu: cpu),
                   at: target,
                   cpu: &cpu)
        return cycles
    }
    
    static func read(at source: LDSource, 
                     cpu: CPU) -> any UnsignedInteger & FixedWidthInteger {
        switch source {
        case .a:
            return cpu.registers.a
        case .b:
            return cpu.registers.b
        case .c:
            return cpu.registers.c
        case .d:
            return cpu.registers.d
        case .e:
            return cpu.registers.e
        case .h:
            return cpu.registers.h
        case .l:
            return cpu.registers.l
        case .hli:
            return cpu.registers.hl
        case .d8:
            return cpu.memory.read(cpu.pc + 1)
        }
    }
    
    static func write(_ value: any UnsignedInteger & FixedWidthInteger, 
                      at target: LDTarget,
                      cpu: inout CPU) {
        switch target {
        case .a:
            cpu.memory.write(UInt8(value), at: UInt16(cpu.registers.a))
        case .b:
            cpu.memory.write(UInt8(value), at: UInt16(cpu.registers.b))
        case .c:
            cpu.memory.write(UInt8(value), at: UInt16(cpu.registers.c))
        case .d:
            cpu.memory.write(UInt8(value), at: UInt16(cpu.registers.d))
        case .e:
            cpu.memory.write(UInt8(value), at: UInt16(cpu.registers.e))
        case .h:
            cpu.memory.write(UInt8(value), at: UInt16(cpu.registers.h))
        case .l:
            cpu.memory.write(UInt8(value), at: UInt16(cpu.registers.l))
        case .hli:
            fatalError("We should handle writing a word here!")
//            cpu.memory.write(UInt8(value), at: UInt16(cpu.registers.hl))

        }
    }
}
