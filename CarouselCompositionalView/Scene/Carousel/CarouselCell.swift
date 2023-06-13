//
//  CarouselCell.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/13.
//

import UIKit
import SnapKit

final class CarouselCell: UICollectionViewCell {
    static let identifier = "CarouselCell"
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var mainBoxView: UIView = {
        let view = UIView()
        
        
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        [
            mainBoxView,
            starImageView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        
        mainBoxView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.width.equalTo(20)
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CarouselCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        let inset: CGFloat = 16.0
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
