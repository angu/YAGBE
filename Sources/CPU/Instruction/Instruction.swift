//
//  Instruction.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

enum InstructionError: Error {
    case invalidInstruction
}

protocol Instruction {
    var cycles: Int { get }
    func execute(with cpu: inout CPU) throws
}

enum Target {
    case bit8(UInt8)
    case bit16(UInt16)
    case bit8Target(Bit8Target)
    case bit16Target(Bit16Target)
}

enum Bit16Target {
    case af, bc, de, hl
    
    var registerKeypath: WritableKeyPath<Registers, UInt16> {
        switch self {
        case .af:
            return \.af
        case .bc:
            return \.bc
        case .de:
            return \.de
        case .hl:
            return \.hl
        }
    }
}

enum Bit8Target {
    case a, b, c, d, e, h, l
    
    var registerKeypath: WritableKeyPath<Registers, UInt8> {
        switch self {
        case .a:
            return \.a
        case .b:
            return \.b
        case .c:
            return \.c
        case .d:
            return \.d
        case .e:
            return \.e
        case .h:
            return \.h
        case .l:
            return \.l
        }
    }
}
