//
//  ConfirmEventViewController.swift
//  Vincount
//
//  Created by ChuoiChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxRealm

class ConfirmEventViewController: UIViewController {
    enum EVENT_INDEX_ROW: Int {
        case TITLE = 0
        case DESCRIPTION
        case CURRENCY
    }
    
    enum SESSION_INDEX: Int {
        case INFO_EVENT = 0
        case INFO_MEMBER
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var eventEntity: EventEntity?
    var viewModelEvent: EventViewModel!
    var viewModelPeople: PeopleViewModel!
    var listNewPeople: [PeopleEntity]! = []
    var listOldPeople: [PeopleEntity]! = []
    
    private var compositeDisposable = CompositeDisposable()
    
    var titleEvent, descript, namePeople: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveEvent))
        setupTableView()
        self.dissmissKeyboardWhenTapOutside()
        if eventEntity != nil {
            getListPeopleByEvent()
            self.title = eventEntity?.title
        } else {
            self.title = "Add Event"
        }
    }
    
    @objc func saveEvent(){
        if eventEntity == nil {
            addEvent()
        } else {
            updateEvent()
        }
    }
}

extension ConfirmEventViewController {
    private func setupTableView() {
        tableView.apply {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: InfoEventTableViewCell.self)
            $0.register(cellType: DescriptionTableViewCell.self)
            $0.register(cellType: CurrencyTableViewCell.self)
            $0.register(cellType: AddPeopleTableViewCell.self)
            $0.register(cellType: PeopleTableViewCell.self)
            $0.separatorStyle = .none
        }
    }
    
    private func bindData() {
        self.titleEvent = eventEntity?.title
        self.descript = eventEntity?.descript
    }
    
    private func validateShowMessage( completion:( _ error: String) -> Void) -> Bool {
        if titleEvent == nil || titleEvent == "" {
            completion("Title empty!")
            return false
        }
        if descript == nil || descript == "" {
            completion("Description empty!")
            return false
        }
        if listNewPeople.count == 0 {
            completion("No Member!")
            return false
        }
        return true
    }
    
    private func updateEvent() {
        if validateShowMessage(completion: { (errorString) in
            //show message
            let alert = UIAlertController(title: "", message: errorString, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }) {
            let eventUpdate = EventEntity(id: (eventEntity?.id)!, title: titleEvent!, descript: descript!)
            viewModelEvent.updateEvent(event: eventUpdate) {
                for people in listOldPeople {
                    // delete old people
                    let list = listNewPeople.filter( {$0.id == people.id}).map({ return $0 })
                    if list.count == 0 {
                        viewModelPeople.deletePeople(id: people.id, completion: {
                            
                        })
                    }
                }
                for people in listNewPeople {
                    // add new people
                    let list = listOldPeople.filter( {$0.id == people.id}).map({ return $0 })
                    if list.count == 0 {
                        people.owner = eventUpdate
                        viewModelPeople.addPeople(people: people, completion: {

                        })
                    }
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func addEvent() {
        if validateShowMessage(completion: { (errorString) in
            //show message
            let alert = UIAlertController(title: "", message: errorString, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }) {
            let strUUID = UUID().uuidString
            
            let eventAdd = EventEntity(id: strUUID, title: titleEvent!, descript: descript!)
            viewModelEvent.addEvent(event: eventAdd) { [weak self] in
                for people in listNewPeople {
                    people.owner = eventAdd
                    viewModelPeople.addPeople(people: people, completion: {
                        
                    })
                }
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func getListPeopleByEvent() {
        let listPeopleDatabase = viewModelPeople.listPeopleByEvent(owner: eventEntity!)
        for item in listPeopleDatabase {
            let peo = PeopleEntity(id: item.id, name: item.name, balance: item.balance, owner: eventEntity)
            listNewPeople.append(peo)
            listOldPeople.append(peo)
        }
        bindData()
        tableView.reloadData()
    }
    
    private func validatePeopleShowMessage( completion:( _ error: String) -> Void) -> Bool {
        if namePeople == nil || namePeople == "" {
            completion("Name empty!")
            return false
        }
        return true
    }
    
    private func addPeople() {
        if validatePeopleShowMessage(completion: { (errorString) in
            //show message
            let alert = UIAlertController(title: "", message: errorString, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }) {
            let strUUID = UUID().uuidString
            let peopleAdd = PeopleEntity(id: strUUID, name: namePeople!, balance: 0, owner: nil)
            listNewPeople.append(peopleAdd)
            namePeople = ""
            tableView.reloadData()
        }
    }
}

extension ConfirmEventViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ConfirmEventViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case SESSION_INDEX.INFO_EVENT.rawValue:
            return 3
        case SESSION_INDEX.INFO_MEMBER.rawValue:
            return 1 + listNewPeople.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        weak var weakSelf = self
        if indexPath.section == SESSION_INDEX.INFO_EVENT.rawValue {
            switch indexPath.row {
            case EVENT_INDEX_ROW.TITLE.rawValue:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InfoEventTableViewCell.self)
                cell.textTitle = { titleEvent in
                    weakSelf?.titleEvent = titleEvent
                }
                cell.textField.text = titleEvent
                return cell
            case EVENT_INDEX_ROW.DESCRIPTION.rawValue:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DescriptionTableViewCell.self)
                cell.textDes = { desEvent in
                    weakSelf?.descript = desEvent
                }
                cell.textField.text = descript
                return cell
            case EVENT_INDEX_ROW.CURRENCY.rawValue:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CurrencyTableViewCell.self)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InfoEventTableViewCell.self)
                return cell
            }
        } else {
            
            // section INFO_MEMBER
            if indexPath.row < listNewPeople.count {
                // cell display member
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PeopleTableViewCell.self)
                let people = listNewPeople[indexPath.row]
                cell.bindData(people: people)
                cell.deletePeople = {
                    if people.balance < 0 {
                        //show alert
                        let alert = UIAlertController(title: "", message: "Member don't paid, can't delete", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else if people.balance > 0 {
                        //show alert
                        let alert = UIAlertController(title: "", message: "Member have balance, can't delete", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.listNewPeople.remove(at: indexPath.row)
                        self.tableView.reloadData()
                    }
                }
                return cell
            } else {
                // cell add member
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AddPeopleTableViewCell.self)
                cell.namePeople = { name in
                    weakSelf?.namePeople = name
                }
                cell.textFieldAdd.text = namePeople
                cell.addPeople = { name in
                    self.addPeople()
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case SESSION_INDEX.INFO_EVENT.rawValue :
            return nil
        case SESSION_INDEX.INFO_MEMBER.rawValue:
            let viewSection = SessionView()
            viewSection.contentLabel.text = "Participants"
            return viewSection
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case SESSION_INDEX.INFO_EVENT.rawValue :
            return 0
        case SESSION_INDEX.INFO_MEMBER.rawValue:
            return 30
        default:
            return 0
        }
    }
}
