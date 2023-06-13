//
//  BannerModel.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/13.
//

import Foundation

struct BannerModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
}

extension BannerModel {
    static let bannerItems = [
        BannerModel(title: "test", imageName: "paycard"),
        BannerModel(title: "test", imageName: "paycard"),
        BannerModel(title: "test", imageName: "paycard"),
        BannerModel(title: "test", imageName: "paycard"),
        BannerModel(title: "test", imageName: "paycard")
    ]
}
