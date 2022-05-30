//
//  TableVC.swift
//  SongsAppiOS
//
//  Created by Anastasiia Poliuchovych on 28.05.2022.
//

import UIKit

class TableVC: UITableViewController {
    
    let viewModel = SongListViewModel()
    let viewModelAdd = AddSongViewModel()
    let updateVC = UpdateVC()
    

    func fetchReload() {
         Task{
            do {
                try await viewModel.fetchSongs()
                tableView.reloadData()
                print("✅ ", viewModel.songs.description)
            }
            catch {
                print("❌ error", error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchReload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchReload()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.songs.count != 0 {
            return viewModel.songs.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        cell.titleSong.text = viewModel.songs[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateVC") as! UpdateVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        UpdateVC.title = viewModel.songs[indexPath.row].title
        UpdateVC.songToUpdate = viewModel.songs[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "delete") { [self] action, view, completionHandler in
            self.viewModel.delete(at: indexPath.row)
            self.fetchReload()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
