//
//  ADD.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct ADD: Instruction {
    
    let cycles: Int = 1
    let target: Target
    
    func execute(with cpu: inout CPU) throws {
        switch target {
        case .bit8(let uInt8):
            try Utils.add(cpu: &cpu, value: uInt8, target: \.a)
        case .bit16(let uInt16):
            try Utils.add(cpu: &cpu, value: UInt8(uInt16 & 0xF), target: \.a)
        case .bit8Target(let bit8Target):
            try Utils.add(cpu: &cpu, value: cpu.registers[keyPath: bit8Target.registerKeypath], target: \.a)
        case .bit16Target(let bit16Target):
            let value = cpu.registers[keyPath: bit16Target.registerKeypath]
            try Utils.add(cpu: &cpu, value: UInt8(value & 0xF), target: \.a)
        }
    }
}
