//
//  ViewController.swift
//  CarMusicPlayer
//
//  Created by Umar Haroon on 10/10/16.
//  Copyright © 2016 Umar Haroon. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var albumArtImageView: UIImageView!
    
    @IBOutlet weak var skipBackButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var skipForwardButton: UIButton!

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistAlbumLabel: UILabel!
    
    let libd = MusicLibrary()
    
    let musicPlayer = MPMusicPlayerController()
    
    let defaults = UserDefaults.standard
    var firstLaunch = true
    
    override func viewDidAppear(_ animated: Bool) {
        self.defaults.synchronize()
        firstLaunch = self.defaults.bool(forKey: "firstLaunch")
        musicPlayer.beginGeneratingPlaybackNotifications()
        
        
        
        NotificationCenter.default.addObserver(self, selector:#selector(updateView), name:.MPMusicPlayerControllerNowPlayingItemDidChange, object:musicPlayer)
        NotificationCenter.default.addObserver(self, selector:#selector(changePlayPauseButtonImage), name: .MPMusicPlayerControllerPlaybackStateDidChange, object:musicPlayer)
        
        
        
        let g = libd.authorize()
        print(g)
        


        
        
}


    override func viewDidLoad() {
        super.viewDidLoad()
        if self.defaults.bool(forKey: "auth"){
            print("JFKLSJDS:LFJFJ")
            self.updateView()
        }

        
    }
    
    
    
    func changePlayPauseButtonImage(){
        
        if (playPauseButton.imageView?.image)! == #imageLiteral(resourceName: "PlayImage") && musicPlayer.playbackState.rawValue == 1{
            
            playPauseButton.setImage(#imageLiteral(resourceName: "Pause"), for: UIControlState.normal)
            
        }else{
            playPauseButton.setImage(#imageLiteral(resourceName: "PlayImage"), for: UIControlState.normal)
            
        }

        
    }
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
        if (musicPlayer.playbackState.rawValue == 1){
            musicPlayer.pause()
        }else{
            musicPlayer.play()
        }
    }
    @IBAction func skipForwardButtonPressed(_ sender: UIButton) {
        
        musicPlayer.skipToNextItem()
        
    }
    
    @IBAction func skipBackButtonPressed(_ sender: UIButton) {
        musicPlayer.skipToPreviousItem()
    }
    
    func updateView(){
        
        self.musicPlayer.nowPlayingItem?.artwork?.image(at:CGSize.init(width: 75, height: 50))?.getColors{ colors in
            UIView.animate(withDuration: 0.15, animations: {
                self.skipBackButton.tintColor = colors.primaryColor
                self.playPauseButton.tintColor = colors.primaryColor
                self.skipForwardButton.tintColor = colors.primaryColor
                self.artistAlbumLabel.textColor = colors.secondaryColor
                self.songNameLabel.textColor = colors.detailColor
                self.view.backgroundColor = colors.backgroundColor
            }, completion: { (success) in
                self.albumArtImageView.image = self.musicPlayer.nowPlayingItem?.artwork?.image(at:CGSize.init(width: self.albumArtImageView.frame.size.width, height: self.albumArtImageView.frame.size.height))
                self.artistAlbumLabel.text = self.musicPlayer.nowPlayingItem?.artist
                self.songNameLabel.text = self.musicPlayer.nowPlayingItem?.title

            })
        }
        
        
        

    }
    

}

