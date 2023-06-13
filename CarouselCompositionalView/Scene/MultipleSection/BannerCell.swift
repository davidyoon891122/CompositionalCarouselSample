//
//  BannerCell.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/13.
//

import UIKit
import SnapKit

final class BannerCell: UICollectionViewCell {
    static let identifier = "BannerCell"
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        [
            bannerImageView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        bannerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
    
    func setupCell(title: String, imageName: String) {
        print("\(title)")
        bannerImageView.image = UIImage(named: imageName)
    }
}

private extension BannerCell {
    func setupViews() {
        [
            containerView
        ]
            .forEach {
                addSubview($0)
            }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
