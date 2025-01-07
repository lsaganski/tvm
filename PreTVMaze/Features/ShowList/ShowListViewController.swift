//
//  ShowListViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 04/01/25.
//

import UIKit

class ShowListViewController: ViewController<ShowListView> {
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
        navigationItem.title = "Shows"
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
            self?.dismissKeyboard()
            guard let viewModel = self?.viewModel as? ShowListViewModel else { return }
            Task {
                guard let text = self?.customView.searchTextField.text, !text.isEmpty else { return }
                do {
                    self?.customView.searchTextField.text = ""
                    try await viewModel.searchShows(text)
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
            guard let viewModel = self?.viewModel as? ShowListViewModel else { return }
            Task {
                do {
                    viewModel.showListPage = 0
                    try await viewModel.fetchShows()
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
            guard let viewModel = viewModel as? ShowListViewModel else { return }
            do {
                try await viewModel.fetchShows()
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

extension ShowListViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: TableViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !customView.isLoading {
            guard let viewModel = viewModel as? ShowListViewModel else { return }
            Task {
                do {
                    try await viewModel.fetchMoreShows()
                    reloadTableView()
                } catch(let error) {
                    handleError(error)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel as? ShowListViewModel else { return 0 }
        return viewModel.showList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel as? ShowListViewModel else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowListTableViewCell.identifier) as? ShowListTableViewCell else {
            return UITableViewCell()
        }
        cell.posterImageView.image = nil
        let show = viewModel.showList[indexPath.row]
        cell.setupCell(imageUrl: show.image?.medium ?? "", text: show.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel as? ShowListViewModel else { return }
        let show = viewModel.showList[indexPath.row]
        SessionManager.shared.coordinator?.goToShowDetails(info: show)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
}
extension ShowListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async { [weak self] in
            self?.customView.searchTextField.resignFirstResponder()
            self?.customView.performSearchAction()
        }
        return true
    }
}
