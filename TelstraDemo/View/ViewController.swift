//
//  ViewController.swift
//  TelstraDemo
//
//  Created by Arun.V on 11/12/19.
//  Copyright © 2019 Arun.V. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tableView = UITableView()
    let cellIdentifier = "employeeCell"
    let viewModel = CountryViewModel()
    var downloadedImageDictionary: [String: UIImage] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Data is yet to be fetched"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.allowsSelection = false
        
        //Fetch my country data
        viewModel.fetchCountryData { (countryModel) in
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.title = countryModel.title
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        let cellData = self.viewModel.rows?[indexPath.row]
        cell.titleLabel.text = cellData?.title
        cell.descriptionLabel.text = cellData?.description
        cell.cellImageView.image = UIImage(named: "Default")
        
        //Image download part
        if let imageUrl = cellData?.imageHref {
            if let existingImage = self.downloadedImageDictionary["\(indexPath.row)"] {
                cell.cellImageView.image = existingImage
            } else {
                self.viewModel.getImageForUrl(imageUrl) { (downloadedImage) in
                    if let downloadedImage = downloadedImage {
                        cell.cellImageView.image = downloadedImage
                        self.downloadedImageDictionary["\(indexPath.row)"] = downloadedImage
                    } else {
                        self.updateDefaultImage(for: cell, indexPathKey: "\(indexPath.row)")
                    }
                }
            }
        } else {
           self.updateDefaultImage(for: cell, indexPathKey: "\(indexPath.row)")
        }
        
        return cell
    }
    
    func updateDefaultImage(for cell: CountryTableViewCell, indexPathKey: String) {
        let defaultImage = UIImage(named: "Default")
        cell.cellImageView.image = defaultImage
        self.downloadedImageDictionary[indexPathKey] = defaultImage
    }
    
    
}


