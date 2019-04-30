//
//  VideoCell.swift
//  YouTubeClone
//
//  Created by ibrahim zakarya on 7/8/17.
//  Copyright © 2017 ibrahim zakarya. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        
    }

}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            setupThumbnailImage()
//            thumbnilImageView.image = UIImage(named: (video?.thumbnailImageName)!)
            
//            if let profileImageName = video?.channel?.profileImageName {
//                userProfileImageView.image = UIImage(named: profileImageName)
//            }
            setupChannelImage()
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                let numberFormater = NumberFormatter()
                numberFormater.numberStyle = .decimal
                
                let subtitleText = "\(channelName) - \(numberFormater.string(from: numberOfViews)!) - 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    func setupChannelImage() {
        
        if let channelImage = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlSting: channelImage)
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnilImageView.loadImageUsingUrlString(urlSting: thumbnailImageUrl)
        }
    }
    
    let thumbnilImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "balnk-space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "profile")
        imageView.layer.cornerRadius = 22
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let spratorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "TaylorSwiftVEVO - 1,333,423,765 Views - 2 years ago"
        textView.textColor = .lightGray
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnilImageView)
        addSubview(spratorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsFormat(format: "H:|-16-[v0]-16-|", views: thumbnilImageView)
        addConstraintsFormat(format: "V:|-16-[v0]-8-[v1(44)]-28-[v2(1)]|", views: thumbnilImageView, userProfileImageView, spratorView)
        addConstraintsFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsFormat(format: "H:|[v0]|", views: spratorView)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnilImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnilImageView, attribute: .right, multiplier: 1, constant: 0))
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        addConstraint(titleLabelHeightConstraint!)
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnilImageView, attribute: .right, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}

