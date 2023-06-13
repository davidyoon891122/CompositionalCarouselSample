//
//  EventModel.swift
//  CarouselCompositionalView
//
//  Created by jiwon Yoon on 2023/06/13.
//

import Foundation

struct EventModel: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
}

extension EventModel {
    static let eventItems = [
        EventModel(imageName: "paycard"),
        EventModel(imageName: "paycard"),
        EventModel(imageName: "paycard"),
        EventModel(imageName: "paycard"),
        EventModel(imageName: "paycard")
    ]
}
