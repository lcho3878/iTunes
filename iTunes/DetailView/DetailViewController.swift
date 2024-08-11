//
//  DetailViewController.swift
//  iTunes
//
//  Created by 이찬호 on 8/11/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    var media: Media?
    
    private let mainImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let advisoryLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    private let genreLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    private let descriptionLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    private func configureView() {
        title = media?.trackName
        
        view.backgroundColor = .white
        
        view.addSubview(mainImageView)
        view.addSubview(advisoryLabel)
        view.addSubview(genreLabel)
        view.addSubview(descriptionLabel)
        
        mainImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        advisoryLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(mainImageView)
        }
        
        genreLabel.snp.makeConstraints {
            $0.top.equalTo(advisoryLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(mainImageView)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(mainImageView)
        }
    }
    
    private func bind() {
        guard let media else { return }
        advisoryLabel.rx.text.onNext(media.contentAdvisoryRating)
        genreLabel.rx.text.onNext(media.primaryGenreName)
        descriptionLabel.rx.text.onNext(media.longDescription)
        mainImageView.kf.setImage(with: URL(string: media.artworkUrl100))
    }
}
