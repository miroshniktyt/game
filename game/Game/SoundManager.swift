//
//  SoundManager.swift
//  Buffalo Up
//
//  Created by toha on 24.03.2021.
//

import AVFoundation
import SpriteKit

enum SoundType: String {
    case select, lose, pop0, coin, win, explosion, boom

    var soundName: String {
        return self.rawValue
    }
}

class SoundManager : NSObject, AVAudioPlayerDelegate {

    static let sharedInstance = SoundManager()

    var audioPlayer : AVAudioPlayer?
    var trackPosition = 0
    var isMuted: Bool {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(isMuted, forKey: "isMuted")
            defaults.synchronize()

            if isMuted {
                audioPlayer?.stop()
            } else {
                startPlayingNext()
            }
        }
    }

    static private let tracks = [
        "POL-flying-dreams-short",
        "POL-around-the-world-short"
    ]

    private override init() {
        //This is private so you can only have one Sound Manager ever.
        trackPosition = Int(arc4random_uniform(UInt32(SoundManager.tracks.count)))

        let defaults = UserDefaults.standard
        self.isMuted = defaults.bool(forKey: "isMuted")
        
        super.init()
        self.startPlaying()
    }
    
    func startPlayingNext() {
        trackPosition = (trackPosition + 1) % SoundManager.tracks.count
        startPlaying()
    }

    public func startPlaying() {
        if !isMuted && (audioPlayer == nil || audioPlayer?.isPlaying == false) {
            let soundURL = Bundle.main.url(forResource: SoundManager.tracks[trackPosition], withExtension: "wav")

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
            } catch {
                print("audio player failed to load: \(soundURL) \(trackPosition)")

                return
            }
            
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = 0.1
            audioPlayer?.play()
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //Just play the next track
        startPlaying()
    }

    var player: AVAudioPlayer?

    func play(sound: SoundType) {

        guard !self.isMuted else { return }

        guard let url = Bundle.main.url(forResource: sound.soundName, withExtension: "wav") else {
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player?.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    func play(sound: SoundType, node: SKNode) {
        guard !self.isMuted else { return }

        node.run(.playSoundFileNamed(sound.rawValue + ".wav", waitForCompletion: true))
    }
}
