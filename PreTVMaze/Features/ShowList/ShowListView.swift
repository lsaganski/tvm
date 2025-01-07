//
//  ShowList.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 04/01/25.
//

import UIKit

class ShowListView: UIView {
    // MARK: Properties
    private let searchView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    let searchTextField: PlaceholderTextField = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.placeholder = "type here to search..."
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(PlaceholderTextField())

    private let searchButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.imageView?.tintColor = .white
        $0.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        return $0
    }(UIButton())

    let tableView: UITableView = {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 130
        $0.backgroundColor = .background
        $0.register(ShowListTableViewCell.self, forCellReuseIdentifier: ShowListTableViewCell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())

    let refreshControl: UIRefreshControl = {
        $0.tintColor = .white
        $0.attributedTitle = NSAttributedString(string: "Loading...", attributes: [.foregroundColor: UIColor.white])
        return $0
    }(UIRefreshControl())

    var isLoading = false
    var loading: Loading?

    var tableWithSearchTopConstraint: NSLayoutConstraint?
    var tableWithoutSearchTopConstraint: NSLayoutConstraint?
    
    let topAnchorConstant = 100.0
    var searchAction: (() -> ())?
    var refreshAction: (() -> ())?

    //MARK: Lifecycle
    init() {
        super.init(frame: .zero)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Private Methods
    private func setupUI() {
        backgroundColor = .background
        searchView.addSubview(searchTextField)
        searchView.addSubview(searchButton)
        addSubview(searchView)
        addSubview(tableView)

        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor, constant: 0),
            searchButton.heightAnchor.constraint(equalTo: searchTextField.heightAnchor),
            searchButton.widthAnchor.constraint(equalTo: searchTextField.heightAnchor),

            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 10),
            searchTextField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),

            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            searchView.topAnchor.constraint(equalTo: topAnchor, constant: topAnchorConstant),

            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        tableWithSearchTopConstraint = tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 0)
        tableWithoutSearchTopConstraint = tableView.topAnchor.constraint(equalTo: topAnchor, constant: topAnchorConstant)
        tableWithSearchTopConstraint?.isActive = false
        tableWithoutSearchTopConstraint?.isActive = true
    }
    
    private func setupActions() {
        loading = Loading(view: self)
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(performRefreshAction), for: .valueChanged)

        searchButton.addTarget(self, action: #selector(performSearchAction), for: .touchUpInside)
    }
    
    @objc
    private func performRefreshAction() {
        guard let refreshAction else { return }
        refreshAction()
    }
    
    @objc
    func performSearchAction() {
        guard let searchAction else { return }
        searchAction()
    }

    //MARK: Public Methods
    func displaySearchFeature() {
        self.tableWithSearchTopConstraint?.isActive = true
        self.tableWithoutSearchTopConstraint?.isActive = false
    }

    func hideSearchFeature() {
        self.tableWithSearchTopConstraint?.isActive = false
        self.tableWithoutSearchTopConstraint?.isActive = true
    }
}
