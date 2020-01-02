//
//  ExpensesViewModel.swift
//  Vincount
//
//  Created by ChuoiChien on 3/17/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RxSwift

class ExpensesViewModel {
    
    typealias Dependency = ExpensesDatabase
    private let expensesDatabase: Dependency
    
    init(dependency: Dependency) {
        expensesDatabase = dependency
    }
    
    func addExpenses(expenses: ExpensesEntity, completion: () -> Void) {
        self.expensesDatabase.addExpenses(expenses: expenses) {
            completion()
        }
    }
    
    func updateExpenses(expenses: ExpensesEntity, completion: () -> Void) {
        self.expensesDatabase.updateExpenses(expenses: expenses) {
            completion()
        }
    }
    
    func listExpensesByEvent(owner: EventEntity) -> Observable<[ExpensesEntity]> {
        return self.expensesDatabase.listExpensesByEvent(owner: owner)
    }
    
    func deleteExpenses(id: String, completion: () -> Void) {
        self.expensesDatabase.deleteExpenses(id: id) {
            completion()
        }
    }
    
    func deleteExpensesByEvent(event: EventEntity, completion: () -> Void) {
        self.expensesDatabase.deleteExpensesByEvent(event:event) {
            completion()
        }
    }
}


