//
//  File.swift
//  
//
//  Created by Andrea Tullis on 5/6/24.
//

import Foundation

typealias InstructionParserProvider = ((CPU) -> any Instruction)
struct InstructionParser {
    let mappings: [Int: InstructionParserProvider]
    
    init(mappings: [Int : InstructionParserProvider]) {
        self.mappings = mappings
    }
    
    init() {
        // TODO: Maybe move this into functions
        let mappings: [Int : InstructionParserProvider] = [
            0x00: { _ in
                return NOOP()
            },
        ]
        
        self.init(mappings: mappings)
    }
}
