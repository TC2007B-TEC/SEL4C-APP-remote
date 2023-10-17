//
//  SEL4C_APP_Tests.swift
//  SEL4C-APP-Tests
//
//  Created by Raúl Vélez on 04/10/23.
//

import XCTest
import CryptoKit

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
    
    func testExample2() throws {
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
    
    func sha256(_ input: String) -> String {
        // Convertir el string a datos binarios
        let data = Data(input.utf8)
        // Calcular el hash SHA-256 usando la librería CryptoKit
        let hash = SHA256.hash(data: data)
        // Convertir el hash a un string hexadecimal
        let hexString = hash.compactMap { String(format: "%02x", $0) }.joined()
        // Regresar el string hexadecimal
        return hexString
    }
    
    func testCP_01_login_valid(){
        let loginVC = LoginVC()
        let expectation = self.expectation(description: "Valid API Request")

        loginVC.getAPI(email: "Prueba@prueba.com", password: sha256("Prueba123"))

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(loginVC.condicion)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCP_01_login_invalid() {
        let loginVC = LoginVC()
        let expectation = self.expectation(description: "Invalid API Request")

        loginVC.getAPI(email: "test@", password: "test3")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(loginVC.condicion)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCP_02_getActivity_valid() {
        let expectation = self.expectation(description: "API Call Expectation")
        
        ActivityDoneAPI.shared.getAPI(email: "Prueba@prueba.com", name: "A1_1") { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCP_02_getActivity_invalid() {
        let expectation = self.expectation(description: "API Call Expectation")
        
        ActivityDoneAPI.shared.getAPI(email: "", name: "") { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCP_01_sendTest_valid() {
        
                // Assuming you have a setup for your test, like setting `testNum` and `USERNAME` in UserDefaults
                
                let expectation = XCTestExpectation(description: "Send test JSON expectation")
                
            Poll1VC().sendTestJSON("Prueba@prueba.com","D1")

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // Assuming the server responds with status code 200 for a successful request
                    expectation.fulfill()
                }
                
                wait(for: [expectation], timeout: 5)
            
    }
    
    func testCP_01_sendTest_invalid(){
        // Assuming you have a setup for your test, like setting `testNum` and `USERNAME` in UserDefaults
        
        let expectation = XCTestExpectation(description: "Invalid Send Test JSON expectation")
        
        // Intentionally passing incorrect parameters to the function
        Poll1VC().sendTestJSON("", "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Assuming the server responds with status code 200 for a successful request
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
