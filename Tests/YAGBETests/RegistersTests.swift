import XCTest
@testable import YAGBE

final class RegistersTests: XCTestCase {
    
    func testThatCombined16RegisterCanBeWritten() throws {
        var registers = Registers()
        // af
        let value: UInt16 = 0xAABB
        registers.af = value
        XCTAssertEqual(registers.a, 0xAA)
        XCTAssertEqual(registers.f, 0xBB)
        // bc
        registers.bc = value
        XCTAssertEqual(registers.b, 0xAA)
        XCTAssertEqual(registers.c, 0xBB)
        // de
        registers.de = value
        XCTAssertEqual(registers.d, 0xAA)
        XCTAssertEqual(registers.e, 0xBB)
        // hl
        registers.hl = value
        XCTAssertEqual(registers.h, 0xAA)
        XCTAssertEqual(registers.l, 0xBB)
    }
    
    func testThatCombined16RegisterCanBeRead() throws {
        var registers = Registers()
        // af
        let r1Value: UInt8 = 0xAA
        let r2Value: UInt8 = 0xBB
        registers.a = r1Value
        registers.f = r2Value
        XCTAssertEqual(registers.af, 0xAABB)
        // bc
        registers.b = r1Value
        registers.c = r2Value
        XCTAssertEqual(registers.bc, 0xAABB)
        // de
        registers.d = r1Value
        registers.e = r2Value
        XCTAssertEqual(registers.de, 0xAABB)
        // hl
        registers.h = r1Value
        registers.l = r2Value
        XCTAssertEqual(registers.hl, 0xAABB)
    }
    
    func testThatFlagsCanBeSetAllTogether() throws {
        var registers = Registers()
        XCTAssertTrue(registers.f == 0)
        
        registers.hasZeroFlag = true
        registers.hasCarryFlag = true
        registers.hasSubtractionFlag = true
        registers.hasHalfCarryFlag = true
        
        XCTAssertEqual(registers.f, 0xF0)
    }
    
    func testThatFlagsCanBeUnset() throws {
        var registers = Registers()
        XCTAssertTrue(registers.f == 0x0)
        
        // Set all flags
        registers.f = 0xF0
        
        registers.hasZeroFlag = false
        registers.hasCarryFlag = false
        registers.hasSubtractionFlag = false
        registers.hasHalfCarryFlag = false
        
        XCTAssertEqual(registers.f, 0x0)
    }
    
    func testThatEachFlagCanBeSetSeparately() throws {
        var registers = Registers()
        XCTAssertTrue(registers.f == 0)
        
        registers.hasZeroFlag = true
        XCTAssertEqual(registers.f, 0b10000000)
        registers.clearFlags()
        
        registers.hasSubtractionFlag = true
        XCTAssertEqual(registers.f, 0b01000000)
        registers.clearFlags()
        
        registers.hasHalfCarryFlag = true
        XCTAssertEqual(registers.f, 0b00100000)
        registers.clearFlags()
        
        registers.hasCarryFlag = true
        XCTAssertEqual(registers.f, 0b00010000)
        registers.clearFlags()
    }
    
    func testThatEachFlagCanBeReadSeparately() throws {
        var registers = Registers()
        XCTAssertTrue(registers.f == 0)
        XCTAssertTrue(registers.f == 0)
        
        registers.f = 0b10000000
        XCTAssertTrue(registers.hasZeroFlag)
        registers.clearFlags()
        
        registers.f = 0b01000000
        XCTAssertTrue(registers.hasSubtractionFlag)
        registers.clearFlags()
        
        registers.f = 0b00100000
        XCTAssertTrue(registers.hasHalfCarryFlag)
        registers.clearFlags()
        
        registers.f = 0b00010000
        XCTAssertTrue(registers.hasCarryFlag)
        registers.clearFlags()
    }
    
    func testThatSetterAndGetterWorkTogether() throws {
        var registers = Registers()
        XCTAssertTrue(registers.f == 0)
        
        registers.hasCarryFlag = true
        registers.hasZeroFlag = false
        
        XCTAssertTrue(registers.hasCarryFlag)
    }
}
