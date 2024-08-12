//
//  SearchViewModel.swift
//  iTunes
//
//  Created by 이찬호 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}


final class SearchViewModel: ViewModel {
    
    private let disposeBag = DisposeBag()
    
    var list = [String]()
    
    struct Input {
        let searchText: ControlProperty<String>
        let searchButtonTap: ControlEvent<Void>
    }
    struct Output {
        let dataList: PublishSubject<[Media]>
    }
    
    func transform(input: Input) -> Output {
        let dataList = PublishSubject<[Media]>()
        input.searchButtonTap
            .withLatestFrom(input.searchText)
            .map { "\($0)" }
            .debug("터치 시작")
            .flatMap { value in
                APIManager.shared.callRequest(term: value)
                    .catch { error in
                        return Single<MediaResult>.never()
                    }
            }
            .subscribe(with: self, onNext: { owner, result in
                dataList.onNext(result.results)
            }, onError: { owner, error in
                print("Error: \(error)")
            }, onCompleted: { owner in
                print("Complete")
            }, onDisposed: { owner in
                print("Disposed")
            })
//            .bind(with: self) { owner, value in
//                print(value)
//                owner.list.append(value)
//                dataList.onNext(owner.list)
//            }
            .disposed(by: disposeBag)
        return Output(dataList: dataList)
    }
    
}
