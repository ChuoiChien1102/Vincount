//
//  ListExpensesViewController.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift
import RxSwift

class ListExpensesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    var eventEntity: EventEntity?
    var listPeople: [PeopleEntity]! = []
    var viewModelPeople: PeopleViewModel!
    var viewModelExpenses: ExpensesViewModel!
    
    private var listExpenses: [ExpensesEntity] = []
    private var compositeDisposable = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "History Member", style: .plain, target: self, action: #selector(showHistoryMember))
        self.title = eventEntity?.title
        setupTableView()
        getListExpensesByEvent()
        if eventEntity != nil {
            getListPeopleByEvent()
        }
    }
    
    @objc func showHistoryMember(){
        let vc = HistoryMemberViewController.newInstance(event: eventEntity)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func invokedAdd(_ sender: Any) {
        
        let vc = AddExpensesViewController.newInstance(expenses: nil, listPeople: listPeople, event: eventEntity!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListExpensesViewController {
    private func setupTableView() {
        tableView.apply {
            $0.register(cellType: ExpensesTableViewCell.self)
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
    
    func getListPeopleByEvent() {
        listPeople = viewModelPeople.listPeopleByEvent(owner: eventEntity!)
        tableView.reloadData()
    }
    
    func getListExpensesByEvent() {
        viewModelExpenses.listExpensesByEvent(owner: eventEntity!)
            .subscribeBy(onNext: { [weak self] (listExpenses) in
                self?.listExpenses = listExpenses
                self?.tableView.reloadData()
                if listExpenses.count > 0 {
                    self?.showHavedata()
                } else {
                    self?.showNodata()
                }
            })
            .addTo(&compositeDisposable)
    }
    
    private func gotoEditExpenses(_ expenses : ExpensesEntity) {
        let vc = AddExpensesViewController.newInstance(expenses: expenses, listPeople: listPeople, event: eventEntity!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func gotoDeleteExpenses(_ expenses : ExpensesEntity, atIndex: Int) {
        let vc = DeleteViewController.newInstance()
        vc.okHandler = {
            //delete Expenses
            self.viewModelExpenses.deleteExpenses(id: expenses.id) {
                self.listExpenses.remove(at: atIndex)
                self.tableView.reloadData()
            }
            vc.dismiss(animated: false, completion: nil)
        }
        self.present(vc, animated: false, completion: nil)
    }
}

extension ListExpensesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ExpensesTableViewCell.self)
        let item = listExpenses[indexPath.row]
        cell.bindData(expenses: item)
        weak var weakSelf = self
        
        cell.editExpenses = {
            weakSelf?.gotoEditExpenses(item)
        }
        cell.deleteExpenses = {
            weakSelf?.gotoDeleteExpenses(item, atIndex: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}

extension ListExpensesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
