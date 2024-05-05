//
//  File.swift
//
//
//  Created by Andrea Tullis on 5/5/24.
//

import Foundation
enum Utils {
    static func add<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        value: T,
        target: WritableKeyPath<Registers, T>,
        carry: Bool = false
    ) throws {
        let (newValue, overflow) = cpu.registers[keyPath: target].addingReportingOverflow(value)
        let (carryValue, carryOverflow) = newValue.addingReportingOverflow((carry && cpu.registers.hasCarryFlag ? 1 : 0 ))
        cpu.registers[keyPath: target] = carryValue
        
        // Registers update
        cpu.registers.hasZeroFlag = newValue == 0
        cpu.registers.hasCarryFlag = (overflow || carryOverflow)
        cpu.registers.hasSubtractionFlag = false
        
        // Half Carry is set if adding the lower nibbles of the value and register A
        // together result in a value bigger than 0xF. If the result is larger than 0xF
        // than the addition caused a carry from the lower nibble to the upper nibble.
        let push = MemoryLayout<T>.size
        let mask: T = push > 1 ? 0xFF : 0xF
        cpu.registers.hasHalfCarryFlag = (cpu.registers[keyPath: target] & mask) + (value & mask) > mask;
    }
    
    @discardableResult
    static func cp<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        value: T,
        target: WritableKeyPath<Registers, T>,
        carry: Bool = false
    ) throws -> T {
        let (newValue, overflow) = cpu.registers[keyPath: target].subtractingReportingOverflow(value)
        let (carryValue, carryOverflow) = newValue.addingReportingOverflow((carry && cpu.registers.hasCarryFlag ? 1 : 0 ))
        
        // Registers update
        cpu.registers.hasZeroFlag = newValue == 0
        cpu.registers.hasCarryFlag = (overflow || carryOverflow)
        cpu.registers.hasSubtractionFlag = true
        
        // Half Carry is set if adding the lower nibbles of the value and register A
        // together result in a value bigger than 0xF. If the result is larger than 0xF
        // than the addition caused a carry from the lower nibble to the upper nibble.
        let push = MemoryLayout<T>.size
        let mask: T = push > 1 ? 0xFF : 0xF
        cpu.registers.hasHalfCarryFlag = (cpu.registers[keyPath: target] & mask) < (value & mask);
        return carryValue
    }
    
    static func sub<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        value: T,
        target: WritableKeyPath<Registers, T>,
        carry: Bool = false
    ) throws {
        let result = try Utils.cp(cpu: &cpu, value: value, target: target, carry: carry)
        cpu.registers[keyPath: target] = result
    }
    
    static func and<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        value: T,
        target: WritableKeyPath<Registers, T>
    ) throws {
        let newValue = cpu.registers[keyPath: target] & value
        cpu.registers[keyPath: target] = newValue
        
        // Registers update
        cpu.registers.hasZeroFlag = newValue == 0
        cpu.registers.hasCarryFlag = false
        cpu.registers.hasSubtractionFlag = false
        cpu.registers.hasHalfCarryFlag = true
    }
    
    static func or<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        value: T,
        target: WritableKeyPath<Registers, T>
    ) throws {
        let newValue = cpu.registers[keyPath: target] | value
        cpu.registers[keyPath: target] = newValue
        
        // Registers update
        cpu.registers.hasZeroFlag = newValue == 0
        cpu.registers.hasCarryFlag = false
        cpu.registers.hasSubtractionFlag = false
        cpu.registers.hasHalfCarryFlag = false
    }
    
    static func xor<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        value: T,
        target: WritableKeyPath<Registers, T>
    ) throws {
        let newValue = cpu.registers[keyPath: target] ^ value
        cpu.registers[keyPath: target] = newValue
        
        // Registers update
        cpu.registers.hasZeroFlag = newValue == 0
        cpu.registers.hasCarryFlag = false
        cpu.registers.hasSubtractionFlag = false
        cpu.registers.hasHalfCarryFlag = false
    }
    
    static func inc<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        target: WritableKeyPath<Registers, T>,
        shouldReportCarry: Bool
    ) throws {
        let old = cpu.registers[keyPath: target]
        let (new, _) = old.addingReportingOverflow(1)
        cpu.registers[keyPath: target] = new
        cpu.registers.hasZeroFlag = new == 0
        cpu.registers.hasCarryFlag = false
        cpu.registers.hasSubtractionFlag = false
        if shouldReportCarry {
            cpu.registers.hasHalfCarryFlag = (old & 0b100) > (new & 0b100)
        }
    }
    
    static func dec<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        target: WritableKeyPath<Registers, T>,
        shouldReportCarry: Bool
    ) throws {
        let old = cpu.registers[keyPath: target]
        let (new, _) = old.subtractingReportingOverflow(1)
        cpu.registers[keyPath: target] = new
        cpu.registers.hasZeroFlag = new == 0
        cpu.registers.hasCarryFlag = false
        cpu.registers.hasSubtractionFlag = false
        if shouldReportCarry {
            // TODO: Check this !!!
            // TODO: This only updates half carry for 8bit registers
            cpu.registers.hasHalfCarryFlag = (old & 0b100) < (new & 0b100)
        }
    }
    
    static func rr<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        target: WritableKeyPath<Registers, T>
    ) throws {
        let size = MemoryLayout<T>.size
        let newCarry: Bool = cpu.registers[keyPath: target] & 0x1 == 0x1
        let rotatedCarry: T = (cpu.registers.hasCarryFlag ? 1 : 0) << (size * 8)
        let newValue = cpu.registers[keyPath: target] >> 1
        cpu.registers[keyPath: target] = newValue & rotatedCarry
        cpu.registers.hasCarryFlag = newCarry
        cpu.registers.hasZeroFlag = false
        cpu.registers.hasSubtractionFlag = false
        cpu.registers.hasHalfCarryFlag = false
    }
    
    static func rl<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        target: WritableKeyPath<Registers, T>
    ) throws {
        let size = MemoryLayout<T>.size
        let mask = T(0x1 << (size * 8))
        let newCarry: Bool = cpu.registers[keyPath: target] & mask == mask
        let oldCarry: T = cpu.registers.hasCarryFlag ? 1 : 0
        let newValue = cpu.registers[keyPath: target] >> 1
        cpu.registers[keyPath: target] = newValue & oldCarry
        cpu.registers.hasCarryFlag = newCarry
        cpu.registers.hasZeroFlag = false
        cpu.registers.hasSubtractionFlag = false
        cpu.registers.hasHalfCarryFlag = false
    }
    
    static func sla<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        target: WritableKeyPath<Registers, T>
    ) throws {
        let size = MemoryLayout<T>.size
        let mask = T(0x1 << (size * 8))
        let newCarry: Bool = cpu.registers[keyPath: target] & mask == mask
        let newValue = cpu.registers[keyPath: target] << 1
        cpu.registers[keyPath: target] = newValue
        cpu.registers.hasCarryFlag = newCarry
        cpu.registers.hasZeroFlag = newValue == 0
        cpu.registers.hasSubtractionFlag = false
        cpu.registers.hasHalfCarryFlag = false
    }
    
    static func sra<T: FixedWidthInteger & UnsignedInteger>(
        cpu: inout CPU,
        target: WritableKeyPath<Registers, T>
    ) throws {
        let newCarry: Bool = cpu.registers[keyPath: target] & 0x1 == 0x1
        let newValue = cpu.registers[keyPath: target] >> 1
        cpu.registers[keyPath: target] = newValue
        cpu.registers.hasCarryFlag = newCarry
        cpu.registers.hasZeroFlag = newValue == 0
        cpu.registers.hasSubtractionFlag = false
        cpu.registers.hasHalfCarryFlag = false
    }
}
