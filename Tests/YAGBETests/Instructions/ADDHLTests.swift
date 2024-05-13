import XCTest
@testable import YAGBE

final class ADDHLTests: XCTestCase {
    
    func testADDNoOverflow() throws {
        var cpu = CPU()
        cpu.registers.hl = 0xFE11
        
        cpu.registers.af = 0x0022
        
        let instruction = ADDHL(register: \.af)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.hl, 0xFE33)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertFalse(cpu.registers.hasCarryFlag)
    }
    
    func testADDWithOverflow() throws {
        var cpu = CPU()
        cpu.registers.hl = 0xFF00
        cpu.registers.af = 0xFF00
        
        let instruction = ADDHL(register: \.af)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.hl, 0xFE00)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testADDWithHalfCarry() throws {
        var cpu = CPU()
        cpu.registers.hl = 0xFF02
        cpu.registers.af = 0x00FF
        
        let instruction = ADDHL(register: \.af)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.hl, 0x01)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testADDSetsZeroCorrectly() throws {
        var cpu = CPU()
        cpu.registers.hl = 0xFFFF
        cpu.registers.af = 0x0001
        
        let instruction = ADDHL(register: \.af)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.hl, 0b00000000)
        XCTAssertTrue(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantNoOverflow() throws {
        var cpu = CPU()
        cpu.registers.hl = 0xFE11
        
        let instruction = ADDHL(value: 0x0022)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.hl, 0xFE33)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertFalse(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantWithOverflow() throws {
        var cpu = CPU()
        cpu.registers.hl = 0xFF00
        
        let instruction = ADDHL(value: 0xFF00)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.hl, 0xFE00)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantWithHalfCarry() throws {
        var cpu = CPU()
        cpu.registers.hl = 0xFF02
        
        let instruction = ADDHL(value: 0x00FF)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.hl, 0x01)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantSetsZeroCorrectly() throws {
        var cpu = CPU()
        cpu.registers.hl = 0xFFFF
        
        let instruction = ADDHL(value: 0x0001)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.hl, 0b00000000)
        XCTAssertTrue(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
}
