//
//  DetailViewController.swift
//  iTunes
//
//  Created by 이찬호 on 8/11/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    var media: Media?
    
    private let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(media?.trackName)
        view.backgroundColor = .white
        view.addSubview(testLabel)
        testLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        testLabel.rx.text.onNext(media?.trackName)
    }
}
