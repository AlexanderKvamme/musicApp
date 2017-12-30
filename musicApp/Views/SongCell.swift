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
    
    static let cellheight: CGFloat = 60
    static let labelWidth: CGFloat = screenWidth - 2*cellheight
    static let nextItemImageInsets: CGFloat = 5
    static let plusButtonImageInsets: CGFloat = 20
    static let plusImg: UIImage = UIImage.plusSymbol.withRenderingMode(.alwaysTemplate)
    static let nextItemImage: UIImage = UIImage.nextItemSymbol.withRenderingMode(.alwaysTemplate)
    
    var cellsMediaItem: MPMediaItem!
    
    weak var musicManager: MusicManager?
    
    // Computed
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
        v.imageEdgeInsets = UIEdgeInsets(top: plusButtonImageInsets,
                     left: plusButtonImageInsets,
                     bottom: plusButtonImageInsets,
                     right: plusButtonImageInsets)
        v.tintColor = .dark
        v.translatesAutoresizingMaskIntoConstraints = false
        // adding targets here did not work
        return v
    }()
    
    let nextItemButton: UIButton = {
        let v = UIButton()
        v.setImage(nextItemImage, for: .normal)
        v.imageEdgeInsets = UIEdgeInsets(top: nextItemImageInsets,
                                         left: nextItemImageInsets,
                                         bottom: nextItemImageInsets,
                                         right: nextItemImageInsets)
        v.tintColor = .dark
        v.translatesAutoresizingMaskIntoConstraints = false
        // adding targets here did not work
        return v
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        topLabel.text = "topText"
        bottomLabel.text = "botText"
        selectionStyle = .none
        backgroundColor = .light // BG of cell

        // Add Targets
        plusButton.addTarget(self, action: #selector(addToQueue), for: .touchUpInside)
        nextItemButton.addTarget(self, action: #selector(addNextInQueue), for: .touchUpInside)
        
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(_ item: MPMediaItem) {
        self.init()
        
        topLabel.text = item.artist ?? "No artist name"
        bottomLabel.text = (item.title ?? "No title").uppercased()
        
        self.cellsMediaItem = item
    }
    
    // MARK: - Methods

    private func addSubviewsAndConstraints() {
        
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(nextItemButton)
        
        NSLayoutConstraint.activate([
            
            // Top label
            topLabel.widthAnchor.constraint(equalToConstant: 200),
            topLabel.heightAnchor.constraint(equalToConstant: mediumTextHeight),
            topLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            topLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Bottom label
            bottomLabel.widthAnchor.constraint(equalToConstant: 200),
            bottomLabel.heightAnchor.constraint(equalToConstant: mediumTextHeight),
            bottomLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
            // "+" button
            plusButton.widthAnchor.constraint(equalToConstant: SongCell.cellheight),
            plusButton.heightAnchor.constraint(equalToConstant: SongCell.cellheight),
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusButton.centerXAnchor.constraint(equalTo: contentView.rightAnchor, constant: -SongCell.cellheight/2),
        
            // Next item button
            nextItemButton.widthAnchor.constraint(equalToConstant: SongCell.cellheight),
            nextItemButton.heightAnchor.constraint(equalToConstant: SongCell.cellheight),
            nextItemButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nextItemButton.centerXAnchor.constraint(equalTo: contentView.leftAnchor, constant: SongCell.cellheight/2+2),
            ])
        
        // Bring to front
        contentView.bringSubview(toFront: nextItemButton)
        contentView.bringSubview(toFront: plusButton)
        
        // Test colors
//        topLabel.backgroundColor = .yellow
//        bottomLabel.backgroundColor = .green
//        contentView.backgroundColor = .red
    }
    
    public func setup(with mediaItem: MPMediaItem, and musicManager: MusicManager) {
        topLabel.text = mediaItem.artist
        bottomLabel.text = mediaItem.title?.uppercased()
        self.musicManager = musicManager
        self.cellsMediaItem = mediaItem
    }
    
    @objc private func addToQueue() {
        guard let musicManager = musicManager else {
            fatalError("No musicManager avaiable in cell")
        }
        
        musicManager.addToQueue(cellsMediaItem)
    }
    
    @objc private func addNextInQueue() {
        guard let musicManager = musicManager else {
            fatalError("No musicManager available in cell")
        }
        print("gonna add as next")
        musicManager.addAsNext(cellsMediaItem)
    }
}

