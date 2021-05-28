//
//  AddressGenTests.swift
//  JazziconSwift_Tests
//
//  Created by Chung Tran on 28/05/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import JazziconSwift

class AddressGenTests: XCTestCase {

    func testGenerateAddress() throws {
        let address1 = AddressGen.generateAddress()
        let address2 = AddressGen.generateAddress()
        
        XCTAssertEqual(address1.count, 12)
        XCTAssertEqual(address2.count, 12)
        
        XCTAssertNotEqual(address1, address2)
    }

}
