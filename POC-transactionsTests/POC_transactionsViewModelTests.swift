//
//  POC_transactionsTests.swift
//  POC-transactionsTests
//
//  Created by z on 19/05/2022.
//

import XCTest
@testable import POC_transactions

class POC_transactionsViewModelTests: XCTestCase {

    var viewModel: MainViewViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = MainViewViewModel(productsService: MockTestService())
        
        viewModel.productsService?.getExchangeRates(success: { rates in
            self.viewModel.rates = rates
            self.viewModel.prepareRates()
        }, err: {})
        
        viewModel.productsService?.getProducts(success: { products in
            self.viewModel.uniqueProducts = Array(Set(products))
            self.viewModel.proctucts = products
        }, err: {})
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRatesSetupCorrectly() throws {
        viewModel.prepareRates()
        XCTAssertEqual(viewModel.cADRate, "0.45560000000000006")
        XCTAssertEqual(viewModel.uSDRate, "1.15")
        XCTAssertEqual(viewModel.aUDRate, "0.67")
    }
    
    func testSortProductsWithParticularSKU() {
        let testProduct = Product(sku: "H1391", amount: "", currency: "")
        viewModel.sortProducts(testProduct)
        XCTAssertEqual(viewModel.proctuctsTableView.count, 351)
        XCTAssertTrue(viewModel.proctuctsTableView.first?.sku == "H1391")
    }
    
    func testSortProductsWithWrongSKU() {
        let testProduct = Product(sku: "H13122191", amount: "", currency: "")
        viewModel.sortProducts(testProduct)
        XCTAssertTrue(viewModel.proctuctsTableView.isEmpty)
    }
    
    func testCalculateTotalOfAProduct() {
        let testProduct = Product(sku: "H1391", amount: "", currency: "")
        viewModel.sortProducts(testProduct)

        XCTAssertEqual(viewModel.calculateTotal(productTransactions: viewModel.proctuctsTableView),"7027.41")
        
    }
}
