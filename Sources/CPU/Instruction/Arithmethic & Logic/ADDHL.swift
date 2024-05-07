//
//  ADD.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct ADDHL: Instruction {
    
    let cycles: UInt16 = 2
    let target: Target
    
    func execute(with cpu: inout CPU) throws {
        switch target {
        case .bit8(_),
                .bit16(_),
                .bit8Target(_):
            fatalError("Not implemented")
        case .bit16Target(let bit16Target):
            let value = cpu.registers[keyPath: bit16Target.registerKeypath]
            try Utils.add(cpu: &cpu, value: value, target: \.hl)
        }
    }
}
