//
//  GlobalCovidTrackerController.swift
//  Covid Watch
//
//  Created by Abraham Estrada on 4/20/21.
//

import UIKit
import SwiftyJSON

private let cellIdentifier = "cell"
private let headerIdentifier = "header"

class GlobalCovidTrackerController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var globalData: Country? = nil
    private var countriesData = [Country]()
    private var filteredCountriesData = [Country]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "COVID-19 Watch"
        collectionView.backgroundColor = .black
        
        configureSearchController()
        
        fetchCovidData()

        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(TrackerHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    // MARK: - API
    
    func fetchCovidData() {
        CovidDataService.fetchCovidData { (covidData, error) in
            guard let covidData = covidData else {return}
            CovidDataService.fetchVaccineData { (vaccineData, error) in
                guard let vaccineData = vaccineData else {return}
                for country in COUNTRIES {
                    self.countriesData.append(Country(named: country, covidData: covidData, vaccineData: vaccineData))
                }
                self.globalData = Country(named: "Global", covidData: covidData, vaccineData: vaccineData)
                self.countriesData = self.countriesData.filter{$0.population != "0"}
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Helpers

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search by country"
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

// MARK: - UICollectionViewDataSource

extension GlobalCovidTrackerController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredCountriesData.count : countriesData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CountryCell
        cell.country = inSearchMode ? filteredCountriesData[indexPath.row] : countriesData[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TrackerHeader
        header.country = globalData
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GlobalCovidTrackerController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = CountryTrackerController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.country = inSearchMode ? filteredCountriesData[indexPath.row] : countriesData[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension GlobalCovidTrackerController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = nil
    }
}


// MARK: - UISearchResultsUpdating

extension GlobalCovidTrackerController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        filteredCountriesData = countriesData.filter({$0.name.contains(searchText) || $0.name.lowercased().contains(searchText)})
        self.collectionView.reloadData()
    }
}
