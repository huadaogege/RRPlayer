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
}
