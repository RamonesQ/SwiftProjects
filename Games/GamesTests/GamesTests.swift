//
//  GamesTests.swift
//  GamesTests
//
//  Created by Ramon Queiroz dos Santos on 13/09/22.
//

import XCTest
@testable import Games

class GamesTests: XCTestCase {
	
	var consolesManager: ConsolesManager!
	var coreDataStack: TestCoreDataStack!

    override func setUp() {
		 super.setUp()
		 coreDataStack = TestCoreDataStack()
		 consolesManager = ConsolesManager(mainContext: coreDataStack.mainContext)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
	
	func testCreateGame(){
		consolesManager.createConsole(name: "Atari")
		let console = consolesManager.fetchConsole(withName: "Atari")
		
		XCTAssertEqual("Atari", console?.name)
	}
	
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
