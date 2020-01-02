//
//  ExpensesEntity.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RealmSwift

class ExpensesEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var total: Int = 0
    @objc dynamic var paidBy: PeopleEntity?
    @objc dynamic var date = Date()
    @objc dynamic var owner:  EventEntity?
    
    let expensesOfPeoples = LinkingObjects(fromType: ExpenseOfPeopleEntity.self, property: "expenseOwner")
    
    convenience init(id: String, title: String, total: Int, paidBy: PeopleEntity, date: Date, owner: EventEntity) {
        self.init()
        self.id = id
        self.title = title
        self.total = total
        self.paidBy = paidBy
        self.date = date
        self.owner = owner
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

