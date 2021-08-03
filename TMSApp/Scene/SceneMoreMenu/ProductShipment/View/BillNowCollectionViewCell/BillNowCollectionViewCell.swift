//
//  BillNowCollectionViewCell.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/4/21.
//

import UIKit

class BillNowCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BillNowCollectionViewCell"

    @IBOutlet var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTableView()
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.registerCell(identifier: BillNowTableViewCell.identifier)
    }

}

extension BillNowCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BillNowTableViewCell.identifier, for: indexPath) as! BillNowTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
}
