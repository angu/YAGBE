//
//  RLA.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct RLA: Instruction {
    let cycles: Int = 1
    
    func execute(with cpu: inout CPU) throws {
        try Utils.rl(cpu: &cpu, target: \.a)
    }
}
