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

    func test_top10_from_detail() throws {
        let firstElement =  app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element
        let btnEvaluation = app.scrollViews.otherElements.buttons["Avaliar"]
        let classification = app.otherElements["Classificação"]
        let emailTextField = app.textFields["e-mail"]
        let btnSave = app/*@START_MENU_TOKEN@*/.buttons["Salvar"].staticTexts["Salvar"]/*[[".buttons[\"Salvar\"].staticTexts[\"Salvar\"]",".staticTexts[\"Salvar\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let btnClose = app.buttons["Fechar"]
        let uncheckedButton = app.buttons["Unchecked"]
        let btnReturn = app/*@START_MENU_TOKEN@*/.keyboards.buttons["Return"]/*[[".keyboards",".buttons[\"retorno\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[2,0]]@END_MENU_TOKEN@*/
        let email = getRandomEmail()
        
        firstElement.tap()
        XCTAssert(firstElement.exists)
        
        btnEvaluation.tap()
        XCTAssert(btnEvaluation.exists)
        
        classification.firstMatch.tap()
        XCTAssert(classification.exists)
        
        emailTextField.tap()
        emailTextField.typeText(email)
        btnReturn.tap()
        XCTAssert(emailTextField.exists)
        
        XCTAssert(uncheckedButton.exists)
        
        btnSave.tap()
        XCTAssert(btnSave.exists)
        
        XCTAssert(btnClose.exists)
    }
    
    func test_detail_from_search_by_city() {
        
        let search = app.searchFields["Busque por local"]
        let firstCell = app.tables.cells.firstMatch
        let btnSearch =  app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"buscar\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let btnEvaluation = app.scrollViews.otherElements.buttons["Avaliar"]
        let classification = app.otherElements["Classificação"]
        let emailTextField = app.textFields["e-mail"]
        let btnSave = app/*@START_MENU_TOKEN@*/.buttons["Salvar"].staticTexts["Salvar"]/*[[".buttons[\"Salvar\"].staticTexts[\"Salvar\"]",".staticTexts[\"Salvar\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let btnClose = app.buttons["Fechar"]
        let uncheckedButton = app.buttons["Unchecked"]
        let btnReturn = app/*@START_MENU_TOKEN@*/.keyboards.buttons["Return"]/*[[".keyboards",".buttons[\"retorno\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[2,0]]@END_MENU_TOKEN@*/
        let email = getRandomEmail()
        
        search.tap()
        search.typeText("Paris")
        btnSearch.tap()
        XCTAssert(search.exists)
        
        firstCell.tap()
        XCTAssert(firstCell.exists)
        
        btnEvaluation.tap()
        XCTAssert(btnEvaluation.exists)
        
        classification.firstMatch.tap()
        XCTAssert(classification.exists)
        
        emailTextField.tap()
        emailTextField.typeText(email)
        btnReturn.tap()
        XCTAssert(emailTextField.exists)
        
        XCTAssert(uncheckedButton.exists)
        
        btnSave.tap()
        XCTAssert(btnSave.exists)
        
        XCTAssert(btnClose.exists)
    }
    
    func test_myRatedBreweries() {
        let ratedBreweriesButton = app.navigationBars["home_nav_bar"].buttons["rated_breweries_button"]
        let emailTextField = app.textFields["email_text_field_rated_breweries"]
        let email = getRandomEmail()
        let btnReturn = app/*@START_MENU_TOKEN@*/.keyboards.buttons["Return"]/*[[".keyboards",".buttons[\"retorno\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[2,0]]@END_MENU_TOKEN@*/
        let confirmBtn = app.buttons["confirm_button_rated_breweries"]
        let mainTitle = app.staticTexts["main_title_label_rated_breweries"]
        
        ratedBreweriesButton.tap()
        emailTextField.tap()
        emailTextField.typeText(email)
        btnReturn.tap()
        confirmBtn.tap()
        
        XCTAssertTrue(mainTitle.isHittable)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func getRandomEmail(currentStringAsUsername: Bool = false) -> String {
        let providers = ["gmail.com", "hotmail.com", "icloud.com", "live.com"]
        let randomProvider = providers.randomElement()!
        if currentStringAsUsername {
            return "\(self)@\(randomProvider)"
        }
        let username = UUID.init().uuidString.replacingOccurrences(of: "-", with: "")
        return "\(username)@\(randomProvider)"
    }
}
