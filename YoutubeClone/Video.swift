//
//  Video.swift
//  YouTubeClone
//
//  Created by ibrahim zakarya on 7/10/17.
//  Copyright © 2017 ibrahim zakarya. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSData?
    var channel: Channel?
    
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
    
}
