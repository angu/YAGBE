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
    
    func execute(with cpu: inout CPU) throws {
        Self.write(Self.read(at: source, 
                             cpu: cpu), 
                   at: target,
                   cpu: &cpu)
    }
    
    static func read(at source: LDSource, cpu: CPU) -> any UnsignedInteger & FixedWidthInteger {
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
    
    static func write(_ value: any UnsignedInteger & FixedWidthInteger, at target: LDTarget, cpu: inout CPU) {
        switch target {
        case .a:
            cpu.registers.a = UInt8(value)
        case .b:
            cpu.registers.b = UInt8(value)
        case .c:
            cpu.registers.c = UInt8(value)
        case .d:
            cpu.registers.d = UInt8(value)
        case .e:
            cpu.registers.e = UInt8(value)
        case .h:
            cpu.registers.h = UInt8(value)
        case .l:
            cpu.registers.l = UInt8(value)
        case .hli:
            cpu.registers.hl = UInt16(value)
        }
    }
}
