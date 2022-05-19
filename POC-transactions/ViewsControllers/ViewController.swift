//
//  ViewController.swift
//  POC-transactions
//
//  Created by z on 08/05/2022.
//

import UIKit

class ViewController: UIViewController {

    var selectedProductTransactions = [Product]()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalProductSum: UILabel!
    
    let viewModel = MainViewViewModel(productsService: ProductRemoteService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        setupTableView()
        
        viewModel.loadData {
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
    }

    private func setupPickerView() {
        pickerView.accessibilityIdentifier = "pickerView"
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    private func setupTableView() {
        
        tableView.accessibilityIdentifier = "tableView"
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.uniqueProducts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.uniqueProducts[row].sku
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.sortProducts(viewModel.uniqueProducts[row])
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.totalProductSum.text = "total sum " + self.viewModel.calculateTotal(productTransactions: self.viewModel.proctuctsTableView) + " EUR"
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.proctuctsTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text = "\(indexPath.row + 1)  Transaction: " + " \(viewModel.proctuctsTableView[indexPath.row].amount ?? "") " + " \(viewModel.proctuctsTableView[indexPath.row].currency ?? "")"
        return cell
    }
    
    
}

