//
//  PlayListCell.swift
//  CCPlayer
//
//  Created by 崔玉冠 on 2020/11/21.
//

import Foundation
import UIKit

class PlayListCell: UITableViewCell {
    
    var screenObject = UIScreen.main.bounds
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initView() {
        self.addSubview(self.snapImageView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.sizeLabel)
        self.addSubview(self.timeLabel)
        self.contentView.addSubview(self.editButton)
    }
    
    lazy var snapImageView = {() -> UIImageView in
        var snapImageView = UIImageView.init()
        snapImageView.backgroundColor = UIColor.orange
        snapImageView.frame = CGRect(x: 10, y: 15, width: 140, height: 90)
        snapImageView.layer.cornerRadius = 4
        snapImageView.layer.masksToBounds = true
        return snapImageView
    }()
    
    lazy var nameLabel = {() -> UILabel in
        var nameLabel = UILabel.init(frame:CGRect(x: 155, y: 20, width: 180, height: 25))
        nameLabel.text = "视频名字"
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        return nameLabel
    }()
    
    lazy var sizeLabel = {() -> UILabel in
        var sizeLabel = UILabel.init(frame:CGRect(x: 155, y: 60, width: 100, height: 15))
        sizeLabel.text = "1.5GB"
        sizeLabel.font = UIFont.systemFont(ofSize: 12)
        return sizeLabel
    }()
    
    lazy var timeLabel = {() -> UILabel in
        var timeLabel = UILabel.init(frame: CGRect(x: 155, y: 85, width: 120, height: 15))
        timeLabel.text = "00:00:00 - 01:30:00"
        timeLabel.font = UIFont.systemFont(ofSize: 11)
        return timeLabel
    }()
    
    lazy var editButton = {() -> UIButton in
        var editButton = UIButton.init(frame: CGRect(x: screenObject.width - 60, y: self.center.y, width: 50, height: 30))
        editButton.backgroundColor = UIColor.gray
        editButton.addTarget(self, action: #selector(showEditView), for: .touchUpInside)
        return editButton
    }()
    
    @objc func showEditView() {
        let editView = UIView.init(frame: CGRect(x: screenObject.width - 100, y: 0, width: 90, height: 80))
        editView.backgroundColor = UIColor.red
        self.contentView.addSubview(editView)
        
        let titles = ["加密", "删除"]
        
        for index in 0 ... 1 {
            let button = UIButton.init(frame: CGRect(x: 0, y: index*40, width: 90, height: 40))
            button.setTitle(titles[index], for: .normal)
            button.setImage(UIImage.init(named: ""), for: .normal)
            editView.addSubview(button)
        }
        
    }
    
    func setModel(model:PlayModel) {
        self.snapImageView.image = model.icon
        self.nameLabel.text = model.name
        self.sizeLabel.text = model.size
        self.timeLabel.text = model.time
    }
}
