//
//  DetailViewController.swift
//  RestCountries
//
//  Created by erika.talberga on 16/11/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    var countryDetails: CountryDetails?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var flagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 200)
        return label
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray2
        
        setupUI()
        populateData()
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(capitalLabel)
        view.addSubview(regionLabel)
        view.addSubview(flagLabel)
        
        // Constraints for flagLabel
        flagLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flagLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        // Constraints for nameLabel
        nameLabel.topAnchor.constraint(equalTo: flagLabel.bottomAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Athelas Bold", size: 25)
        
        // Constraints for capitalLabel
        capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        capitalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        capitalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        capitalLabel.textAlignment = .center
        capitalLabel.font = UIFont(name: "Athelas Regular", size: 20)
        
        // Constraints for regionLabel
        regionLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 10).isActive = true
        regionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        regionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        regionLabel.textAlignment = .center
        regionLabel.font = UIFont(name: "Athelas Regular", size: 20)
    }
    
    private func populateData() {
        if let countryDetails = countryDetails {
            nameLabel.text = "Country: \(countryDetails.name.common ?? "N/A")"
            capitalLabel.text = "\(countryDetails.name.common ?? "N/A") capital is \(String(describing: countryDetails.capital))"
            regionLabel.text = "Region: \(countryDetails.region ?? "N/A")"
            flagLabel.text = countryDetails.flag
            
        }
    }
    
}
