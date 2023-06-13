//
//  MainMenuModel.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/13.
//

import Foundation

struct MainMenuModel: Identifiable, Hashable {
    let id = UUID()
    let menu: String
}

extension MainMenuModel {
    static let menuItems = [
        MainMenuModel(menu: "Multiple Sections"),
        MainMenuModel(menu: "Carousel")
    ]
}
