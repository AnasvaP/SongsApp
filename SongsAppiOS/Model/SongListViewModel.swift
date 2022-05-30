//
//  SongListViewModel.swift
//  SongsAppiOS
//
//  Created by Anastasiia Poliuchovych on 28.05.2022.
//

import Foundation

class SongListViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    func fetchSongs() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let songResponse: [Song] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.songs = songResponse
        }
    }
    
    func delete(at index: Int) {
            guard let songID = songs[index].id else { return }
            guard let url = URL(string: Constants.baseURL + Endpoints.songs + "/" + "\(songID)") else { return}
        Task {
            do {
                try await HttpClient.shared.delete(at: songID, url: url)
            } catch { print("❌ error: ", error) }
            }
        songs.remove(at: index)
    }
            
}
