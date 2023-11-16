//
//  ViewController.swift
//  RestCountries
//
//  Created by erika.talberga on 15/11/2023.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    
    private let cellID = "cell"
    private let countryAllUrl = "https://restcountries.com/v3.1/all"
    private var countries: [CountryDetails] = []
    private var searchController: UISearchController! // Add search bar
    private var filteredCountries: [CountryDetails] = []
    private var isSearchActive: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.setupView()
        
        NetworkManager.fetchData(url: countryAllUrl){
            countries in
            
            // Sort countries alphabetically
            self.countries = countries.sorted {$0.name.common ?? "" < $1.name.common ?? ""}
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
//        Set up Long Press Gesture
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        tableView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                showCountryDetails(for: indexPath.row)
            }
        }
    }
    
    private func setupView(){
        view.backgroundColor = .secondarySystemBackground
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: cellID)
        setupNavigationBar()
        
        // Initialize search controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search country..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(searchController.searchBar.text!)
    }
    
    private func filterContentForSearch(_ searchText: String) {
        filteredCountries = countries.filter {
            if let commonName = $0.name.common {
                return commonName.lowercased().contains(searchText.lowercased())
            } else {
                return false
            }
        }
        tableView.reloadData()
    }
    
    private func setupNavigationBar(){
        
        self.title = "Countries"
        let titleImage = UIImage(systemName: "mappin.and.ellipse")
        let imageView = UIImageView(image:titleImage)
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.label]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.label]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .label
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredCountries.count : countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for:indexPath  as IndexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        
        let country: CountryDetails
        if isSearchActive {
            country = filteredCountries[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        
        cell.textLabel?.text = country.name.common
        cell.detailTextLabel?.text = country.name.official
        
        return cell
    }
    
    func showCountryDetails(for index: Int) {
        let country: CountryDetails
        
        if isSearchActive {
            country = filteredCountries[index]
        } else {
            country = countries[index]
        }
        
        let countryDetailsVC = DetailViewController()
        countryDetailsVC.countryDetails = country
        
        present(countryDetailsVC, animated: true, completion: nil)
    }
    
    
}
