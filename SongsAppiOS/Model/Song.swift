//
//  Song.swift
//  SongsAppiOS
//
//  Created by Anastasiia Poliuchovych on 28.05.2022.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID?
    var title: String
}
