//
//  Registers.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation

enum Flag: Int {
    case zero = 7
    case subtraction = 6
    case halfCarry = 5
    case carry = 4

}

struct Registers {
    var a: UInt8
    var b: UInt8
    var c: UInt8
    var d: UInt8
    var e: UInt8
    var f: UInt8
    var h: UInt8
    var l: UInt8
    
    init(a: UInt8, b: UInt8, c: UInt8, d: UInt8, e: UInt8, f: UInt8, h: UInt8, l: UInt8) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.e = e
        self.f = f
        self.h = h
        self.l = l
    }
    
    init() {
        self.init(a: 0, b: 0, c: 0, d: 0, e: 0, f: 0, h: 0, l: 0)
    }
}

// MARK: 16 bit operations
extension Registers {
    var af: UInt16 {
        get {
            let a16 = UInt16(a) << 8
            let f16 = UInt16(f)
            return a16 | f16
        }
        
        set {
            a = UInt8((newValue & 0xFF00) >> 8)
            f = UInt8(newValue & 0xFF);
        }
    }
    
    var bc: UInt16 {
        get {
            let b16 = UInt16(b) << 8
            let c16 = UInt16(c)
            return b16 | c16
        }
        
        set {
            b = UInt8((newValue & 0xFF00) >> 8)
            c = UInt8(newValue & 0xFF);
        }
    }
    
    var de: UInt16 {
        get {
            let d16 = UInt16(d) << 8
            let e16 = UInt16(e)
            return d16 | e16
        }
        
        set {
            d = UInt8((newValue & 0xFF00) >> 8)
            e = UInt8(newValue & 0xFF);
        }
    }
    
    var hl: UInt16 {
        get {
            let h16 = UInt16(h) << 8
            let l16 = UInt16(l)
            return h16 | l16
        }
        
        set {
            h = UInt8((newValue & 0xFF00) >> 8)
            l = UInt8(newValue & 0xFF);
        }
    }
}

// MARK: Flags
extension Registers {
    
    mutating func clearFlags() {
        f = 0
    }
    
    func value(for flag: Flag) -> Bool {
        let v = UInt8(1 << flag.rawValue)
        return (f & v) == v
    }
    
    mutating func setValue(for flag: Flag, value: Bool) {
        var bitMask = UInt8(1 << flag.rawValue)
        if value {
            f = f | UInt8(bitMask)
        } else {
            bitMask = ~bitMask
            f = f & UInt8(bitMask)
        }
    }
    
    var hasZeroFlag: Bool {
        get {
            return value(for: .zero)
        }
        set {
            setValue(for: .zero, value: newValue)
        }
    }
    var hasSubtractionFlag: Bool {
        get {
            return value(for: .subtraction)
        }
        set {
            setValue(for: .subtraction, value: newValue)
        }
    }
    var hasHalfCarryFlag: Bool {
        get {
            return value(for: .halfCarry)
        }
        set {
            setValue(for: .halfCarry, value: newValue)
        }
    }
    
    var hasCarryFlag: Bool {
        get {
            return value(for: .carry)
        }
        set {
            setValue(for: .carry, value: newValue)
        }
    }
}

extension Registers: CustomStringConvertible {
    var description: String {
        return """
        8bit registers:
            a:  0b\(String(a, radix: 2)) - 0b\(String(a, radix: 16))
            b:  0b\(String(b, radix: 2)) - 0b\(String(b, radix: 16))
            c:  0b\(String(c, radix: 2)) - 0b\(String(c, radix: 16))
            d:  0b\(String(d, radix: 2)) - 0b\(String(d, radix: 16))
            e:  0b\(String(e, radix: 2)) - 0b\(String(e, radix: 16))
            f:  0b\(String(f, radix: 2)) - 0b\(String(f, radix: 16))
            h:  0b\(String(h, radix: 2)) - 0b\(String(h, radix: 16))
            l:  0b\(String(l, radix: 2)) - 0b\(String(l, radix: 16))
        """
    }
}

extension WritableKeyPath where Root == Registers, Value == UInt8 {
    static var a: WritableKeyPath<Registers, UInt8> {
        return \.a
    }
    
    static var b: WritableKeyPath<Registers, UInt8> {
        return \.b
    }
    
    static var c: WritableKeyPath<Registers, UInt8> {
        return \.c
    }
    
    static var d: WritableKeyPath<Registers, UInt8> {
        return \.d
    }
    
    static var e: WritableKeyPath<Registers, UInt8> {
        return \.e
    }
    
    static var f: WritableKeyPath<Registers, UInt8> {
        return \.f
    }
    
    static var h: WritableKeyPath<Registers, UInt8> {
        return \.h
    }
    
    static var l: WritableKeyPath<Registers, UInt8> {
        return \.l
    }
}

extension WritableKeyPath where Root == Registers, Value == UInt16 {
    static var af: WritableKeyPath<Registers, UInt16> {
        return \.af
    }
}
