//
//  HistoryDetailViewController.swift
//  Vincount
//
//  Created by ChuoiChien on 3/19/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift
import RxSwift

class HistoryDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    var peopleEntity: PeopleEntity?
    var viewModelExpensesOfPeople: ExpensesOfPeopleViewModel!
    var listExpensesOfPeopleEntity: [ExpenseOfPeopleEntity]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = peopleEntity?.name
        setupTableView()
        if peopleEntity != nil {
            getListExpensesOfPeople()
        }
    }
}

extension HistoryDetailViewController {
    private func setupTableView() {
        tableView.apply {
            $0.register(cellType: HistoryDetailTableViewCell.self)
            $0.dataSource = self
            $0.delegate = self
            $0.separatorStyle = .none
        }
    }
    
    func showNodata() -> Void {
        containerView.isHidden = false
        tableView.isHidden = true
    }
    
    func showHavedata() -> Void {
        containerView.isHidden = true
        tableView.isHidden = false
    }
    
    private func getListExpensesOfPeople() {
        listExpensesOfPeopleEntity = viewModelExpensesOfPeople.listExpensesOfPeopleByPeople(owner: peopleEntity!)
        tableView.reloadData()
    }
}

extension HistoryDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listExpensesOfPeopleEntity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HistoryDetailTableViewCell.self)
        let item = listExpensesOfPeopleEntity[indexPath.row]
        cell.bindData(expenseOfPeople: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}

extension HistoryDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

