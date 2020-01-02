//
//  ExpenseOfPeopleEntity.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RealmSwift

class ExpenseOfPeopleEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var namePeople: String = ""
    @objc dynamic var nameExpenses: String = ""
    @objc dynamic var total: Int = 0
    @objc dynamic var date = Date()
    @objc dynamic var isSelected: Bool = false
    @objc dynamic var peopleOwner:  PeopleEntity?
    @objc dynamic var expenseOwner:  ExpensesEntity?
    
    convenience init(id: String, namePeople: String, nameExpenses: String, total: Int, date: Date, isSelected: Bool, peopleOwner: PeopleEntity?, expenseOwner: ExpensesEntity?) {
        self.init()
        self.id = id
        self.namePeople = namePeople
        self.nameExpenses = nameExpenses
        self.total = total
        self.date = date
        self.isSelected = isSelected
        self.peopleOwner = peopleOwner
        self.expenseOwner = expenseOwner
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
