//
//  ListEventViewController.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift
import RxSwift

class ListEventViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    var viewModelEvent: EventViewModel!
    var viewModelPeople: PeopleViewModel!
    
    private var listEvent: [EventEntity] = []
    private var compositeDisposable = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Event"
        setupTableView()
        getListEvent()
    }
    
    @IBAction func invokedAdd(_ sender: Any) {
        let vc = ConfirmEventViewController.newInstance()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListEventViewController {
    private func setupTableView() {
        tableView.apply {
            $0.register(cellType: EventTableViewCell.self)
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
    
    func getListEvent() {
        viewModelEvent.listEvent().subscribeBy(onNext: { [weak self] (listEvent) in
            self?.listEvent = listEvent
            self?.tableView.reloadData()
            if listEvent.count > 0 {
                self?.showHavedata()
            } else {
                self?.showNodata()
            }
        })
            .addTo(&compositeDisposable)
    }
    
    private func gotoEditEvent(_ event : EventEntity) {
        let vc = ConfirmEventViewController.newInstance(event: event)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func gotoDeleteEvent(_ event : EventEntity, atIndex: Int) {
        let vc = DeleteViewController.newInstance()
        vc.okHandler = {
            self.viewModelEvent.deleteEvent(id: event.id) {
                self.listEvent.remove(at: atIndex)
                self.tableView.reloadData()
            }
            vc.dismiss(animated: false, completion: nil)
        }
        self.present(vc, animated: false, completion: nil)
    }
}

extension ListEventViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EventTableViewCell.self)
        let event = listEvent[indexPath.row]
        cell.bindData(event: event)
        
        weak var weakSelf = self
        
        cell.editEvent = {
            weakSelf?.gotoEditEvent(event)
        }
        cell.deleteEvent = {
            weakSelf?.gotoDeleteEvent(event, atIndex: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}

extension ListEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = listEvent[indexPath.row]
        let listExpensesVC = ListExpensesViewController.newInstance(event: event)
        self.navigationController?.pushViewController(listExpensesVC, animated: true)
    }
}
