//
//  PlayListViewController.swift
//  CCPlayer
//
//  Created by cuiyuguan on 2020/11/21.
//

import Foundation
import UIKit
import AVFoundation

class PlayListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var screenObject = UIScreen.main.bounds
    
    var dataItems : Array<Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        dataItems = testData()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = true
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        let leftButton = UIBarButtonItem(title: "编辑", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editPlayList))
            self.navigationItem.rightBarButtonItem = leftButton
    }
    
    override var shouldAutorotate:Bool {
        return true
    }
    
    @objc func editPlayList() {
        self.tableView.isEditing = !self.tableView.isEditing
    }
    
    func testData() -> Array<PlayModel> {
        let fileManager = CFileManager()
        let pathItems = fileManager.searchDocumentsPaths()
        if pathItems.count == 0 {
            return Array.init()
        }
        
        var models = Array<PlayModel>()
        let parser = PlayFileParser()
        
        for index in 0...(pathItems.count - 1) {
            let filePath = pathItems[index] as! String
            let image = parser.iconOfVideo(filePath: filePath)
            let name = parser.nameOfVideo(filePath: filePath)
            let time = parser.totalTimeOfVideo(filePath: filePath)
            let size = parser.sizeOfVideo(filePath: filePath)
            
            let model = PlayModel.init(name: name, size: size, time: time, path:filePath , icon: image)
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
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(playVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
            if indexPath.row == self.dataItems.count - 1
            {
                // 最后一个时插入
                return UITableViewCell.EditingStyle.insert
            }
            else if indexPath.row == 0
            {
                // 第一个没有编辑模式
                return UITableViewCell.EditingStyle.none
            }
            
            // 其他cell为删除的编辑模式（设置tableView的editing属性进行删除操作；或左滑cell进行删除操作）
        return UITableViewCell.EditingStyle.delete
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            
        
    }
    
}
