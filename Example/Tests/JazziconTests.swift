//
//  JazziconTests.swift
//  JazziconSwift_Tests
//
//  Created by Chung Tran on 28/05/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import UIKit
import JazziconSwift

class JazziconTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUnuniqueIcon() throws {
        let icon1 = Jazzicon(seed: 1).generateImage(size: 50)
        let icon2 = Jazzicon(seed: 2).generateImage(size: 50)
        
        let data1 = UIImagePNGRepresentation(icon1)
        let data2 = UIImagePNGRepresentation(icon2)
        
        XCTAssertNotEqual(data1, data2)
    }
    
    func testUniqueIcon() throws {
        let icon1 = Jazzicon(seed: 1).generateImage(size: 50)
        let icon2 = Jazzicon(seed: 1).generateImage(size: 50)
        
        let data1 = UIImagePNGRepresentation(icon1)
        let data2 = UIImagePNGRepresentation(icon2)
        
        XCTAssertEqual(data1, data2)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
