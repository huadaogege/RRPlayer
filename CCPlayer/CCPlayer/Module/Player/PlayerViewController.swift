//
//  PlayerViewController.swift
//  CCPlayer
//
//  Created by 崔玉冠 on 2020/11/21.
//

import Foundation
import UIKit

class PlayerViewController: UIViewController {
    
    var screenObject = UIScreen.main.bounds
    
    var model:PlayModel!
    
    func initModel(_ model:PlayModel) {
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.playView)
        self.title = self.model.name
    }
    
    lazy var playView = {() -> UIView in
        var playView = UIView.init(frame: CGRect(x: 0, y: (screenObject.height - 300)/2.0, width: screenObject.width, height: 250))
        playView.backgroundColor = UIColor.black
        return playView
    }()
}
