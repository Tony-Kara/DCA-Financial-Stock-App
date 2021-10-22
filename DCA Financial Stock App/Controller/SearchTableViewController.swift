//
//  ViewController.swift
//  DCA Financial Stock App
//
//  Created by mac on 8/15/21.
//

import UIKit
import Combine
import MBProgressHUD // this library provides loading animation

class SearchTableViewController: UITableViewController, UIAnimatable {

    private enum Mode {
        case onboarding
        case search
    }
    
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
    // we want to listen to the mode to dertermine if it is in search mode or onboarding
    @Published private var mode: Mode = .onboarding
    private var searchResults: SearchResults?
    @Published private var searchQuery = String() // This is an observable, adding the "@Published" allows us to observe the searchQuerry variable (the searchBar) each time the value stored in it changes.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavigationBar()
        setupTableView()
        observeForm()
    }
    
    func setUpNavigationBar(){
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
    }
    
    
    func setupTableView() {
        
        tableView.tableFooterView = UIView() // this will take off the horizontal lines inside the tableview
    }
    
    func observeForm() { // this function runs the API and the keyword is added here(the search bar text), this // means "searchQuery" is the keyword, the required company name eg tesla
        $searchQuery //searchQuery is observable, so we can use the property with the $ sysmbol
            //use this to delay calling the api for few seconds, the "RunLoop.main" will bring it to the main thread
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .sink { [unowned self] (searchQuery) in
                guard !searchQuery.isEmpty else {return}
               showLoadingAnimation()
                self.apiService.fetchSymbolsPublisher(keywords: searchQuery).sink { (completion) in
                  hideLoadingAnimation()
                    switch completion{  // errors from the API call is handled here
                    case .failure(let error) :
                        print(error.localizedDescription)
                    case .finished: break
                    }
                } receiveValue: { (result) in   // if API call is successful, it is handled here
                    self.searchResults = result // this is from the struct at the higher hierachy, SearchResults //and not SearchResult
                    self.tableView.reloadData()
                }.store(in: &self.subscribers) // add subscriber
             }.store(in: &subscribers) // subscriber
        
        $mode.sink { (mode) in
            
            switch mode {
            case  .onboarding:
                self.tableView.backgroundView = SearchPlaceHolder()
            case .search:
                self.tableView.backgroundView = nil
            }
        }.store(in: &subscribers)
        
    }
    
    
 
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SearchTableViewCell
        
        if let searchResults = self.searchResults {
            let searchResult = searchResults.items[indexPath.row]
            cell.configure(with: searchResult)
        }
       
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let searchResults = self.searchResults{
            let symbol = searchResults.items[indexPath.item].symbol // fetch the symbol at the currrent index path
            handleSelection(for: symbol)
        }
    }
    
    
    private func handleSelection(for symbol: String){
        
        apiService.fetchTimeSeriesMonthlyAdjustedPublisher(keywords: symbol).sink { (CompletionResult) in
            switch CompletionResult{
            case .failure(let error):
                print(error)
            case .finished: break
            }
        } receiveValue: { (timeSeriesMonthlyAdjusted) in
            print("success: \(timeSeriesMonthlyAdjusted.getMonthInfos())")
        }.store(in: &subscribers)

        
        
        // performSegue(withIdentifier: "showCalculator", sender: nil)
    }
    
    
    
}

extension SearchTableViewController : UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text ,
              !searchQuery.isEmpty else {return}
        self.searchQuery = searchQuery // store the value from the local searchQuery into the global                                         //   self.searchQuery above
        
        
    }
    
    
    func willPresentSearchController(_ searchController: UISearchController) {
        mode = .search  // Here, you can run codes of what should happen after the user clicks on the search bar
    }
    
}
