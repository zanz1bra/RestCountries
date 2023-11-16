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
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
        
        setupUI()
        populateData()
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(capitalLabel)
        view.addSubview(regionLabel)
        view.addSubview(flagLabel)
    }
    
    private func populateData() {
        if let countryDetails = countryDetails {
            nameLabel.text = "Country: \(countryDetails.name.common ?? "N/A")"
            capitalLabel.text = "\(countryDetails.name.common ?? "N/A") capital is \(countryDetails.capital ?? "N/A")"
            regionLabel.text = "Region: \(countryDetails.region ?? "N/A")"
            flagLabel.text = countryDetails.flag
            
        }
    }

}
