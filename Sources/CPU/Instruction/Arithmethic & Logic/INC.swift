//
//  INC.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct INC: Instruction {
    let cycles: UInt16 = 1
    let target: Target
    func execute(with cpu: inout CPU) throws -> UInt16 {
        switch target {
        case .bit8(_):
            fatalError()
        case .bit16(_):
            fatalError()
        case .bit8Target(let bit8Target):
            try Utils.inc(cpu: &cpu, target: bit8Target.registerKeypath, shouldReportCarry: true)
        case .bit16Target(let bit16Target):
            try Utils.inc(cpu: &cpu, target: bit16Target.registerKeypath, shouldReportCarry: bit16Target == .hl)
        }
        return cycles
    }
}
