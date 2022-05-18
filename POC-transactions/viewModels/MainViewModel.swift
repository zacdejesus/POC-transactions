//
//  MainViewModel.swift
//  POC-transactions
//
//  Created by z on 08/05/2022.
//

import Foundation

class MainViewViewModel {
    
    var uniqueProducts = [Product]()
    var productsService: ProductsService?
    var proctucts = [Product]()
    var proctuctsTableView = [Product]()
    var rates = [Rate]()
    
    var aUDRate = ""
    var uSDRate = ""
    var cADRate = ""
    
    init(productsService: ProductsService) {
        self.productsService = productsService
    }
    
    func loadData(completion: @escaping () -> Void) {
        productsService?.getProducts(success: { [weak self] products in
            self?.uniqueProducts = Array(Set(products))
            self?.proctucts = products
            completion()
        }, err: {
            // Handle error escenario
        })
        
        productsService?.getExchangeRates { [weak self] rates in
            self?.rates = rates
            self?.prepareRates()
        } err: {
            // Handle error escenario
        }
    }
    
    func prepareRates() {
        if cADRate.isEmpty {
            cADRate = rates.first(where: { $0.from?.contains("CAD") ?? false && $0.to?.contains("EUR") ?? false })?.rate ?? ""
            if !uSDRate.isEmpty {
                let rateAux = rates.first(where: { $0.from?.contains("CAD") ?? false && $0.to?.contains("USD") ?? false })?.rate ?? ""
                if let rateAux = Double(rateAux), let rate = Double(uSDRate) {
                    let cal = rateAux * rate
                    cADRate = String(cal)
                }
            }
            
            if !aUDRate.isEmpty {
                let rateAux = rates.first(where: { $0.from?.contains("CAD") ?? false && $0.to?.contains("AUD") ?? false })?.rate ?? ""
                if let rateAux = Double(rateAux), let rate = Double(aUDRate) {
                    let cal = rateAux * rate
                    cADRate = String(cal)
                }
            }
        }
        
        if uSDRate.isEmpty {
            uSDRate = rates.first(where: { $0.from?.contains("USD") ?? false && $0.to?.contains("EUR") ?? false })?.rate ?? ""
            if !cADRate.isEmpty {
                let rateAux = rates.first(where: { $0.from?.contains("USD") ?? false && $0.to?.contains("CAD") ?? false })?.rate ?? ""
                if let rateAux = Double(rateAux), let rate = Double(cADRate) {
                    let cal = rateAux * rate
                    uSDRate = String(cal)
                }
            }
            
            if !aUDRate.isEmpty {
                let rateAux = rates.first(where: { $0.from?.contains("USD") ?? false && $0.to?.contains("AUD") ?? false })?.rate ?? ""
                if let rateAux = Double(rateAux), let rate = Double(aUDRate) {
                    let cal = rateAux * rate
                    uSDRate = String(cal)
                }
            }
        }
        
        if aUDRate.isEmpty {
            aUDRate = rates.first(where: { $0.from?.contains("AUD") ?? false && $0.to?.contains("EUR") ?? false })?.rate ?? ""
            if !cADRate.isEmpty {
                let rateAux = rates.first(where: { $0.from?.contains("AUD") ?? false && $0.to?.contains("CAD") ?? false })?.rate ?? ""
                if let rateAux = Double(rateAux), let rate = Double(cADRate) {
                    let cal = rateAux * rate
                    aUDRate = String(cal)
                }
            }
            
            if !uSDRate.isEmpty {
                let rateAux = rates.first(where: { $0.from?.contains("AUD") ?? false && $0.to?.contains("USD") ?? false })?.rate ?? ""
                if let rateAux = Double(rateAux), let rate = Double(uSDRate) {
                    let cal = rateAux * rate
                    aUDRate = String(cal)
                }
            }
        }
    }
    
    func sortProducts(_ product: Product) {
        proctuctsTableView = proctucts.filter{ $0.sku == product.sku }
    }
    
    func calculateTotal(productTransactions: [Product]) -> String {
        if uSDRate.isEmpty || aUDRate.isEmpty || cADRate.isEmpty {
            prepareRates()
        }
        
        var totalSum = 0.0
        productTransactions.forEach { product in
            let amountPro = Double(product.amount ?? "") ?? 0.0
            switch Currencie(rawValue: product.currency ?? "") {
            
            case .USD:
                totalSum += amountPro * (Double(uSDRate) ?? 0.0)
            case .CAD:
                totalSum += amountPro * (Double(cADRate) ?? 0.0)
            case .EUR:
                totalSum += amountPro
            case .AUD:
                totalSum += amountPro * (Double(aUDRate) ?? 0.0)
            default:
                return
            }
        }
        return String(format: "%.2f",totalSum)
    }
}

enum Currencie: String {
    case USD = "USD"
    case CAD = "CAD"
    case EUR = "EUR"
    case AUD = "AUD"
}
