//
//  PeopleListViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import UIKit

class PeopleListViewController: ViewController<PeopleListView> {
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        Task {
            await loadData()
        }
    }
    
    //MARK: Private functions
    private func setupUI() {
        navigationItem.title = "People"
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func setupActions() {
        rightButtonAction = { [weak self] in
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.customView.displaySearchFeature()
                self?.customView.layoutIfNeeded()
                self?.customView.searchTextField.becomeFirstResponder()
            }
            self?.hideRightButton()
        }
        setUpSearchBarButton()
        customView.searchAction = { [weak self] in
            guard let viewModel = self?.viewModel as? PeopleListViewModel else { return }
            Task {
                guard let text = self?.customView.searchTextField.text, !text.isEmpty else { return }
                do {
                    self?.customView.searchTextField.text = ""
                    try await viewModel.searchPeople(text)
                    self?.reloadTableView()
                } catch(let error) {
                    self?.handleError(error)
                }
            }
            UIView.animate(withDuration: 0.3,
                           animations: { [weak self] in
                self?.customView.hideSearchFeature()
                self?.customView.layoutIfNeeded()
            }) { [weak self] _ in
                self?.setUpSearchBarButton()
            }
        }
        customView.refreshAction = { [weak self] in
            guard let viewModel = self?.viewModel as? PeopleListViewModel else { return }
            Task {
                do {
                    viewModel.peopleListPage = 0
                    try await viewModel.fetchPeople()
                    self?.reloadTableView()
                } catch(let error) {
                    self?.handleError(error)
                }
            }
        }
        
        customView.searchTextField.delegate = self
    }
    
    private func loadData() async {
        if !customView.isLoading {
            customView.isLoading = true
            customView.loading?.start()
            guard let viewModel = viewModel as? PeopleListViewModel else { return }
            do {
                try await viewModel.fetchPeople()
                reloadTableView()
            } catch(let error) {
                handleError(error)
            }
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.customView.isLoading = false
            self?.customView.loading?.stop()
            self?.customView.refreshControl.endRefreshing()
            self?.customView.tableView.reloadData()
        }
    }
}

extension PeopleListViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: TableViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !customView.isLoading {
            guard let viewModel = viewModel as? PeopleListViewModel else { return }
            Task {
                do {
                    try await viewModel.fetchMorePeople()
                    reloadTableView()
                } catch(let error) {
                    handleError(error)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel as? PeopleListViewModel else { return 0 }
        return viewModel.peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel as? PeopleListViewModel else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PeopleListTableViewCell.identifier) as? PeopleListTableViewCell else {
            return UITableViewCell()
        }
        cell.photoImageView.image = nil
        let person = viewModel.peopleList[indexPath.row]
        cell.setupCell(imageUrl: person.image?.medium ?? "", text: person.name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel as? PeopleListViewModel else { return }
        let person = viewModel.peopleList[indexPath.row]
        SessionManager.shared.coordinator?.goToPeopleDetails(info: person)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}
extension PeopleListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async { [weak self] in
            self?.customView.searchTextField.resignFirstResponder()
            self?.customView.performSearchAction()
        }
        return true
    }
}
