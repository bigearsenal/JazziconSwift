import XCTest
@testable import JazziconSwift

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
    
    func testMersenneTwister() throws {
        let genTest20Cases: (UInt32) -> [UInt32] = { seed in
            let source = Gust(seed: seed)
            
            var result = [UInt32]()
            for _ in 0..<20 {
                let uint32: UInt32 = source.random()
                result.append(uint32)
            }
            return result
        }
        
        // seed == 1
        XCTAssertEqual(genTest20Cases(1), [1791095845,4282876139,3093770124,4005303368,491263,550290313,1298508491,4290846341,630311759,1013994432,396591248,1703301249,799981516,1666063943,1484172013,2876537340,1704103302,4018109721,2314200242,3634877716])
        
        // seed == 1234
        XCTAssertEqual(genTest20Cases(1234), [822569775,2137449171,2671936806,3512589365,1880026316,2629000564,3373089432,3312965625,3349970575,3696548529,1170776343,646980841,1187404954,852631582,3444014763,3501098142,4115177196,682106748,3762102042,498808182])
        
        // seed == 74827683
        XCTAssertEqual(genTest20Cases(74827683), [1874567590,1381319807,2452295942,413698133,2930433667,2041850130,145822294,289449903,3658892885,109263213,3827765471,3223829248,129467459,4248183330,1007513768,1421789520,2115629014,2934614723,3386829114,2101908351])
        
        // test random float
        let genTestRandomFloat: (UInt32) -> Double = { seed in
            let source = Gust(seed: seed)
            return source.randomDouble()
        }
        
        XCTAssertEqual(genTestRandomFloat(1), 0.4170219984371215)
        XCTAssertEqual(genTestRandomFloat(1234), 0.19151945016346872)
        XCTAssertEqual(genTestRandomFloat(1242345), 0.8595580966211855)
    }
    
    func testHueShift() throws {
        let genTest: (UInt32) -> [String] = { seed in
            let generator = Gust(seed: seed)
            return hueShift(colors: jazziconColorHexes, generator: generator)
        }
        
        XCTAssertEqual(genTest(1), ["#018E8E","#03535E","#18A2F2","#236CE1","#C81453","#F29602","#F5BC00","#F93701","#FA6C00","#FB1868"])
        
        XCTAssertEqual(genTest(1234), ["#018E7E","#035E5E","#18BBF2","#2382E1","#C81468","#F27A02","#F59F00","#F91A01","#FA4F00","#FB1882"])
        
        XCTAssertEqual(genTest(12382389), ["#018E89","#03565E","#18A9F2","#2372E1","#C81459","#F28E02","#F5B400","#F92F01","#FA6400","#FB186F"])
    }
}
