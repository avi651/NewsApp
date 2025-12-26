////
////  MainTabViewUITests.swift
////  NewsAppUITests
////
////  Created by Avinash on 26/12/25.
////
//
//import XCTest
//
//final class MainTabViewUITests: XCTestCase {
//
//    let app = XCUIApplication()
//
//    override func setUp() {
//        super.setUp()
//        continueAfterFailure = false
//        app.launch()
//    }
//
//    func test_app_launches_and_news_tab_exists() {
//        let newsTab = app.tabBars.buttons["News"]
//        XCTAssertTrue(newsTab.exists)
//        XCTAssertTrue(newsTab.isSelected)
//    }
//    
//    func test_switch_to_search_tab() {
//        let searchTab = app.tabBars.buttons["Search"]
//        XCTAssertTrue(searchTab.exists)
//
//        searchTab.tap()
//
//        XCTAssertTrue(searchTab.isSelected)
//    }
//    
//    func test_switch_to_saved_tab() {
//        let savedTab = app.tabBars.buttons["Saved"]
//        XCTAssertTrue(savedTab.exists)
//
//        savedTab.tap()
//
//        XCTAssertTrue(savedTab.isSelected)
//    }
//
//    func test_news_list_screen_loads() {
//        let table = app.tables.firstMatch
//        XCTAssertTrue(table.waitForExistence(timeout: 5))
//    }
//
//    func test_saved_screen_loads() {
//        let savedTab = app.tabBars.buttons["Saved"]
//        savedTab.tap()
//
//        let navigationTitle = app.navigationBars["Saved"]
//        XCTAssertTrue(navigationTitle.waitForExistence(timeout: 3))
//    }
//
//}
