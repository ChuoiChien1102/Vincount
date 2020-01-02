//
//  Container+.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Swinject

extension Container {
    static let shareResolver = Assembler([
        
        //Base Assembly
        RealmAssembly(),
        EventDatabaseAssembly(),
        PeopleDatabaseAssembly(),
        ExpensesDatabaseAssembly(),
        ExpensesOfPeopleDatabaseAssembly(),
        
        //ViewController
        ListEventViewControllerAssembly(),
        ConfirmEventViewControllerAssembly(),
        DeleteViewControllerAssembly(),
        ListExpensesViewControllerAssembly(),
        AddExpensesViewControllerAssembly(),
        HistoryMemberViewControllerAssembly(),
        HistoryDetailViewControllerAssembly(),
        
        //ViewModel
        EventViewModelAssembly(),
        PeopleViewModelAssembly(),
        ExpensesViewModelAssembly(),
        ExpensesOfPeopleViewModelAssembly(),
        ]).resolver
}
