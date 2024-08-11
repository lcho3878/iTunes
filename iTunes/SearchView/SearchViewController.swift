//
//  SearchViewController.swift
//  iTunes
//
//  Created by 이찬호 on 8/8/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    
    private lazy var searchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        return view
    }()
    
    private lazy var searchTableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.rowHeight = 120
        return view
    }()
    
    private let viewModel = SearchViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        bind()
    
    }
    private func bind() {
        let input = SearchViewModel.Input(searchText: searchController.searchBar.rx.text.orEmpty, searchButtonTap: searchController.searchBar.rx.searchButtonClicked)
        let output = viewModel.transform(input: input)
        
        output.dataList
            .bind(to: searchTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType:  SearchTableViewCell.self)) { row, element, cell in
                cell.configureData(element)
            }
            .disposed(by: disposeBag)
        
        searchTableView.rx.modelSelected(Media.self)
            .bind(with: self) { owner, media in
                let detailVC = DetailViewController()
                detailVC.media = media
                owner.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: disposeBag)
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


