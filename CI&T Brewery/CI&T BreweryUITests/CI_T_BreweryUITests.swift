//
//  CI_T_BreweryUITests.swift
//  CI&T BreweryUITests
//
//  Created by Pedro Henrique Catanduba de Andrade on 11/08/22.
//

import XCTest

class CI_T_BreweryUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = .init()
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"B9 Beverages Inc").element.swipeLeft()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.buttons["Avaliar"].tap()
        app.otherElements["Classificação"].tap()
        app.textFields["e-mail"].tap()
        app.buttons["Unchecked"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Salvar"]/*[[".buttons[\"Salvar\"].staticTexts[\"Salvar\"]",".staticTexts[\"Salvar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Fechar"].tap()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Detalhes da Cervejaria").children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .other).element.tap()
                

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
