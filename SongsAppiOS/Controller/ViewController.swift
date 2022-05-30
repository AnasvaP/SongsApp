//
//  ViewController.swift
//  SongsAppiOS
//
//  Created by Anastasiia Poliuchovych on 28.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tf: UITextField!
    let viewModelAdd = AddSongViewModel()
    let tableVC = TableVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tfAction(_ sender: Any) {
    }
    
    @IBAction func addBtn(_ sender: Any) {

        Task{
            do {
                viewModelAdd.songTitle = tf?.text ?? "non"
                try await viewModelAdd.addSong()
                tableVC.fetchReload()
            }
        catch {
            print("❌ error", error)
            }
        }
        
    }
}
