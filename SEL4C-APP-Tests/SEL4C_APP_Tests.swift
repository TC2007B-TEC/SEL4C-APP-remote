//
//  SEL4C_APP_Tests.swift
//  SEL4C-APP-Tests
//
//  Created by Raúl Vélez on 04/10/23.
//

import XCTest
@testable import SEL4C_APP

final class SEL4C_APP_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
//    func testCP_01_PruebaSuma() throws {
//        let ln = LogicaNegocio()
//        XCTAssertNotNil(ln)
//    }
    
//    func testCP_01_PruebaSuma() throws {
//        let ln = LogicaNegocio()
//        let r = ln.suma(a:2, b:2)
//        XCTAssertEqual(r,4)
//    }
//    
//    func testCP_01_PruebaSuma_Invalida() throws {
//        let ln = LogicaNegocio()
//        let r = ln.suma(a:2, b:2)
//        XCTAssertNotEqual(r,5)
//    }
    
    func testValidFetchAPI() {
        let loginVC = LoginVC()
        let expectation = self.expectation(description: "Valid API Request")

        loginVC.fetchAPI(email: "test@email.com", password: "Password123")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(loginVC.condicion)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testInvalidFetchAPI() {
        let loginVC = LoginVC()
        let expectation = self.expectation(description: "Invalid API Request")

        loginVC.fetchAPI(email: "test@", password: "test3")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(loginVC.condicion)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
