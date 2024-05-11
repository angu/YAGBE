import XCTest
@testable import YAGBE

final class SWAPTests: XCTestCase {
    
    func testSWAPInstruction8bit() throws {
        let registers = Registers()
        let memory = Memory()
        var cpu = CPU(registers: registers, memory: memory, pc: 0, sp: 0)
        cpu.registers.a = 0b00001111
        let instruction = SWAP(target: .a)
        try cpu.execute(instruction: instruction)
        XCTAssertEqual(cpu.registers.a, 0b11110000)
    }
    
    func testSETInstruction16bit() throws {
        let registers = Registers()
        let memory = Memory()
        var cpu = CPU(registers: registers, memory: memory, pc: 0, sp: 0)
        cpu.registers.af = 0b1100001100111100
        let instruction = SWAP(target: .af)
        try cpu.execute(instruction: instruction)
        XCTAssertEqual(cpu.registers.af, 0b0011110011000011)
    }
}
