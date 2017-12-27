//
//  SongView.swift
//  musicApp
//
//  Created by Alexander Kvamme on 24/12/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class SongCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let iconHeight: CGFloat = 30 // plus button
    static let cellheight: CGFloat = 60
    static let plusImg: UIImage = UIImage.plusSymbol.withRenderingMode(.alwaysTemplate)
    static let nextItemImage: UIImage = UIImage.nextItemSymbol.withRenderingMode(.alwaysTemplate)
    
    let topLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .light
        v.textColor = .dark
        v.isUserInteractionEnabled = false
        return v
    }()
    
    let bottomLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.backgroundColor = .light
        v.font = UIFont.custom(style: .bold, ofSize: .medium)
        v.textColor = .dark
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isUserInteractionEnabled = false
        return v
    }()
    
    let plusButton: UIButton = {
        let v = UIButton()
        v.setImage(plusImg, for: .normal)
        v.tintColor = .dark
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(plusButtonHandler), for: .touchUpInside)
        return v
    }()
    
    let nextItemButton: UIButton = {
        let v = UIButton()
        v.setImage(nextItemImage, for: .normal)
        v.tintColor = .dark
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(nextItemHandler), for: .touchUpInside)
        return v
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        topLabel.text = "topText"
        bottomLabel.text = "botText"
        selectionStyle = .none
        backgroundColor = .light // BG of cell
        
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(_ item: MPMediaItem) {
        self.init()
        
        topLabel.text = item.artist ?? "No artist name"
        bottomLabel.text = (item.title ?? "No title").uppercased()
    }
    
    // MARK: - Methods

    private func addSubviewsAndConstraints() {
        
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(nextItemButton)
        
        contentView.backgroundColor = .red
        contentView.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            // Top label
            topLabel.widthAnchor.constraint(equalToConstant: 200),
            topLabel.heightAnchor.constraint(equalToConstant: SongCell.iconHeight),
            topLabel.topAnchor.constraint(equalTo: topAnchor),
            topLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Bottom label
            bottomLabel.widthAnchor.constraint(equalToConstant: 200),
            bottomLabel.heightAnchor.constraint(equalToConstant: SongCell.iconHeight),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
            // "+" button
            plusButton.widthAnchor.constraint(equalToConstant: SongCell.iconHeight-8),
            plusButton.heightAnchor.constraint(equalToConstant: SongCell.iconHeight-8),
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
        
            // Next item button
            nextItemButton.widthAnchor.constraint(equalToConstant: SongCell.iconHeight-8),
            nextItemButton.heightAnchor.constraint(equalToConstant: SongCell.iconHeight-8),
            nextItemButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nextItemButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            ])
        
        // Bring to front
        contentView.bringSubview(toFront: nextItemButton)
        contentView.bringSubview(toFront: plusButton)
        plusButton.clipsToBounds = true
    }
    
    public func setup(with mediaItem: MPMediaItem) {
        topLabel.text = mediaItem.artist
        bottomLabel.text = mediaItem.title?.uppercased()
        bottomLabel.backgroundColor = .yellow
    }
    
    @objc private func plusButtonHandler() {
        print("would add next")
    }
    
    @objc private func nextItemHandler() {
        print("nextItemHandler")
    }
}
