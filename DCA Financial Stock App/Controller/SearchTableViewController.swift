//
//  ViewController.swift
//  DCA Financial Stock App
//
//  Created by mac on 8/15/21.
//

import UIKit
import Combine

class SearchTableViewController: UITableViewController {

    private lazy  var searchController : UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter a company name or symbol"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    
    private let apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigationBar()
        performSearch()
    }

    func setUpNavigationBar(){
        navigationItem.searchController = searchController
    }
    
    func  performSearch() {
        apiService.fetchSymbolsPublisher(keywords: "S&P500").sink { (completion) in
            switch completion{  // errors from the API call is handled here
            case .failure(let error) :
                print(error.localizedDescription)
            case .finished: break
            }
        } receiveValue: { (searchResults) in   // if API call is successful, it is handled here
            print(searchResults)
        }.store(in: &subscribers) // add subscriber

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
    

}

extension SearchTableViewController : UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
