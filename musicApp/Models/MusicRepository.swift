//
//  SongQuery.swift
//  musicApp
//
//  Created by Alexander Kvamme on 24/12/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation
import MediaPlayer

// MARK: Models

struct SongInfo {
    
    var albumTitle: String
    var artistName: String
    var songTitle:  String
    
    var songId   :  NSNumber
}

struct AlbumInfo {
    
    var albumTitle: String
    var songs: [SongInfo]
}

// MARK: Methods
