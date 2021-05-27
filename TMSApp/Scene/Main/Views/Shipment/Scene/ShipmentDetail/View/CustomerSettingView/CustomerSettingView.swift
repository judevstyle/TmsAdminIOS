//
//  CustomerSettingView.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/21/21.
//

import UIKit

protocol CustomerSettingViewDelegate {
    func didSelectSettingRowAt(_ tableView: UITableView, indexPath: IndexPath)
}

class CustomerSettingView: UIView {
    
    static let identifier = "CustomerSettingView"

    @IBOutlet weak var tableView: UITableView!
    
    private var listSetting = [(iconName:String, title: String)]()
    
    public var delegate: CustomerSettingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        registerCell()
        self.listSetting.append((iconName: "eye.fill", title: "รายละเอียด"))
        self.listSetting.append((iconName: "pencil", title: "แก้ไข"))
        self.listSetting.append((iconName: "trash.fill", title: "ลบ"))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed(CustomerSettingView.identifier, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}

extension CustomerSettingView {
    fileprivate func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableViewRegister(identifier: CustomerSettingTableViewCell.identifier)
    }
    
    fileprivate func tableViewRegister(identifier: String) {
        self.tableView.register(UINib.init(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
    }
}


extension CustomerSettingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSettingRowAt(tableView, indexPath: indexPath)
    }
}

extension CustomerSettingView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listSetting.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomerSettingTableViewCell.identifier, for: indexPath) as! CustomerSettingTableViewCell
        cell.iconName = self.listSetting[indexPath.item].iconName
        cell.title = self.listSetting[indexPath.item].title
        if (self.listSetting.count - 1) == indexPath.item {
            cell.setHidelineUnderBottom(isHidden: true)
        }else {
            cell.setHidelineUnderBottom(isHidden: false)
        }
        return cell
    }
}
