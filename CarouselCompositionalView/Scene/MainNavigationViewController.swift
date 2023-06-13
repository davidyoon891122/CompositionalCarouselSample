//
//  MainNavigationViewController.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/13.
//

import UIKit
import SnapKit

enum MainSectionType {
    case main
}

final class MainNavigationViewController: UIViewController {
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
    
        tableView.delegate = self
        tableView.register(MainMenuCell.self, forCellReuseIdentifier: MainMenuCell.identifier)
        
        return tableView
    }()
    
    private var datasource: UITableViewDiffableDataSource<MainSectionType, MainMenuModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupViews()
        configureDatasource()
    }
    
}

extension MainNavigationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            navigationController?.pushViewController(ViewController(), animated: true)
        } else {
            navigationController?.pushViewController(CarouselViewController(), animated: true)
        }
    }
}

private extension MainNavigationViewController {
    func setupViews() {
        [
            menuTableView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        menuTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureNavigation() {
        navigationItem.title = "Main"
    }
    
    func configureDatasource() {
        datasource = UITableViewDiffableDataSource(tableView: menuTableView, cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMenuCell.identifier, for: indexPath) as? MainMenuCell else { return UITableViewCell() }
            
            cell.setupCell(title: item.menu)
            
            return cell
        })
        
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MainSectionType, MainMenuModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(MainMenuModel.menuItems)
        
        datasource.apply(snapshot, animatingDifferences: true)
    }
}
