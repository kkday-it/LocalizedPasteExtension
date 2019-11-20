//
//  LocalizedPasteTests.swift
//  LocalizedPasteTests
//
//  Created by 劉柏賢 on 2019/11/20.
//  Copyright © 2019 劉柏賢. All rights reserved.
//

import XCTest
@testable import LocalizedPaste

class LocalizedPasteTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFromLocalizedStrings() {
        let input: String = """
            "boarding_label_start_trip" = "開始體驗";
        """

        let actual: String? = Utilities.getLocalized(input: input, source: SourceCommand.localizable)
        let expect: String = """
        "boarding_label_start_trip".localize("開始體驗")
        """

        XCTAssertEqual(actual, expect)
    }
    
    func testFromExcel() {
        let input: String = "boarding_label_start_trip\t開始體驗"

        let actual: String? = Utilities.getLocalized(input: input, source: SourceCommand.excel)
        let expect: String = """
        "boarding_label_start_trip".localize("開始體驗")
        """

        XCTAssertEqual(actual, expect)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
