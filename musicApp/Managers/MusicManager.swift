//
//  MusicManager.swift
//  musicApp
//
//  Created by Alexander Kvamme on 26/12/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicManager {
    
    // MARK: - Properties
    
    let mediaPlayer: MPMusicPlayerApplicationController = {
        let myMediaPlayer = MPMusicPlayerApplicationController()
        return myMediaPlayer
    }()
    
    // MARK: - Methods
    
    func playItem(_ item: MPMediaItem) {
        let collection = MPMediaItemCollection(items: [item])
        self.mediaPlayer.setQueue(with: collection)
        self.mediaPlayer.play()
    }
    
    func playCollection(_ collection: MPMediaItemCollection) {
        self.mediaPlayer.setQueue(with: collection)
        self.mediaPlayer.play()
    }
}
