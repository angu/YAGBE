import XCTest
@testable import YAGBE

final class ADCTests: XCTestCase {
    
    func testADDConstantNoOverflow() throws {
        var cpu = CPU()
        cpu.registers.a = 0x11
        cpu.registers.hasCarryFlag = true
        cpu.registers.b = 0x22
        
        let instruction = ADC(register: \.b)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0x34)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertFalse(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantWithOverflow() throws {
        var cpu = CPU()
        cpu.registers.a = 0xFF
        cpu.registers.hasCarryFlag = true
        cpu.registers.b = 0x10
        
        let instruction = ADC(register: \.b)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0x10)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantWithHalfCarry() throws {
        var cpu = CPU()
        cpu.registers.a = 0b00001110
        cpu.registers.hasCarryFlag = true
        cpu.registers.b = 0b000000001
        
        let instruction = ADC(register: \.b)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0b00010000)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertFalse(cpu.registers.hasCarryFlag)
    }
    
    func testADDConstantSetsZeroCorrectly() throws {
        var cpu = CPU()
        cpu.registers.a = 0b11111110
        cpu.registers.hasCarryFlag = true
        cpu.registers.b = 0b000000001
        
        let instruction = ADC(register: \.b)
        try cpu.execute(instruction: instruction)
        
        XCTAssertEqual(cpu.registers.a, 0b00000000)
        XCTAssertTrue(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
    
    func testAddSameRegisterCorrectly() throws {
        var cpu = CPU()
        cpu.registers.a = 0x01
        cpu.registers.hasCarryFlag = true
        
        let instruction = ADC(register: \.a)
        try cpu.execute(instruction: instruction)
        XCTAssertEqual(cpu.registers.a, 0x03)
        XCTAssertFalse(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertFalse(cpu.registers.hasHalfCarryFlag)
        XCTAssertFalse(cpu.registers.hasCarryFlag)
    }
    
    func testAdd16bitRegisterTo8bit() throws {
        var cpu = CPU()
        cpu.registers.a = 0x00
        cpu.registers.hasCarryFlag = true
        cpu.registers.hl = 0xFFFF
        let instruction = ADC(register: \.hl)
        
        try cpu.execute(instruction: instruction)
        XCTAssertEqual(cpu.registers.a, 0x00)
        XCTAssertTrue(cpu.registers.hasZeroFlag)
        XCTAssertFalse(cpu.registers.hasSubtractionFlag)
        XCTAssertTrue(cpu.registers.hasHalfCarryFlag)
        XCTAssertTrue(cpu.registers.hasCarryFlag)
    }
}
