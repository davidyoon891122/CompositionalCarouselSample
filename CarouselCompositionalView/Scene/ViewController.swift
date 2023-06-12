//
//  ViewController.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/13.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        configureNavigation()
        setupViews()
    }


}

private extension ViewController {
    func setupViews() {
        
    }
    
    func configureNavigation() {
        navigationItem.title = "Main"
    }
}

