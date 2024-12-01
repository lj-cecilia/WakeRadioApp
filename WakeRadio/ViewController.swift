//
//  ViewController.swift
//  WakeRadio
//
//  Created by Cecilia on 3/25/24.
//

import UIKit
import AVFoundation
//import StreamingKit

class ViewController: UIViewController {
    
    //play and pause button
    @IBOutlet weak var playpauseButton: UIButton!
    //volume slider
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        player?.setVolume(sender.value)
    }
    @IBOutlet weak var volumeSlider: UISlider!
    
    var player: MyPlayerClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = MyPlayerClass()
        player?.play() // Start playback when the view loads
        playpause.setImage(UIImage(named: "pause"), for: .normal)
    }
    
    class MyPlayerClass {
        var playerItem: AVPlayerItem?
        var player: AVPlayer?

        init() {
            let url = URL(string: "http://152.17.49.84:8000/wakeradio.m3u")!
            self.playerItem = AVPlayerItem(url: url)
            self.player = AVPlayer(playerItem: playerItem)
        }
        //play function
        func play() {
            player?.play()
        }
        //pause function
        func pause() {
            player?.pause()
        }
        //return boolean value to indicate whether is playing
        var isPlaying: Bool {
            if (player?.rate != 0) {
                return true;
            }
            else {
                return false;
            }
        }
        //set volume function for slider
        func setVolume(_ volume: Float) {
            player?.volume = volume
        }
    }

    @IBOutlet weak var playpause: UIButton!
    
    @IBAction func playPauseButtonClick(_ sender: Any) {
        guard let player = player
        else {
            print("Error instantiating");
            return;
        }
        
        if (player.isPlaying) {
            player.pause()
            playpause.setImage(UIImage(named: "play"), for: .normal) // Update to play icon
        } else {
            player.play()
            playpause.setImage(UIImage(named: "pause"), for: .normal) // Update to pause icon
        }
    }
}
