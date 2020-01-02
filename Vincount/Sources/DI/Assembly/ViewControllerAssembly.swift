//
//  ViewControllerAssembly.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import Swinject

final class ListEventViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ListEventViewController.self) { _ in
            return StoryboardScene.Main.listEventViewController.instantiate()
        }
    }
}

extension ListEventViewController {
    static func newInstance() -> ListEventViewController {
        let vc =  Container.shareResolver.resolve(ListEventViewController.self)!
        vc.viewModelEvent = Container.shareResolver.resolve(EventViewModel.self)
        vc.viewModelPeople = Container.shareResolver.resolve(PeopleViewModel.self)
        return vc
    }
}

final class ConfirmEventViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ConfirmEventViewController.self) { _ in
            let vc = StoryboardScene.Main.confirmEventViewController.instantiate()
            vc.viewModelEvent = Container.shareResolver.resolve(EventViewModel.self)
            vc.viewModelPeople = Container.shareResolver.resolve(PeopleViewModel.self)
            return vc
        }
    }
}

extension ConfirmEventViewController {
    static func newInstance(event: EventEntity? = nil) -> ConfirmEventViewController {
        let vc = Container.shareResolver.resolve(ConfirmEventViewController.self)!
        vc.eventEntity = event
        return vc
    }
}

final class DeleteViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DeleteViewController.self) { _ in
            let vc = StoryboardScene.Main.deleteViewController.instantiate()
            return vc
        }
    }
}

extension DeleteViewController {
    static func newInstance() -> DeleteViewController {
        let vc =  Container.shareResolver.resolve(DeleteViewController.self)!
        return vc
    }
}

final class ListExpensesViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ListExpensesViewController.self) { _ in
            return StoryboardScene.Main.listExpensesViewController.instantiate()
        }
    }
}

extension ListExpensesViewController {
    static func newInstance(event: EventEntity? = nil) -> ListExpensesViewController {
        let vc =  Container.shareResolver.resolve(ListExpensesViewController.self)!
        vc.eventEntity = event
        vc.viewModelExpenses = Container.shareResolver.resolve(ExpensesViewModel.self)
        vc.viewModelPeople = Container.shareResolver.resolve(PeopleViewModel.self)
        return vc
    }
}

final class AddExpensesViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AddExpensesViewController.self) { _ in
            let vc = StoryboardScene.Main.addExpensesViewController.instantiate()
            vc.viewModelExpenses = Container.shareResolver.resolve(ExpensesViewModel.self)
            vc.viewModelPeople = Container.shareResolver.resolve(PeopleViewModel.self)
            vc.viewModelExpensesOfPeople = Container.shareResolver.resolve(ExpensesOfPeopleViewModel.self)
            return vc
        }
    }
}

extension AddExpensesViewController {
    static func newInstance(expenses: ExpensesEntity? = nil, listPeople: [PeopleEntity]? = nil, event: EventEntity) -> AddExpensesViewController {
        let vc = Container.shareResolver.resolve(AddExpensesViewController.self)!
        vc.expensesEntity = expenses
        vc.listPeopleEntity = listPeople
        vc.eventEntity = event
        return vc
    }
}

final class HistoryMemberViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HistoryMemberViewController.self) { _ in
            return StoryboardScene.Main.historyMemberViewController.instantiate()
        }
    }
}

extension HistoryMemberViewController {
    static func newInstance(event: EventEntity? = nil) -> HistoryMemberViewController {
        let vc =  Container.shareResolver.resolve(HistoryMemberViewController.self)!
        vc.eventEntity = event
        vc.viewModelPeople = Container.shareResolver.resolve(PeopleViewModel.self)
        return vc
    }
}

final class HistoryDetailViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HistoryDetailViewController.self) { _ in
            return StoryboardScene.Main.historyDetailViewController.instantiate()
        }
    }
}

extension HistoryDetailViewController {
    static func newInstance(people: PeopleEntity? = nil) -> HistoryDetailViewController {
        let vc =  Container.shareResolver.resolve(HistoryDetailViewController.self)!
        vc.peopleEntity = people
        vc.viewModelExpensesOfPeople = Container.shareResolver.resolve(ExpensesOfPeopleViewModel.self)
        return vc
    }
}
