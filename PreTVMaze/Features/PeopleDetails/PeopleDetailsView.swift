//
//  PeopleDetailsView.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 06/01/25.
//

import UIKit

class PeopleDetailsView: UIView {
    // MARK: Properties
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())

    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    let photoImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    let nameLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    let showsTitleLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.text = Constants.String.shows
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    let showsTableView: IntrinsicTableView = {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 130
        $0.backgroundColor = .background
        $0.register(ShowDetailsTableViewCell.self, forCellReuseIdentifier: ShowDetailsTableViewCell.identifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(IntrinsicTableView())

    var isLoading = false
    var loading: Loading?

    //MARK: Lifecycle
    init() {
        super.init(frame: .zero)
        setupUI()
        loading = Loading(view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Private Methods
    private func setupUI() {
        backgroundColor = .background
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(showsTitleLabel)
        contentView.addSubview(showsTableView)
        scrollView.addSubview(contentView)
        addSubview(scrollView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            photoImageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            showsTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            showsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            showsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            showsTableView.topAnchor.constraint(equalTo: showsTitleLabel.bottomAnchor, constant: 10),
            showsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            showsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            showsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
