//
//  CenterViewController.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 03.06.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class CenterViewController: ConfigurableTableViewController {
    
    var contacts = [User]()
    
    var isEditCrewActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.applyGradient()
        
        self.viewModel = FriendsListViewModel()
        
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.contacts = (self.viewModel as! FriendsListViewModel).createDummyContacts()
    }
    
    override func configureTableView() {
        
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.grouped)
        tableView.backgroundColor = AppConstants.Colors.TABLE_GRAY_BACKGROUND
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.alwaysBounceVertical = false
        tableView.isScrollEnabled = true
        tableView.tableHeaderView = nil
        tableView.tableFooterView = nil
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.sectionHeaderHeight = 20
        self.tableView.sectionFooterHeight = 0.01
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make -> Void in
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.tableView.register(FriendCell.self, forCellReuseIdentifier: String(describing: FriendCell.self))
        
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }

}

extension CenterViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension CenterViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.viewModel.section_headers.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FriendCell.self), for: indexPath) as? FriendCell
        if cell == nil {
            cell = FriendCell(style: UITableViewCellStyle.value1, reuseIdentifier: String(describing: FriendCell.self))
        }
        cell!.configure(contacts[indexPath.row])
        
        cell?.selectionStyle = .none
        
        if isEditCrewActive {
            cell!.startCellSelection()
        }else{
            cell!.endCellSelection()
        }
        return cell!
    }
}
