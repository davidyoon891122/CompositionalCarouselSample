//
//  CarouselModel.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/14.
//

import Foundation

struct CarouselModel: Identifiable, Hashable {
    let id = UUID()
    let index: Int
}

extension CarouselModel {
    static let carouselItems = [
        CarouselModel(index: 1),
        CarouselModel(index: 2),
        CarouselModel(index: 3)
    ]
}
