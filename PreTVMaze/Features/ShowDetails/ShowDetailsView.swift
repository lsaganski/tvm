//
//  ShowDetails.swift
//  PreTVMaze
//
//  Created by Leonardo Saganski on 05/01/25.
//

import UIKit

class ShowDetailsView: UIView {
    // MARK: Properties
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())

    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    let posterImageView: UIImageView = {
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

    let scheduleLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    let genresLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    let summaryLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let episodesTitleLabel: UILabel = {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.text = Constants.String.episodes
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    let episodesTableView: IntrinsicTableView = {
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
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(scheduleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(episodesTitleLabel)
        contentView.addSubview(episodesTableView)
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

            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            scheduleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            scheduleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            scheduleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            genresLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 10),
            genresLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            genresLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            summaryLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 10),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            episodesTitleLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10),
            episodesTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            episodesTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            episodesTableView.topAnchor.constraint(equalTo: episodesTitleLabel.bottomAnchor, constant: 10),
            episodesTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            episodesTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            episodesTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
