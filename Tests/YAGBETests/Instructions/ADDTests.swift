import XCTest
@testable import YAGBE

final class ADDTests: XCTestCase {
    
    func testADDConstantNoOverflow() throws {
        var cpu = CPU()
        cpu.registers.a = 0x11
        
        let value: UInt8 = 0x22
        
        let instruction = ADD(value: value)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0x33)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertFalse(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantWithOverflow() throws {
        var cpu = CPU()
        cpu.registers.a = 0xFF
        
        let value: UInt8 = 0x10
        
        let instruction = ADD(value: value)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0x0F)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantWithHalfCarry() throws {
        var cpu = CPU()
        cpu.registers.a = 0b00001111
        
        let value: UInt8 = 0b000000001
        
        let instruction = ADD(value: value)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0b00010000)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertFalse(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantSetsZeroCorrectly() throws {
        var cpu = CPU()
        cpu.registers.a = 0b11111111
        
        let value: UInt8 = 0b000000001
        
        let instruction = ADD(value: value)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0b00000000)
        XCTAssertTrue(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testADDRegisterNoOverflow() throws {
        var cpu = CPU()
        cpu.registers.a = 0x11
        
        cpu.registers.b = 0x22
        
        let instruction = ADD(target: \.b)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0x33)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertFalse(cpu.registers.hasCarryFlag)
    }
    
    func testADDRegisterWithOverflow() throws {
        var cpu = CPU()
        cpu.registers.a = 0xFF
        
        cpu.registers.b = 0x10
        
        let instruction = ADD(target: \.b)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0x0F)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testADDRegisterWithHalfCarry() throws {
        var cpu = CPU()
        cpu.registers.a = 0b00001111
        
        cpu.registers.b = 0b000000001
        
        let instruction = ADD(target: \.b)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0b00010000)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertFalse(cpu.registers.hasCarryFlag)
    }
    
    func testADDRegisterSetsZeroCorrectly() throws {
        var cpu = CPU()
        cpu.registers.a = 0b11111111
        
        cpu.registers.b = 0b000000001
        
        let instruction = ADD(target: \.b)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0b00000000)
        XCTAssertTrue(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
}
