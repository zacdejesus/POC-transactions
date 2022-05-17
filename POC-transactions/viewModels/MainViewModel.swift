//
//  MainViewModel.swift
//  POC-transactions
//
//  Created by z on 08/05/2022.
//

import Foundation

class MainViewViewModel {
    
    var productsService: ProductsService?
    var proctucts = [Product]()
    
    init(productsService: ProductsService) {
        self.productsService = productsService
    }
    
    func loadNFTData(completion: @escaping () -> Void) {
        
        productsService?.getProducts(success: { [weak self] products in
            
            self?.proctucts = products
            completion()
        }, err: {
            
        })
    }
}
