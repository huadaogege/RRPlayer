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
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    
    override var shouldAutorotate:Bool {
        return false
    }
    
    func initView() {
        self.view.backgroundColor = UIColor.white
        self.title = self.model.name
        
        initPlayer(filePath: self.model.path, superView: self.view)
        self.player.play()
        
        
        
        self.view.addSubview(self.slider)
        self.view.addSubview(self.loadTimeLabel)
        self.view.addSubview(self.totalTimeLabel)
        self.view.addSubview(self.pasueButton)
    }
    
    lazy var slider : UISlider = { [weak self] in
        let slider  = UISlider(frame: CGRect(x: 80, y: screenObject.width - 85, width:screenObject.height - 160, height: 10))
        slider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .valueChanged)
        return slider
    }()
    
    lazy var loadTimeLabel : UILabel = { [weak self] in
        let loadTimeLabel = UILabel(frame: CGRect(x: 20, y: (self?.slider.frame.maxY)!, width: 100, height: 20))
        loadTimeLabel.text = "00:00:00"
        return loadTimeLabel
    }()
    
    lazy var totalTimeLabel : UILabel = { [weak self] in
        let totalTimeLabel =  UILabel(frame: CGRect(x: (self?.slider.frame.maxX)! - 100, y: (self?.slider.frame.maxY)!, width: 100, height: 20))
        totalTimeLabel.text = "00:00:00"
        return totalTimeLabel
    }()
    
    lazy var pasueButton : UIButton = { [weak self] in
        let button = UIButton(frame: CGRect(x: 20, y: 280, width: 60, height: 30))
        button.setTitle("暂停", for: .normal)
        button.setTitle("播放", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(pauseButtonSelected(sender:)), for: .touchUpInside)
        return button
    }()
    
    func initPlayer(filePath:String, superView:UIView) {
        let url = NSURL(fileURLWithPath: filePath)
        
        let playItem = AVPlayerItem(url: url as URL)
        self.player = AVPlayer.init(playerItem: playItem)
        self.player.rate = 1.0
        
        self.playerLayer = AVPlayerLayer.init(player: self.player)
        self.playerLayer.backgroundColor = UIColor.red.cgColor
        self.playerLayer.videoGravity = .resizeAspectFill
        self.playerLayer.frame = CGRect(x: 0,
                                        y: 0,
                                        width: superView.frame.size.height,
                                        height: superView.frame.size.width)
        superView.layer.addSublayer(self.playerLayer)
        
//        playItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
//        playItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
//        playItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
//        playItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(playToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
//
//        self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self](time) in
//            //当前正在播放的时间
//            let loadTime = CMTimeGetSeconds(time)
//            //视频总时间
//            let totalTime = CMTimeGetSeconds((self?.player.currentItem?.duration)!)
//            //滑块进度
//            self?.slider.value = Float(loadTime/totalTime)
//            self?.loadTimeLabel.text = self?.changeTimeFormat(timeInterval: loadTime)
//            self?.totalTimeLabel.text = self?.changeTimeFormat(timeInterval: CMTimeGetSeconds((self?.player.currentItem?.duration)!))
//        }
    }
    
    func play(){
        self.player.play()
    }
    
    //播放进度
    @objc func sliderValueChange(sender:UISlider){
        if self.player.status == .readyToPlay {
            let time = Float64(sender.value) * CMTimeGetSeconds((self.player.currentItem?.duration)!)
            let seekTime = CMTimeMake(value: Int64(time), timescale: 1)
            self.player.seek(to: seekTime)
        }
    }
    
    //转时间格式
    func changeTimeFormat(timeInterval:TimeInterval) -> String{
        return String(format: "%02d:%02d:%02d",(Int(timeInterval) % 3600) / 60, Int(timeInterval) / 3600,Int(timeInterval) % 60)
    }
    
    //暂停
    @objc func pauseButtonSelected(sender:UIButton)  {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            self.player.pause()
        }else{
            self.player.play()
        }
    }
    
    @objc func playToEndTime(){
        print("播放完成")
    }
}
