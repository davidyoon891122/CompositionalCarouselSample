//
//  CarouselViewController.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/13.
//

import UIKit
import SnapKit

enum CarouselSectionType {
    case main
}

final class CarouselViewController: UIViewController {
    private lazy var carouselCollectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.identifier)
        
        return collectionView
    }()
    
    private var datasource: UICollectionViewDiffableDataSource<CarouselSectionType, CarouselModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupViews()
        configureDatasource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

private extension CarouselViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        [
            carouselCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        carouselCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureNavigation() {
        navigationItem.title = "Carousel"
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, environmentLayout in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(500)))
            
            item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(500)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
            section.visibleItemsInvalidationHandler = { [weak self] items, offset, env in
                guard let currentIndex = items.last?.indexPath.row,
                      items.last?.indexPath.section == 0,
                      let self = self
                else { return }
                
                self.willChangeMainSectionIndex(currentIndex: currentIndex)
            }
            
            return section
        })
        
        return layout
    }
    
    func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: carouselCollectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as? CarouselCell else { return UICollectionViewCell() }
            
            cell.setupCell(index: item.index)
            return cell
        })
        
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CarouselSectionType, CarouselModel>()
        snapshot.appendSections([.main])
        datasource.apply(snapshot, animatingDifferences: true)
                
        DispatchQueue.global().sync {
            var snapshot = datasource.snapshot()
            
            
            snapshot.appendItems(CarouselModel.carouselItems, toSection: .main)
            
            CarouselModel.carouselItems.forEach {
                snapshot.appendItems([CarouselModel(index: $0.index)], toSection: .main)
            }
            CarouselModel.carouselItems.forEach {
                snapshot.appendItems([CarouselModel(index: $0.index)], toSection: .main)
            }
            
            
            datasource.apply(snapshot, animatingDifferences: true) { [weak self] in
                guard let self = self else { return }
                self.carouselCollectionView.scrollToItem(at: [0, CarouselModel.carouselItems.count], at: .left, animated: false)
                
            }
        }
    }
    
    func willChangeMainSectionIndex(currentIndex: Int) {
        let startTriggerIndex = CarouselModel.carouselItems.count - 1
        let endTriggerIndex = CarouselModel.carouselItems.count * 2 + 1
        
        let middleLastIndex = CarouselModel.carouselItems.count * 2 - 1
        let middleStartIndex = CarouselModel.carouselItems.count
        switch currentIndex {
        case startTriggerIndex:
            self.carouselCollectionView.scrollToItem(at: [0, middleLastIndex], at: .left, animated: false)
        case endTriggerIndex:
            self.carouselCollectionView.scrollToItem(at: [0, middleStartIndex], at: .left, animated: false)
        default:
            break
        }
    }
}
