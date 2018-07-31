//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

private let maxVisibleContentHeight: CGFloat = 400

private let numberOfCountries = 20
private let countries = Locale.isoRegionCodes.prefix(numberOfCountries).map(Locale.current.localizedString(forRegionCode:))
private let reuseIdentifier = "cell"

class CountriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.contentInset.top = maxVisibleContentHeight
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        cell.textLabel?.text = countries[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
