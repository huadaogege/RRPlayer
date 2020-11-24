//
//  PlayFileParser.swift
//  CCPlayer
//
//  Created by 崔玉冠 on 2020/11/22.
//

import Foundation
import UIKit
import AVFoundation

class PlayFileParser: NSObject {
    
    func iconOfVideo(filePath:String) -> UIImage {
        let url = URL(fileURLWithPath: filePath)
        let asset = AVURLAsset.init(url: url, options: nil)
        let gen = AVAssetImageGenerator.init(asset: asset)
        gen.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 1)
        var icon:UIImage = UIImage.init()
        var actualTime : CMTime = CMTimeMakeWithSeconds(0, preferredTimescale: 0)
            do {
                let image = try gen.copyCGImage(at: time, actualTime: &actualTime)
                icon = UIImage.init(cgImage: image)
            } catch  {
                print("错误")
            }
        return icon
    }
    
    func nameOfVideo(filePath:String) -> String {
        let url:URL = URL(fileURLWithPath: filePath)
        let name = url.pathExtension
        return name
    }
    
    func totalTimeOfVideo(filePath:String) -> String {
        let url = URL(fileURLWithPath: filePath)
        let playItem = AVPlayerItem(url: url as URL)
        let totalTime:Int = Int(CMTimeGetSeconds(playItem.asset.duration))
        
        var h = String(totalTime/(60*60))
        h = (h.count == 1) ? ("0" + h) : h
        var m = String((totalTime%(60*60))/60)
        m = (m.count == 1) ? ("0" + m) : m
        var s = String(totalTime%(60))
        s = (s.count == 1) ? ("0" + s) : s
        let time = h + ":" + m + ":" + s
        return time
    }
    
    func sizeOfVideo(filePath:String) -> String {
        var fileSize : UInt64 = 0
        var unit = "GB"
        var size:Float = 0.0
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: filePath)
            fileSize = attr[FileAttributeKey.size] as! UInt64
             
            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
            
            if fileSize/(1000*1000*1000) >= 1 {
                unit = "GB"
                size = Float(Int(fileSize)/(1000*1000*Int(1000)))
            } else if fileSize/(1000*1000) >= 1 {
                unit = "MB"
                size = Float(Double(fileSize)/(1000*1000.0))
            } else {
                unit = "KB"
                size = Float(Double(fileSize)/1000)
            }
        } catch {
            print("Error: \(error)")
        }
        return String(format: "%.2f", size) + unit
    }
}
