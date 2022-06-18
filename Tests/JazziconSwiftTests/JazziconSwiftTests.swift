import XCTest
@testable import JazziconSwift
import GameplayKit

final class JazziconSwiftTests: XCTestCase {
    func testHexToHSL() throws {
        XCTAssertEqual(hexToHSL("#01888C"), .init(h: 182, s: 99, l: 28))
        XCTAssertEqual(hexToHSL("#FC7500"), .init(h: 28, s: 100, l: 49))
        XCTAssertEqual(hexToHSL("#034F5D"), .init(h: 189, s: 94, l: 19))
        XCTAssertEqual(hexToHSL("#F73F01"), .init(h: 15, s: 99, l: 49))
        XCTAssertEqual(hexToHSL("#FC1960"), .init(h: 341, s: 97, l: 54))
        XCTAssertEqual(hexToHSL("#C7144C"), .init(h: 341, s: 82, l: 43))
        XCTAssertEqual(hexToHSL("#F3C100"), .init(h: 48, s: 100, l: 48))
        XCTAssertEqual(hexToHSL("#1598F2"), .init(h: 204, s: 89, l: 52))
        XCTAssertEqual(hexToHSL("#2465E1"), .init(h: 219, s: 76, l: 51))
        XCTAssertEqual(hexToHSL("#F19E02"), .init(h: 39, s: 98, l: 48))
    }
    
    func testHueShift() throws {
        let colors = hueShift(
            colors: jazziconColorHexes,
            generator: GKMersenneTwisterRandomSource(seed: 1)
        )
        
    }
}

