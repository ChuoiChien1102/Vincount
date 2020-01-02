//
//  HistoryMemberViewController.swift
//  Vincount
//
//  Created by ChuoiChien on 3/19/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift
import RxSwift

class HistoryMemberViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    var eventEntity: EventEntity?
    var listPeople: [PeopleEntity]! = []
    var viewModelPeople: PeopleViewModel!
    
    private var compositeDisposable = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History Member"
        setupTableView()
        if eventEntity != nil {
            getListPeopleByEvent()
        }
    }
}

extension HistoryMemberViewController {
    private func setupTableView() {
        tableView.apply {
            $0.register(cellType: HistoryMemberTableViewCell.self)
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
        if listPeople.count > 0 {
            showHavedata()
        } else {
            showNodata()
        }
        tableView.reloadData()
    }

}

extension HistoryMemberViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HistoryMemberTableViewCell.self)
        let item = listPeople[indexPath.row]
        cell.bindData(people: item)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}

extension HistoryMemberViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HistoryDetailViewController.newInstance(people: listPeople[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

