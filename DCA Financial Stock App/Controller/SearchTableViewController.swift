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
    private var searchResults: SearchResults?
    @Published private var searchQuery = String() // This is an observable, adding the "@Published" allows us to observe the searchQuerry variable (the searchBar) each time the value stored in it changes.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigationBar()
        //  performSearch()
        observeForm()
    }
    
    func setUpNavigationBar(){
        navigationItem.searchController = searchController
    }
    
    func observeForm() { // this function runs the API and the keyword is added here(the search bar text), this // means "searchQuery" is the keyword, the required company name eg tesla
        $searchQuery //observer
            //use this to delay calling the api for few seconds, the "RunLoop.main" will bring it to the main thread
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .sink { [unowned self] (searchQuery) in
                
                self.apiService.fetchSymbolsPublisher(keywords: searchQuery).sink { (completion) in
                    switch completion{  // errors from the API call is handled here
                    case .failure(let error) :
                        print(error.localizedDescription)
                    case .finished: break
                    }
                } receiveValue: { (result) in   // if API call is successful, it is handled here
                    self.searchResults = result
                    
                }.store(in: &self.subscribers) // add subscriber
                
            }.store(in: &subscribers) // subscriber
    }
    
    
    
    func  performSearch() {
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SearchTableViewCell
        
        cell.configure(with: <#T##SearchResult#>)
        return cell
    }
    
    
}

extension SearchTableViewController : UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text ,
              !searchQuery.isEmpty else {return}
        self.searchQuery = searchQuery // store the value from the local searchQuery into the global                                         //   self.searchQuery above
        
        
    }
    
    
}
