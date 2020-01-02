//
//  ExpensesOfPeopleViewModel.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/18/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RxSwift

class ExpensesOfPeopleViewModel {
    
    typealias Dependency = ExpensesOfPeopleDatabase
    private let expensesOfPeopleDatabase: Dependency
    
    init(dependency: Dependency) {
        expensesOfPeopleDatabase = dependency
    }
    
    func addExpensesOfPeople(expensesOfPeople: ExpenseOfPeopleEntity, completion: () -> Void) {
        self.expensesOfPeopleDatabase.addExpensesOfPeople(expensesOfPeo: expensesOfPeople) {
            completion()
        }
    }
    
    func updateExpensesOfPeople(expensesOfPeople: ExpenseOfPeopleEntity, completion: () -> Void) {
        self.expensesOfPeopleDatabase.updateExpensesOfPeople(expensesOfPeo: expensesOfPeople) {
            completion()
        }
    }
    
    func listExpensesOfPeopleByPeople(owner: PeopleEntity) -> [ExpenseOfPeopleEntity] {
        return self.expensesOfPeopleDatabase.listExpensesOfPeopleByPeople(owner: owner)
    }
    
    func listExpensesOfPeopleByExpenses(owner: ExpensesEntity) -> Observable<[ExpenseOfPeopleEntity]> {
        return self.expensesOfPeopleDatabase.listExpensesOfPeopleByExpenses(owner: owner)
    }
    
    func listExpensesOfPeopleByExpensesAndPeople(expensesOwner: ExpensesEntity, peopleOwner: PeopleEntity) -> Observable<[ExpenseOfPeopleEntity]> {
        return self.expensesOfPeopleDatabase.listExpensesOfPeopleByExpensesAndPeople(expensesOwner: expensesOwner, peopleOwner: peopleOwner)
    }
    
    func deleteExpensesOfPeople(id: String, completion: () -> Void) {
        self.expensesOfPeopleDatabase.deleteExpensesOfPeople(id: id) {
            completion()
        }
    }
    
    func deleteExpensesOfPeopleByExpenses(expenses: ExpensesEntity, completion: () -> Void) {
        self.expensesOfPeopleDatabase.deleteExpensesOfPeopleByExpenses(expenses: expenses) {
            completion()
        }
    }
}



