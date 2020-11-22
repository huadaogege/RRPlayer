//
//  PlayListViewController.swift
//  CCPlayer
//
//  Created by cuiyuguan on 2020/11/21.
//

import Foundation
import UIKit

class PlayListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var screenObject = UIScreen.main.bounds
    
    var dataItems : Array<Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataItems = testData()
        initView()
    }
    
    func testData() -> Array<PlayModel> {
        let nameItems = ["黑客帝国", "007大战皇家赌场", "加勒比海盗", "碟中谍", "盗梦空间", "无耻混蛋"]
        let timeItems = ["01:30:29", "01:23:28", "02:10:29", "00:30:20", "04:30:29", "00:10:09"]
        let sizeItems = ["200MB", "150MB", "1.3GB", "2780MB", "345MB", "176MB", ]
        let pathItems = ["/xx/xxx/xxx", "/xx/xxx/xxx", "/xx/xxx/xxx", "/xx/xxx/xxx", "/xx/xxx/xxx", "/xx/xxx/xxx"]
        var models = Array<PlayModel>()
        for index in 0...(nameItems.count - 1) {
            let model = PlayModel.init(name: nameItems[index], size: sizeItems[index], time: timeItems[index], path: pathItems[index])
            models.append(model)
        }
        return models
    }
    
    func initView() {
        self.title = "播放列表"
        self.view.backgroundColor = UIColor.cyan
        self.view.addSubview(tableView)
    }
    
    lazy var tableView = {() -> UITableView in
        var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenObject.width, height: screenObject.height), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "playList_cell_identifier"
        var cell:PlayListCell!
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PlayListCell
        if (cell == nil) {
            cell = PlayListCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        let model = self.dataItems[indexPath.row]
        cell.setModel(model: model as! PlayModel)
        cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell!
    }
    
    @objc func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataItems[indexPath.row]
        let playVC = PlayerViewController()
        playVC.initModel(model as! PlayModel)
        self.navigationController?.pushViewController(playVC, animated: true)
    }
}