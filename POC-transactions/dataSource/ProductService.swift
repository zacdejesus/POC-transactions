//
//  ProductService.swift
//  POC-transactions
//
//  Created by z on 08/05/2022.
//

import Foundation

protocol ProductsService {
    func getProducts(success: @escaping ([Product]) -> Void, err: @escaping () -> Void)
}

class ProductRemoteService: ProductsService {
    
    let url = URL(string: "http://quiet-stone-2094.herokuapp.com/transactions.json")
    
    func getProducts(success: @escaping ([Product]) -> Void, err: @escaping () -> Void) {
        guard let url = url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }
            do {
                let slpData2 = try JSONDecoder().decode([Product].self, from: data)
                success(slpData2)
            } catch {
                err()
            }
        }).resume()
    }
    
    func getExchangeRates(success: @escaping ([Rate]) -> Void, err: @escaping () -> Void) {
        guard let url = url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }
            do {
                let slpData2 = try JSONDecoder().decode([Rate].self, from: data)
                success(slpData2)
            } catch {
                err()
            }
        }).resume()
    }
}
