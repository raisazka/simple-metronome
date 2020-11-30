//
//  MusicCell.swift
//  Metronome
//
//  Created by Rais on 14/03/20.
//  Copyright © 2020 Rais. All rights reserved.
//

import UIKit

class MusicCell: UITableViewCell {

  
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songImage: UIImageView!

    
    var theme = ""
    
    var songItem : Song!
        
    func bind(song: Song) {
        songItem = song
        songTitleLabel.text = song.songName
        artistNameLabel.text = song.artistName
        songImage.image = song.songImage
        if theme == "White" {
            songTitleLabel.textColor = .black
        } else if theme == "Blue" {
            songTitleLabel.textColor = .white
            self.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 51/255.0, alpha: 1.0)
        }
    }
}
