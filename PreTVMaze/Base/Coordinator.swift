//
//  Coordinator.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 04/01/25.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navigationController: NavigationController { get }
}

class Coordinator: CoordinatorProtocol {
    //MARK: Properties
    var navigationController = NavigationController()
    var window: UIWindow?
    
    //MARK: Public functions
    func setUp(window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func start() {
        let vm = LaunchViewModel()
        let vc = LaunchViewController(viewModel: vm)
        navigationController.setViewControllers([vc], animated: true)
    }

    func goToSignIn() {
        let vm = SignInViewModel()
        let vc = SignInViewController(viewModel: vm)
        navigationController.setViewControllers([vc], animated: true)
    }

    func goToSignUp() {
        let vm = SignUpViewModel()
        let vc = SignUpViewController(viewModel: vm)
        navigationController.setViewControllers([vc], animated: true)
    }

    func goHome() {
        let vmShows = ShowListViewModel()
        let vcShows = ShowListViewController(viewModel: vmShows)
        let vmPeople = PeopleListViewModel()
        let vcPeople = PeopleListViewController(viewModel: vmPeople)
        let vcHome = HomeViewController()
        vcHome.viewControllers = [vcShows, vcPeople]
        navigationController.setViewControllers([vcHome], animated: true)
    }

    func goToShowList() {
        let vm = ShowListViewModel()
        let vc = ShowListViewController(viewModel: vm)
        navigationController.setViewControllers([vc], animated: true)
    }

    func goToShowDetails(info: Show) {
        let vm = ShowDetailsViewModel()
        vm.setShowDetails(show: info)
        let vc = ShowDetailsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }

    func goToPeopleDetails(info: Person) {
        let vm = PeopleDetailsViewModel()
        vm.setPersonDetails(person: info)
        let vc = PeopleDetailsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }

    func goToEpisodeDetails(info: Episode) {
        let vm = ShowEpisodeViewModel()
        vm.setEpisodeDetails(episode: info)
        let vc = ShowEpisodeViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }

    @objc
    func back() {
        navigationController.popViewController(animated: true)
    }
}
