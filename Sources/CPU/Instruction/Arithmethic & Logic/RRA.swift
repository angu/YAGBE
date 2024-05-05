//
//  RRA.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

struct RRA: Instruction {
    let cycles: Int = 1
    
    func execute(with cpu: inout CPU) throws {
        try Utils.rr(cpu: &cpu, target: \.a)
    }
}
