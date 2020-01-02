//
//  ExpensesOfPeopleDatabase.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol ExpensesOfPeopleDatabase {
    func addExpensesOfPeople(expensesOfPeo: ExpenseOfPeopleEntity, completion: () -> Void)
    func updateExpensesOfPeople(expensesOfPeo: ExpenseOfPeopleEntity, completion: () -> Void)
    func deleteExpensesOfPeople(id: String, completion: () -> Void)
    func listExpensesOfPeopleByPeople(owner: PeopleEntity) -> [ExpenseOfPeopleEntity]
    func listExpensesOfPeopleByExpenses(owner: ExpensesEntity) -> Observable<[ExpenseOfPeopleEntity]>
    func listExpensesOfPeopleByExpensesAndPeople(expensesOwner: ExpensesEntity, peopleOwner: PeopleEntity) -> Observable<[ExpenseOfPeopleEntity]>
    func deleteExpensesOfPeopleByExpenses(expenses: ExpensesEntity, completion: () -> Void)
}

class ExpensesOfPeopleDatabaseImpl: ExpensesOfPeopleDatabase {
    
    typealias Dependency = Realm
    private let realm: Realm
    init(dependency: Dependency) {
        realm = dependency
    }
    
    func listExpensesOfPeopleByPeople(owner: PeopleEntity) -> [ExpenseOfPeopleEntity] {
        let objects = realm.objects(ExpenseOfPeopleEntity.self).filter(NSPredicate(format: "peopleOwner == %@", owner))
        return objects.toArray()
    }
    
    func listExpensesOfPeopleByExpenses(owner: ExpensesEntity) -> Observable<[ExpenseOfPeopleEntity]> {
        return Observable.changeset(from: realm.objects(ExpenseOfPeopleEntity.self).filter(NSPredicate(format: "expenseOwner == %@", owner))).map({ (result, _ ) -> [ExpenseOfPeopleEntity] in
            return result.toArray()
        })
    }
    
    func listExpensesOfPeopleByExpensesAndPeople(expensesOwner: ExpensesEntity, peopleOwner: PeopleEntity) -> Observable<[ExpenseOfPeopleEntity]> {
        return Observable.changeset(from: realm.objects(ExpenseOfPeopleEntity.self).filter(NSPredicate(format: "expenseOwner == %@ AND peopleOwner == %@", expensesOwner, peopleOwner))).map({ (result, _ ) -> [ExpenseOfPeopleEntity] in
            return result.toArray()
        })
    }
    
    func addExpensesOfPeople(expensesOfPeo: ExpenseOfPeopleEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.add(expensesOfPeo, update: false)
        }, completion: {
            completion()
        })
    }
    
    func updateExpensesOfPeople(expensesOfPeo: ExpenseOfPeopleEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.add(expensesOfPeo, update: true)
        }, completion: {
            completion()
        })
    }
    
    func deleteExpensesOfPeople(id: String, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.delete(realm.objects(ExpenseOfPeopleEntity.self).filter("id == %@", id))
        }, completion: {
            completion()
        })
    }
    
    func deleteExpensesOfPeopleByExpenses(expenses: ExpensesEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.delete(realm.objects(ExpenseOfPeopleEntity.self).filter("expenseOwner == %@", expenses))
        }, completion: {
            completion()
        })
    }
}



