//
//  SearchViewModel.swift
//  iTunes
//
//  Created by 이찬호 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    private let disposeBag = DisposeBag()
    
    var list = [String]()
    
    struct Input {
        let searchText: ControlProperty<String>
        let searchButtonTap: ControlEvent<Void>
    }
    struct Output {
        let dataList: PublishSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        let dataList = PublishSubject<[String]>()
        input.searchButtonTap
            .withLatestFrom(input.searchText)
            .bind(with: self) { owner, value in
                print(value)
                owner.list.append(value)
                dataList.onNext(owner.list)
            }
            .disposed(by: disposeBag)
        return Output(dataList: dataList)
    }
    
}
