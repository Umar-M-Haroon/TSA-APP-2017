//
//  MusicLibrary.swift
//  CarMusicPlayer
//
//  Created by Umar Haroon on 12/17/16.
//  Copyright © 2016 Umar Haroon. All rights reserved.
//

import Foundation
import MediaPlayer



class MusicLibrary{
    
    var player:MPMusicPlayerController
    var playlistCollections:[MPMediaItemCollection]? = nil
    var playlists:Array<Any>
    
    init() {
        self.player = MPMusicPlayerController()
        self.playlistCollections = MPMediaQuery.playlists().collections
        self.playlists = []
        
    }
    
    
    func returnPlaylists() -> Array<Any> {
        
        for var i in 0..<Int((self.playlistCollections?.count)!){
            if let list:MPMediaPlaylist = self.playlistCollections?[i] as? MPMediaPlaylist{
                let j = list.value(forProperty: MPMediaPlaylistPropertyName)
                
                playlists.append(j!)
            }
        }
        return playlists
        
    }
    
    func authorize() -> Bool{
        let authorizationStatus = MPMediaLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case .notDetermined:
            MPMediaLibrary.requestAuthorization({ (status) in
                self.authorize()
            })
        case .denied,.restricted:
            return false
        default:
            
            return true
        }
        return false
    }
    

    
}
