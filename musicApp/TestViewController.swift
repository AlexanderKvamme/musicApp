//
//  TestView.swift
//  musicApp
//
//  Created by Alexander Kvamme on 27/12/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//


import Foundation
import UIKit
import MediaPlayer

class TestViewController: UIViewController {
    
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .purple
    }
    
    override func viewDidLoad() {
        addSubviewsAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Methods
    
    private func addSubviewsAndConstraints() {
        
//        view.addSubview(topLabel)
//        view.addSubview(bottomLabel)
        view.addSubview(plusButton)
//        view.addSubview(nextItemButton)
//
//        view.backgroundColor = .green
//        view.isUserInteractionEnabled = false
//
        NSLayoutConstraint.activate([
//            // Top label
//            topLabel.widthAnchor.constraint(equalToConstant: 200),
//            topLabel.heightAnchor.constraint(equalToConstant: SongCell.iconHeight),
//            topLabel.topAnchor.constraint(equalTo: view.topAnchor),
//            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
//            // Bottom label
//            bottomLabel.widthAnchor.constraint(equalToConstant: 200),
//            bottomLabel.heightAnchor.constraint(equalToConstant: SongCell.iconHeight),
//            bottomLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
//            // "+" button
//            plusButton.widthAnchor.constraint(equalToConstant: SongCell.iconHeight-8),
//            plusButton.heightAnchor.constraint(equalToConstant: SongCell.iconHeight-8),
//            plusButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            plusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
//
//            // Next item button
//            nextItemButton.widthAnchor.constraint(equalToConstant: SongCell.iconHeight-8),
//            nextItemButton.heightAnchor.constraint(equalToConstant: SongCell.iconHeight-8),
//            nextItemButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            nextItemButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            ])
    }

    @objc private func plusButtonHandler() {
        print("would add next")
    }
    
    @objc private func nextItemHandler() {
        print("nextItemHandler")
    }
}
