//
//  SRL.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct SRL: Instruction {
    let cycles: Int = 1
    let target: Target
    
    func execute(with cpu: inout CPU) throws {
        switch target {
        case .bit8(_):
            throw InstructionError.invalidInstruction
        case .bit16(_):
            throw InstructionError.invalidInstruction
        case .bit8Target(let bit8Target):
            try Utils.srl(cpu: &cpu, target: bit8Target.registerKeypath)
        case .bit16Target(let bit16Target):
            try Utils.srl(cpu: &cpu, target: bit16Target.registerKeypath)
        }
    }
}
