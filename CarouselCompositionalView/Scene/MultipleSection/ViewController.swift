//
//  ViewController.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/13.
//

import UIKit
import SnapKit

enum SectionType {
    case banner
    case event
}

struct Section {
    let type: SectionType
    var items: [AnyHashable]
}

class ViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        
        return collectionView
    }()
    
    private var datasource: UICollectionViewDiffableDataSource<SectionType, AnyHashable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        configureNavigation()
        setupViews()
        configureDatasource()
    }
}

private extension ViewController {
    func setupViews() {
        [
            collectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureNavigation() {
        navigationItem.title = "Main"
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        })
        
        return layout
    }
    
    func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource<SectionType, AnyHashable>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            if let bannerModel = item as? BannerModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else { return UICollectionViewCell() }
                print(bannerModel)
                cell.setupCell(title: bannerModel.title, imageName: bannerModel.imageName)
                
                return cell
            } else if let eventModel = item as? EventModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }
                print(eventModel)
                
                cell.setupCell(imageName: eventModel.imageName)
                
                return cell
            }
            
            return UICollectionViewCell()
        })
        applySnapshot()
        
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, AnyHashable>()
        snapshot.appendSections([.banner, .event])
        snapshot.appendItems(BannerModel.bannerItems, toSection: .banner)
        snapshot.appendItems(EventModel.eventItems, toSection: .event)
        
        datasource.apply(snapshot, animatingDifferences: true)
        
    }
}

