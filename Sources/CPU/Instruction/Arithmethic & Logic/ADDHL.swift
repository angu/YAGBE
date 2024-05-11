//
//  ADD.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct ADDHL: Instruction {
    
    let cycles: UInt16 = 2
    
    let valueProvider: (CPU) -> UInt16
    
    init(target: KeyPath<Registers, UInt16>) {
        valueProvider = { return $0.registers[keyPath: target]}
    }
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        let value = UInt16(valueProvider(cpu))
        try Utils.add(cpu: &cpu, value: value, target: \.hl)
        return cycles
    }
}
