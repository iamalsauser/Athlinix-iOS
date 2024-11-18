//
//  ViewController.swift
//  MatchHistory
//
//  Created by admin65 on 14/11/24.
//

import UIKit

class kitViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var matches: [Matchkit] = []
    var filteredMatches: [Matchkit] = [] // Array for search results

    func createDate(day: Int, month: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        let calendar = Calendar.current
        return calendar.date(from: dateComponents) ?? Date()
    }

    override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            searchBar.delegate = self // Set searchBar delegate

            // Initialize sample data
            matches = [
                Matchkit(
                    homeTeamLogo: UIImage(named: "lakers")!,
                    awayTeamLogo: UIImage(named: "warriors")!,
                    homeTeamName: "76ers",
                    awayTeamName: "Raptors",
                    fieldGoals: (34, 24),
                    threePointers: (10, 7),
                    freeThrows: (6, 3),
                    date: createDate(day: 10, month: 9, year: 2024)
                ),
                Matchkit(
                    homeTeamLogo: UIImage(named: "lakers")!,
                    awayTeamLogo: UIImage(named: "cavs")!,
                    homeTeamName: "Lakers",
                    awayTeamName: "Knicks",
                    fieldGoals: (47, 47),
                    threePointers: (10, 7),
                    freeThrows: (6, 3),
                    date: createDate(day: 18, month: 8, year: 2022)
                )
            ]
        filteredMatches = matches

        }
    
    // MARK: - Search Functionality
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filteredMatches = matches // Show all matches if search text is empty
            } else {
                filteredMatches = matches.filter { match in
                    match.homeTeamName.lowercased().contains(searchText.lowercased()) ||
                    match.awayTeamName.lowercased().contains(searchText.lowercased())
                }
            }
            tableView.reloadData() // Refresh table view with the filtered data
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            filteredMatches = matches // Reset to show all matches
            tableView.reloadData()
            searchBar.resignFirstResponder() // Dismiss the keyboard
        }
    
        // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //return matches.count
        return filteredMatches.count

        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
            let match = filteredMatches[indexPath.row]
//            let match = matches[indexPath.row]
            
            // Configure cell with match data
            cell.configure(with: match)
            
            return cell
        }
    }




