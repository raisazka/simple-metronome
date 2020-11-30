//
//  Song.swift
//  Metronome
//
//  Created by Rais on 14/03/20.
//  Copyright © 2020 Rais. All rights reserved.
//

import Foundation
import UIKit

class Song {
    var songName : String
    var artistName : String
    var songFile : String
    var songImage : UIImage
    var songBpm : Int
    var songStatus : SongStatus = .PAUSED
    
    init(songName: String, artistName: String, songFile : String, songImage : UIImage, songBpm : Int) {
        self.songName = songName
        self.artistName = artistName
        self.songFile = songFile
        self.songImage = songImage
        self.songBpm = songBpm
    }
    
    static func initData() -> [Song] {
        var songList : [Song] = []
        let song1 = Song(songName: "Please Please Me", artistName: "The Beatles", songFile: "please-me", songImage: #imageLiteral(resourceName: "please2-me"), songBpm: 120)
        let song2 = Song(songName: "In My Life", artistName: "The Beatles", songFile: "in-my-life", songImage: #imageLiteral(resourceName: "rub-soul"), songBpm: 60)
        let song3 = Song(songName: "Nowhere Man", artistName: "The Beatles", songFile: "nowhere-man", songImage: #imageLiteral(resourceName: "rub-soul"), songBpm: 60)
        let song4 = Song(songName: "Twist & Shout", artistName: "The Beatles", songFile: "twist-shout", songImage: #imageLiteral(resourceName: "please2-me"), songBpm: 120)
        let song5 = Song(songName: "Take On Me", artistName: "A-ha", songFile: "take-on-me", songImage: #imageLiteral(resourceName: "take-on-me"), songBpm: 100)
        let song6 = Song(songName: "Uprising", artistName: "Muse", songFile: "uprising", songImage: #imageLiteral(resourceName: "resistance"), songBpm: 120)
        
        songList.append(song1)
        songList.append(song2)
        songList.append(song3)
        songList.append(song4)
        songList.append(song5)
        songList.append(song6)
        return songList
    }
}
