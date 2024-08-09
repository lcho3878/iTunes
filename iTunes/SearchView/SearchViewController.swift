//
//  SearchViewController.swift
//  iTunes
//
//  Created by 이찬호 on 8/8/24.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private lazy var searchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        view.searchResultsUpdater = self
        return view
    }()
    
    private lazy var searchTableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.rowHeight = 120
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = .white

        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureHierarchy() {
        view.addSubview(searchTableView)
    }
    
    private func configureLayout() {
        searchTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        return cell
    }
    
}
