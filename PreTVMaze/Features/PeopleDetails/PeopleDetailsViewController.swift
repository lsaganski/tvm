//
//  PeopleDetailsViewController.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import UIKit

class PeopleDetailsViewController: ViewController<PeopleDetailsView> {
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
        navigationItem.title = "Person Details"
    }
    
    private func setupActions() {
        showBarBackButton()
    }
    
    private func loadData() async {
        customView.loading?.start()
        guard let viewModel = viewModel as? PeopleDetailsViewModel,
              let person = viewModel.personDetails else { return }
        if let url = URL(string: person.image?.medium ?? "") {
            customView.photoImageView.load(url: url)
        }
        customView.nameLabel.text = person.name
           
        do {
            try await viewModel.fetchShowsList()
            reloadTableView()
        } catch(let error) {
            handleError(error)
        }
    }
    
    private func reloadTableView() {
        customView.showsTableView.delegate = self
        customView.showsTableView.dataSource = self
        DispatchQueue.main.async { [weak self] in
            self?.customView.isLoading = false
            self?.customView.loading?.stop()
            self?.customView.showsTableView.reloadData()
        }
    }
}

extension PeopleDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel as? PeopleDetailsViewModel else { return 0 }
        let numberOfRows = viewModel.showsList.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel as? PeopleDetailsViewModel else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowDetailsTableViewCell.identifier) as? ShowDetailsTableViewCell else {
            return UITableViewCell()
        }
        let show = viewModel.showsList[indexPath.row]
        cell.setupCell(text: show.name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel as? PeopleDetailsViewModel else { return }
        let show = viewModel.showsList[indexPath.row]
        SessionManager.shared.coordinator?.goToShowDetails(info: show)
    }
}
