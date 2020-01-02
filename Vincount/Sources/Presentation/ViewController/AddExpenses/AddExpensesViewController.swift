//
//  AddExpensesViewController.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxRealm

struct People {
    var id: String
    var idExpensesOfPeople: String
    var name: String
    var oldPaid: Int
    var paid: Int
    var isSelected: Bool
    
    init(id: String, idExpensesOfPeople: String, name: String, oldPaid: Int, paid: Int, isSelected: Bool) {
        self.id = id
        self.idExpensesOfPeople = idExpensesOfPeople
        self.name = name
        self.oldPaid = oldPaid
        self.paid = paid
        self.isSelected = isSelected
    }
}

class AddExpensesViewController: UIViewController {
    enum EVENT_INDEX_ROW: Int {
        case TITLE = 0
        case TOTAL
        case DATE
        case PEOPLE_PAID
    }
    
    enum SESSION_INDEX: Int {
        case INFO_EXPENSIES = 0
        case INFO_MEMBER
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var eventEntity: EventEntity!
    var expensesEntity: ExpensesEntity?
    var viewModelExpenses: ExpensesViewModel!
    var viewModelPeople: PeopleViewModel!
    var viewModelExpensesOfPeople: ExpensesOfPeopleViewModel!
    var listPeopleEntity: [PeopleEntity]! = []
    var listExpensesOfPeopleEntity: [ExpenseOfPeopleEntity]! = []
    var listPeople: [People]! = []
    
    private var compositeDisposable = CompositeDisposable()
    
    var titleExpenses: String?
    var total: Int?
    var paidBy: PeopleEntity?
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if expensesEntity != nil {
            self.title = expensesEntity?.title
            getListExpensesOfPeople()
            self.bindData()
        } else {
            self.title = "Add Expenses"
            for item in listPeopleEntity {
                let people = People(id: item.id, idExpensesOfPeople: UUID().uuidString, name: item.name, oldPaid:0, paid: 0, isSelected: true)
                
                listPeople.append(people)
            }
            self.paidBy = listPeopleEntity[0]
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveExpenses))
        setupTableView()
        self.dissmissKeyboardWhenTapOutside()
    }
    
    @objc func saveExpenses(){
        if expensesEntity == nil {
            addExpenses()
        } else {
            updateExpenses()
        }
    }
}

extension AddExpensesViewController {
    private func setupTableView() {
        tableView.apply {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: InfoEventTableViewCell.self)
            $0.register(cellType: TotalTableViewCell.self)
            $0.register(cellType: DateTableViewCell.self)
            $0.register(cellType: PeoplePaidTableViewCell.self)
            $0.register(cellType: MemberPaidTableViewCell.self)
            $0.separatorStyle = .none
        }
    }
    
    private func bindData() {
        self.titleExpenses = expensesEntity?.title
        self.total = expensesEntity?.total
        self.date = (expensesEntity?.date)!
        self.paidBy = expensesEntity?.paidBy
        self.tableView.reloadData()
    }
    
    private func getListExpensesOfPeople() {
        for item in listPeopleEntity {
            viewModelExpensesOfPeople.listExpensesOfPeopleByExpensesAndPeople(expensesOwner: expensesEntity!, peopleOwner: item).subscribeBy(onNext: { [weak self] (listExpensesOfPeo) in

                let expensesOfPeo = listExpensesOfPeo.first
                if expensesOfPeo != nil {
                    let people = People(id: item.id, idExpensesOfPeople: (expensesOfPeo?.id)!, name: item.name, oldPaid:(expensesOfPeo?.total)!, paid: (expensesOfPeo?.total)!, isSelected: expensesOfPeo!.isSelected)
                    self!.listPeople.append(people)
                } else {
                    let people = People(id: item.id, idExpensesOfPeople: UUID().uuidString, name: item.name, oldPaid:0, paid: 0, isSelected: false)
                    self!.listPeople.append(people)
                }
                
            })
            .addTo(&compositeDisposable)
        }
    }
    
    private func validateShowMessage( completion:( _ error: String) -> Void) -> Bool {
        if titleExpenses == nil || titleExpenses == "" {
            completion("Title empty!")
            return false
        }
        if total == nil {
            completion("Total empty!")
            return false
        }
        var count = 0
        for item in listPeople {
            if item.isSelected {
                count = count + 1
            }
        }
        if count == 0 {
            completion("No Member Paid!")
            return false
        }
        return true
    }
    
    private func updateExpenses() {
        if validateShowMessage(completion: { (errorString) in
            //show message
            let alert = UIAlertController(title: "", message: errorString, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }) {
            let expesensUpdate = ExpensesEntity(id: (expensesEntity?.id)!, title: titleExpenses!, total: total!, paidBy: paidBy!, date: date, owner: eventEntity)
            viewModelExpenses.updateExpenses(expenses: expesensUpdate, completion: {
                for item in listPeople {
                    let peopleEntitys = listPeopleEntity.filter( {$0.id == item.id}).map({ return $0 })
                    // caculator balance
                    let  balance = (peopleEntitys.first?.balance)! - (item.paid - item.oldPaid)
                    let peopleUpdate = PeopleEntity(id: (peopleEntitys.first?.id)!, name: (peopleEntitys.first?.name)!, balance: balance, owner: eventEntity)
                    self.viewModelPeople.updatePeople(people: peopleUpdate, completion: {
                        let expensesOfPeopleUpdate = ExpenseOfPeopleEntity(id: item.idExpensesOfPeople, namePeople: item.name, nameExpenses: expesensUpdate.title, total: item.paid, date:expesensUpdate.date, isSelected: item.isSelected, peopleOwner: peopleUpdate, expenseOwner: expesensUpdate)
                        self.viewModelExpensesOfPeople.updateExpensesOfPeople(expensesOfPeople: expensesOfPeopleUpdate, completion: {
                            
                        })
                    })
                }
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    private func addExpenses() {
        if validateShowMessage(completion: { (errorString) in
            //show message
            let alert = UIAlertController(title: "", message: errorString, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }) {
            let strUUID = UUID().uuidString
            let expesensAdd = ExpensesEntity(id: strUUID, title: titleExpenses!, total: total!, paidBy: paidBy!, date: date, owner: eventEntity)
            viewModelExpenses.addExpenses(expenses: expesensAdd) { [weak self] in
                for item in listPeople {
                    let peopleEntitys = listPeopleEntity.filter( {$0.id == item.id}).map({ return $0 })
                    // caculator balance
                    let balance = (peopleEntitys.first?.balance)! - item.paid
                    let peopleUpdate = PeopleEntity(id: (peopleEntitys.first?.id)!, name: (peopleEntitys.first?.name)!, balance: balance, owner: eventEntity)
                    self!.viewModelPeople.updatePeople(people: peopleUpdate, completion: {
                        let expensesOfPeopleAdd = ExpenseOfPeopleEntity(id: item.idExpensesOfPeople, namePeople: item.name, nameExpenses: expesensAdd.title, total: item.paid, date:expesensAdd.date, isSelected: item.isSelected, peopleOwner: peopleUpdate, expenseOwner: expesensAdd)
                        self!.viewModelExpensesOfPeople.addExpensesOfPeople(expensesOfPeople: expensesOfPeopleAdd, completion: {
                            
                        })
                    })
                    
                }
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func caculatorBalance() -> Void {
        
    }
    
    func caculatorBill() -> Void {
        if total == nil {
            for i in 0...listPeople.count - 1 {
                listPeople[i].paid = 0
            }
            return
        }
        var count = 0
        for item in listPeople {
            if item.isSelected {
                count = count + 1
            }
        }
        for i in 0...listPeople.count - 1 {
            if listPeople[i].isSelected {
                listPeople[i].paid = total!/count
            } else {
                listPeople[i].paid = 0
            }
        }
    }
}

extension AddExpensesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension AddExpensesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case SESSION_INDEX.INFO_EXPENSIES.rawValue:
            return 4
        case SESSION_INDEX.INFO_MEMBER.rawValue:
            return listPeople.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        weak var weakSelf = self
        if indexPath.section == SESSION_INDEX.INFO_EXPENSIES.rawValue {
            switch indexPath.row {
            case EVENT_INDEX_ROW.TITLE.rawValue:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InfoEventTableViewCell.self)
                cell.textTitle = { titleExpense in
                    weakSelf?.titleExpenses = titleExpense
                }
                cell.textField.text = titleExpenses
                return cell
            case EVENT_INDEX_ROW.TOTAL.rawValue:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TotalTableViewCell.self)
                cell.textTotal = { total in
                    if total != nil && total != "" {
                        weakSelf?.total = Int(total!)
                    } else {
                        weakSelf?.total = 0
                    }
                    weakSelf?.caculatorBill()
                    tableView.reloadData()
                }
                if total != nil {
                    cell.textFieldTotal.text = String(total!)
                }
                return cell
            case EVENT_INDEX_ROW.DATE.rawValue:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DateTableViewCell.self)
                cell.textDate = { textDate in
                    weakSelf?.date = Date().convertStringToDate(stringDate: textDate!, "dd/MM/yyyy")
                    tableView.reloadData()
                }
                cell.lbDate.text = date.convertDateToString(date: date, "dd/MM/yyyy")
                cell.oldDate = date
                return cell
            case EVENT_INDEX_ROW.PEOPLE_PAID.rawValue:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PeoplePaidTableViewCell.self)
                cell.listPeople = listPeople
                cell.indexSelected = { index in
                    self.paidBy = self.listPeopleEntity[index!]
                    tableView.reloadData()
                }
                if expensesEntity != nil {
                    cell.oldSelected = listPeopleEntity.firstIndex(of: paidBy!)!
                }
                cell.binData()
                return cell
            default:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InfoEventTableViewCell.self)
                return cell
            }
        } else {
            
            // cell display member
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MemberPaidTableViewCell.self)
            let item = listPeople[indexPath.row]
            cell.bindData(people: item)
            cell.check = { isCheck in
                self.listPeople[indexPath.row].isSelected = isCheck
                self.caculatorBill()
                tableView.reloadData()
            }
            return cell
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
        case SESSION_INDEX.INFO_EXPENSIES.rawValue :
            return nil
        case SESSION_INDEX.INFO_MEMBER.rawValue:
            let viewSection = SessionView()
            viewSection.contentLabel.text = "Detail for member"
            return viewSection
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case SESSION_INDEX.INFO_EXPENSIES.rawValue :
            return 0
        case SESSION_INDEX.INFO_MEMBER.rawValue:
            return 30
        default:
            return 0
        }
    }
}
