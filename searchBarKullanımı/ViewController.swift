
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBarMy: UISearchBar!
    
    @IBOutlet weak var tableViewMy: UITableView!
    
    var county = [String]()

    var searchResultCountries = [String]() //array holding wanted
    
    var areYouMakingaCall = false // assessment of the situation
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchBarMy.delegate = self
        searchBarMy.scopeButtonTitles = ["1.title","2.title"]
        tableViewMy.dataSource = self
        tableViewMy.delegate = self
        
        county = ["Turkiye","Polonya","Afrika","Hollanda","Japonya","Rusya","ABD","Maceristan"]
        
        
        
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Our condition was used in all methods. We said list the first or second array depending on the situation.
        if areYouMakingaCall == true {
            
            return searchResultCountries.count
        }
        else{
            return county.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewID", for: indexPath)
        if areYouMakingaCall == true {
            
            cell.textLabel?.text = searchResultCountries[indexPath.row]
        }
        else{
            cell.textLabel?.text = county[indexPath.row]
        }
      
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if areYouMakingaCall == true {
            
            print("secılen ulke \(searchResultCountries[indexPath.row])")
        }
        else{
            print("secılen ulke \(county[indexPath.row])")
        }
        
    }
}

// For SearchBar

extension ViewController: UISearchBarDelegate{
    
    // method that returns the result when a call is made
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText  : data received user
        
        print("search result \(searchText)")
        
        
        if searchText == "" {
            areYouMakingaCall = false
        }else{
            areYouMakingaCall = true
        }
        
        
        // searchResultCountries :The process of throwing new data into the second array according to the search
        searchResultCountries = county.filter({$0.lowercased().contains(searchText.lowercased())})
        
        //to update the tableView continuously
        tableViewMy.reloadData()
    }

}

