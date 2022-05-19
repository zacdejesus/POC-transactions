//
//  MockTestService.swift
//  POC-transactions
//
//  Created by z on 19/05/2022.
//

import Foundation
@testable import POC_transactions

final class MockTestService: ProductsService {
    func getProducts(success: @escaping ([Product]) -> Void, err: @escaping () -> Void) {
        if let path = Bundle.main.path(forResource: "jsonMockProductsData", ofType: "json") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            if let object = try? decoder.decode([Product].self, from: data!) {
                success(object)
            }
        }
        
    }
    
    func getExchangeRates(success: @escaping ([Rate]) -> Void, err: @escaping () -> Void) {
        
        if let path = Bundle.main.path(forResource: "jsonMockRatesData", ofType: "json") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            if let object = try? decoder.decode([Rate].self, from: data!) {
                success(object)
            }
        }
    }
    
}
