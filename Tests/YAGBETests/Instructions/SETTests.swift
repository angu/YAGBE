import XCTest
@testable import YAGBE

final class SETTests: XCTestCase {
    
    func testSETInstruction8bit() throws {
        let registers = Registers()
        var memory = Memory()
        var cpu = CPU(registers: registers, memory: memory, pc: 0, sp: 0)
        let instruction = SET(target: .bit8Target(.c), bit: 2)
        try cpu.execute(instruction: instruction)
        XCTAssertEqual(cpu.registers.c, 0b00000100)
    }
    
    func testSETInstruction16bit() throws {
        let registers = Registers()
        var memory = Memory()
        var cpu = CPU(registers: registers, memory: memory, pc: 0, sp: 0)
        let instruction = SET(target: .bit16Target(.de), bit: 9)
        try cpu.execute(instruction: instruction)
        XCTAssertEqual(cpu.registers.de, 0b000001000000000)
    }

    func testSETInvalidInstructionsThrow() throws {
        var cpu = CPU()
        
        XCTAssertThrowsError(try cpu.execute(instruction: SET(target: .bit8(0), bit: 0)))
        XCTAssertThrowsError(try cpu.execute(instruction: SET(target: .bit16(0), bit: 0)))
    }
    
    func testSETCycleValues() throws {
        XCTAssertEqual(SET(target: .bit16(0), bit: 0).cycles, 4)
        XCTAssertEqual(SET(target: .bit8(0), bit: 0).cycles, 2)
        XCTAssertEqual(SET(target: .bit8Target(.a), bit: 0).cycles, 2)
        XCTAssertEqual(SET(target: .bit16Target(.bc), bit: 0).cycles, 4)
    }
}
