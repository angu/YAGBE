//
//  InstructionParser.swift
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
            0x03: { _ in
                return INC(target: .bit16Target(.bc))
            },
            0x04: { _ in
                return INC(target: .bit8Target(.b))
            },
            0x05: { _ in
                return DEC(target: .bit8Target(.b))
            },
            0x06: { _ in
                return LD(target: .b, source: .d8)
            },
            0x07: { _ in
                return RLC(target: .bit8Target(.a))
            },
            0x40: { _ in
                return LD(target: .b, source: .b)
            }
        ]
        
        self.init(mappings: mappings)
    }
}
