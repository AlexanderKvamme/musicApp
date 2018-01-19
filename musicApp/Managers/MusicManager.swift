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
    var currentCollection: MPMediaItemCollection?
    let mediaPlayer: MPMusicPlayerController =  {
        let mediaPlayer = MPMusicPlayerController.systemMusicPlayer
        mediaPlayer.shuffleMode = .off
        mediaPlayer.repeatMode = .none
        return mediaPlayer
    }()
    
    // MARK: - Methods
    
    func playItem(_ item: MPMediaItem) {
        currentCollection = MPMediaItemCollection(items: [item])
        mediaPlayer.setQueue(with: currentCollection!)
        mediaPlayer.play()
    }
    
    func playCollection(_ collection: MPMediaItemCollection) {
        // play all
        currentCollection = collection
        mediaPlayer.setQueue(with: collection)
        mediaPlayer.play()
    }
    
    func addToQueue(_ item: MPMediaItem) {
        if let playlistCollection = currentCollection {
            playlistCollection.printItems()
            print("*adding to queue*")
            
            if let _ = mediaPlayer.nowPlayingItem {
                print(" had playing item" )
                // If song is playing, add to after that song
                var newItems: [MPMediaItem] = []
                newItems.append(contentsOf: playlistCollection.items)
                newItems.append(item)
                
                let newCollection = MPMediaItemCollection(items: newItems)
                currentCollection = newCollection
                mediaPlayer.setQueue(with: newCollection)
                //mediaPlayer.play()
                
                
                // new
                if mediaPlayer.playbackState == .paused {
                    //                    mediaPlayer.prepare
                    print("DID invoke .play()")
                    mediaPlayer.play()
                } else {
                    print("did NOT invoke .play()")
                    mediaPlayer.play()
                    mediaPlayer.prepareToPlay()
                }
            } else {
                // If no song is playing just play it
                fatalError("ERROR - had no 'now playing', what happens?")
            }
        } else {
            // No active playlist. make new
            if let npi = mediaPlayer.nowPlayingItem { // Includes a paused one
                
                let collection = MPMediaItemCollection(items: [npi, item])
                currentCollection = collection
                mediaPlayer.setQueue(with: collection)
                mediaPlayer.play()
                
            } else {
                // Make completelty new playlist
                let collection = MPMediaItemCollection(items: [item])
                currentCollection = collection
                mediaPlayer.setQueue(with: collection)
                mediaPlayer.play()
            }
        }
    }
    
    func addAsNext(_ item: MPMediaItem) {
        
        // If no item is currenty playing, just play the new item
        guard let nowPlaying = mediaPlayer.nowPlayingItem else {
            playItem(item)
            return
        }
        
        // If theres no currentCollection of item playing, just play the new item
        guard let currentCollection = currentCollection else {
            playItem(item)
            return
        }
        
        // Make ﬁist of items and inject
        var items = currentCollection.items
        
        guard let indexOfCurrentSong = currentCollection.items.index(of: nowPlaying) else {
            fatalError("song is in queue but has no index")
        }
        
        items.insert(item, at: indexOfCurrentSong + 1)
        mediaPlayer.setQueue(with: MPMediaItemCollection(items: items))
        mediaPlayer.play()
    }
}

