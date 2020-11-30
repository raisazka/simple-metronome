//
//  MusicViewController.swift
//  Metronome
//
//  Created by Rais on 14/03/20.
//  Copyright © 2020 Rais. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {
    
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var bpmTitle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
        
    var bpm : Int = 0
    
    var theme = ""
    
    var songList : [Song] = Song.initData()
    
    var filteredSong : [Song] = []
    
    var songSound : AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        filterSongbyBpm()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        bpmTitle.text = "\(bpm) BPM"
        if theme == "Blue" {
            blueTheme()
        } else if theme == "White" {
            whiteTheme()
        }

    }
    
    func filterSongbyBpm() {
        for song in songList {
            if song.songBpm == bpm {
                filteredSong.append(song)
            }
        }
    }
    
    
    private func blueTheme() {
        view.backgroundColor =  UIColor(red: 0/255.0, green: 0/255.0, blue: 51/255.0, alpha: 1.0)
        songTitle.textColor = .white
        bpmTitle.textColor = UIColor(red: 191/255.0, green: 164/255.0, blue: 114/255.0, alpha: 1.0)
        tableView.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 51/255.0, alpha: 1.0)
        tableView.separatorColor = .white
    }
    
    private func whiteTheme() {
        view.backgroundColor =  .white
        songTitle.textColor = .black
        bpmTitle.textColor = .black
    }
    
    private func showAlertNotFound() {
        let alert = UIAlertController(title: "No File Found", message: "Song file can't be found", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func setupAudioPlayer(file: String) {
        guard let path = Bundle.main.path(forResource: file, ofType: ".mp3") else {
            showAlertNotFound()
            return
        }
           let url = URL(fileURLWithPath: path)
           
           do {
               songSound = try AVAudioPlayer(contentsOf: url)
           } catch  {}
    }
 
}


extension MusicViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredSong.count == 0 {
            tableView.setEmptyView(title: "No Songs Available", message: "There are currently no songs with \(bpm) BPM", theme: theme)
        } else {
            tableView.restore()
        }
        return filteredSong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = filteredSong[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell") as! MusicCell
        cell.theme = theme
        cell.bind(song: song)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = filteredSong[indexPath.row]
        setupAudioPlayer(file: song.songFile)
        if song.songStatus == .PLAYED {
            song.songStatus = .PAUSED
            songSound?.stop()
        } else if song.songStatus == .PAUSED {
            song.songStatus = .PLAYED
            songSound?.play()
        }
    }
    
}

extension UITableView {
    
    func setEmptyView(title: String, message: String, theme: String) {
        
    let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
        if theme == "White" {
            titleLabel.textColor = UIColor.black
        } else if theme == "Blue" {
            titleLabel.textColor = UIColor.white
        }
    titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    messageLabel.textColor = UIColor.lightGray
    messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    emptyView.addSubview(titleLabel)
    emptyView.addSubview(messageLabel)
    titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
    titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
    messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
    messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
    messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
    titleLabel.text = title
    messageLabel.text = message
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    // The only tricky part is here:
    self.backgroundView = emptyView
    self.separatorStyle = .none
    }
    
    func setTheme(theme: String) {
        if theme == "White" {
            
        }
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
}
