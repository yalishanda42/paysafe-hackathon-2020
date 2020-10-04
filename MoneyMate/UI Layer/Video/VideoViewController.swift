//
//  VideoViewController.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 4.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {

    private var videoPlayer: AVPlayer!
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var videoPlayerView: UIView!
    @IBOutlet private weak var questionView: UIView!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
        embedVideo()
        forwardButton.roundCorners()
        noButton.roundCorners(radius: 8)
        yesButton.roundCorners(radius: 8)
        questionView.roundCorners(radius: 8)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPlayer.seek(to: CMTime(seconds: 17, preferredTimescale: .max))
        videoPlayer.playImmediately(atRate: 1.25)
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        #warning("TODO: Add 1000$ to the account")
        Switcher.changeRootToTab()
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        #warning("TODO: Add 500$ to the account")
        Switcher.changeRootToTab()
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        videoPlayer.pause()
        let skipTime = CMTime(seconds: 197, preferredTimescale: .max)
        videoPlayer.seek(to: skipTime)
        videoPlayer.playImmediately(atRate: 1.25)
        
        let quizTime = CMTime(seconds: 215, preferredTimescale: .max)
        let timeValue = NSValue(time: quizTime)
        videoPlayer.addBoundaryTimeObserver(forTimes: [timeValue], queue: .main) { [weak self] in
            self?.videoPlayer.pause()
            self?.questionView.isHidden = false
        }
    }
}

private extension VideoViewController {
    func loadVideo() {
          guard let path = Bundle.main.path(forResource: "money.video", ofType:"mp4") else {
              debugPrint("video.m4v not found")
              return
          }
          videoPlayer = AVPlayer(url: URL(fileURLWithPath: path))
      }
      
    func embedVideo() {
          let vc = AVPlayerViewController()
          vc.entersFullScreenWhenPlaybackBegins = true
          vc.player = videoPlayer
          vc.showsPlaybackControls = false
          add(asChildViewController: vc, containerView: videoPlayerView)
      }
}
