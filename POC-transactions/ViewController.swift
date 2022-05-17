//
//  ViewController.swift
//  POC-transactions
//
//  Created by z on 08/05/2022.
//

import UIKit

class ViewController: UIViewController {

    var products = [Product]()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalProductSum: UILabel!
    
    let pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    let viewModel = MainViewViewModel(productsService: ProductRemoteService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        setupTableView()
        
        viewModel.loadNFTData {
            self.products = self.viewModel.proctucts
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
    }

    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    private func setupTableView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return products.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return products[row].sku
    }
}
