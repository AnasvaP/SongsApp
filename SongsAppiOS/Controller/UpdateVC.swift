//
//  UpdateVC.swift
//  SongsAppiOS
//
//  Created by Anastasiia Poliuchovych on 28.05.2022.
//

import UIKit

class UpdateVC: UIViewController {
    
    @IBOutlet weak var tf: UITextField!
    let viewModel = SongListViewModel()
    let viewModelAdd = AddSongViewModel()
    static var title : String = ""
    static var songToUpdate: Song? = nil
    
    fileprivate func showSelectedTitle() {
        tf.text = UpdateVC.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSelectedTitle()
    }
    

    @IBAction func updateBtn(_ sender: Any) {
        Task{
           do {
               viewModelAdd.songTitle = tf.text!
               try await viewModelAdd.updateSong(id: (UpdateVC.songToUpdate?.id)!)
           }
           catch {
               print("❌ error", error)
           }
       }
    }


}
