//
//  AddSongViewModel.swift
//  SongsAppiOS
//
//  Created by Anastasiia Poliuchovych on 28.05.2022.
//

import Foundation

final class AddSongViewModel: ObservableObject {
    @Published var songTitle = ""
    var songID: UUID?
    
    init() { }
    
    init(currentSong: Song) {
        self.songTitle = currentSong.title
        self.songID = currentSong.id
    }
    
    func addSong() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let song = Song(id: nil, title: songTitle)
        
        try await HttpClient.shared.sendData(to: url,
                                             object: song,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func updateSong(id: UUID) async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let songToUpdate = Song(id: id, title: songTitle)
        try await HttpClient.shared.sendData(to: url,
                                             object: songToUpdate,
                                             httpMethod: HttpMethods.PUT.rawValue)
        
    }
}
