//
//  ViewController.swift
//  YouTubeClone
//
//  Created by ibrahim zakarya on 7/5/17.
//  Copyright © 2017 ibrahim zakarya. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var videos: [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBestChannel"
//        kanyeChannel.profileImageName = "kanye"
//        
//        var blankSpacVideo = Video()
//        blankSpacVideo.title = "Taylor Swift - Blank Space"
//        blankSpacVideo.thumbnailImageName = "balnk-space"
//        blankSpacVideo.numberOfViews = 328979344
//        blankSpacVideo.channel = kanyeChannel
//        var badBlooodVideo = Video()
//        badBlooodVideo.title = "Taylor Swift - BadBlood ft. Kendrick Lamar"
//        badBlooodVideo.thumbnailImageName = "badblood"
//        badBlooodVideo.channel = kanyeChannel
//        badBlooodVideo.numberOfViews = 234235235
//        return [blankSpacVideo, badBlooodVideo]
//    }()
    
    var videos: [Video]?
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, reponse, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [Video]()
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    let chanelDict = dictionary["channel"] as! [String: AnyObject]
                    let chanel = Channel()
                    chanel.name = chanelDict["name"] as? String
                    chanel.profileImageName = chanelDict["profile_image_name"] as? String
                    video.channel = chanel
                    self.videos?.append(video)
                }
                self.collectionView?.reloadData()
                
            } catch let jsonError {
                print(jsonError)
            }
            
            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        }).resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navTitle.text = "Home"
        navTitle.textColor = .white
        navTitle.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = navTitle
        navigationController?.navigationBar.isTranslucent = false
        
        
        
        collectionView?.backgroundColor = .white
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "trending")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    func handleSearch() {
        print("123")
    }
    
    func handleMore() {
        print("123")
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 32) * 9 / 16
        
        return CGSize(width: view.frame.width, height: height + 16 + 86)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

















