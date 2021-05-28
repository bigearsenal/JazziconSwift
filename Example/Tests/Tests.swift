//
//  Tests.swift
//  JazziconSwift_Tests
//
//  Created by Chung Tran on 28/05/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import UIKit

class Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.        
        var hue = CGFloat(0)
        var saturation = CGFloat(0)
        var brightness = CGFloat(0)
        var alpha = CGFloat(0)
        UIColor.blue.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        print(hue, brightness, alpha)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
