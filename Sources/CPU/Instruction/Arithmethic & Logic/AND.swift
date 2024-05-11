//
//  AND.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct AND: Instruction {
    var cycles: UInt16 = 1
    let target: Target

    func execute(with cpu: inout CPU) throws -> UInt16 {
        switch target {
        case .bit8(let uInt8):
            try Utils.and(cpu: &cpu, value: uInt8, target: \.a)
        case .bit16(_):
            fatalError()
        case .bit8Target(let bit8Target):
            try Utils.and(cpu: &cpu, value: cpu.registers[keyPath: bit8Target.registerKeypath], target: \.a)
        case .bit16Target(let bit16Target):
            let value = UInt8(cpu.registers[keyPath: bit16Target.registerKeypath] & 0xFF)
            try Utils.and(cpu: &cpu, value: value, target: \.a)

        }
        
        return cycles
    }
}
