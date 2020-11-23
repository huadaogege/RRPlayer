//
//  PlayerViewController.swift
//  CCPlayer
//
//  Created by 崔玉冠 on 2020/11/21.
//

import Foundation
import UIKit
import AVKit

class PlayerViewController: UIViewController {
    
    var screenObject = UIScreen.main.bounds
    
    var model:PlayModel!
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    
    func initModel(_ model:PlayModel) {
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        self.view.backgroundColor = UIColor.white
        self.title = self.model.name
        
        initPlayer(filePath: self.model.path, superView: self.view)
        self.player.play()
    }
    
    func initPlayer(filePath:String, superView:UIView) {
        let url = NSURL(fileURLWithPath: filePath)
        
        let playItem = AVPlayerItem(url: url as URL)
        self.player = AVPlayer.init(playerItem: playItem)
        self.player.rate = 1.0
        
        self.playerLayer = AVPlayerLayer.init(player: self.player)
        self.playerLayer.backgroundColor = UIColor.red.cgColor
        self.playerLayer.videoGravity = .resizeAspect
        self.playerLayer.frame = CGRect(x: 0, y: 0, width: superView.frame.size.width, height: superView.frame.size.height)
        superView.layer.addSublayer(self.playerLayer)
    }
    
}
