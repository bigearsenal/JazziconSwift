//
//  MersenneTwisterTests.swift
//  JazziconSwift_Tests
//
//  Created by Chung Tran on 05/06/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import GameplayKit

class MersenneTwisterTests: XCTestCase {

    func testMersenneTwister() throws {
        let seed: UInt64 = 1
        let generator = GKMersenneTwisterRandomSource(seed: seed)
        
        XCTAssertEqual(generator.nextUniform(), 0.13387664)
    }

}
