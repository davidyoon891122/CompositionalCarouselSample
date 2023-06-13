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
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1.0
        
        view.layer.shadowOffset = .init(width: 3, height: -3)
        
        [
            starImageView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        let offset: CGFloat = 16.0
        
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
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
