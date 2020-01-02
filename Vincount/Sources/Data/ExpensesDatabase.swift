//
//  ExpensesDatabase.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol ExpensesDatabase {
    func addExpenses(expenses: ExpensesEntity, completion: () -> Void)
    func updateExpenses(expenses: ExpensesEntity, completion: () -> Void)
    func deleteExpenses(id: String, completion: () -> Void)
    func listExpensesByEvent(owner: EventEntity) -> Observable<[ExpensesEntity]>
    func deleteExpensesByEvent(event: EventEntity, completion: () -> Void)
}

class ExpensesDatabaseImpl: ExpensesDatabase {
    
    typealias Dependency = Realm
    private let realm: Realm
    init(dependency: Dependency) {
        realm = dependency
    }
    
    func listExpensesByEvent(owner: EventEntity) -> Observable<[ExpensesEntity]> {
        return Observable.changeset(from: realm.objects(ExpensesEntity.self).filter(NSPredicate(format: "owner == %@", owner))).map({ (result, _ ) -> [ExpensesEntity] in
            return result.toArray()
        })
    }
    
    func addExpenses(expenses: ExpensesEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.add(expenses, update: false)
        }, completion: {
            completion()
        })
    }
    
    func updateExpenses(expenses: ExpensesEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.add(expenses, update: true)
        }, completion: {
            completion()
        })
    }
    
    func deleteExpenses(id: String, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.delete(realm.objects(ExpensesEntity.self).filter("id == %@", id))
        }, completion: {
            completion()
        })
    }
    
    func deleteExpensesByEvent(event: EventEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.delete(realm.objects(ExpensesEntity.self).filter("owner == %@", event))
        }, completion: {
            completion()
        })
    }
}


