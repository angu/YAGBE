//
//  NOOP.swift
//
//
//  Created by Andrea Tullis on 5/6/24.
//

import Foundation

struct NOOP: Instruction {
    let cycles: UInt16 = 1
    
    func execute(with cpu: inout CPU) throws -> UInt16 {
        return cycles
    }
}
