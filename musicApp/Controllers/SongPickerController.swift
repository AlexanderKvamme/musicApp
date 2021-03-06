//
//  ViewController.swift
//  musicApp
//
//  Created by Alexander Kvamme on 23/12/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import UIKit
import MediaPlayer

class SongPickerController: UIViewController {

    // MARK: - Properties
    
    var currentMediaItemsCollection: MPMediaItemCollection?
    var musicManager: MusicManager = MusicManager()
    
    // Buttons
    
    let inputField: UITextField = {
        let field = UITextField(frame: CGRect(x: 100, y: 100, width: 100, height: 100 ))
        field.backgroundColor = .light
        field.font = UIFont.custom(style: .bold, ofSize: .bigger)
        field.attributedPlaceholder = NSAttributedString(string: "ALL")
        field.textAlignment = .center
        field.autocapitalizationType = .allCharacters
        field.clipsToBounds = true
        return field
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(SongCell.self, forCellReuseIdentifier: "SongCell")
        tv.estimatedRowHeight = SongCell.cellheight
        tv.isMultipleTouchEnabled = true
        return tv
    }()
    
    // MARK: - Initializers
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        print("vdl")
        super.viewDidLoad()
        
        view.backgroundColor = .light
        addSubViewsAndConstraints()
        
        // Delegates
        inputField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .light
        tableView.register(SongCell.self, forCellReuseIdentifier: "SongCell")
        
        inputField.becomeFirstResponder()
        startAvoidingKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        inputField.clearsOnInsertion = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopAvoidingKeyboard()
    }
    
    // MARK: - Methods
    
    private func addSubViewsAndConstraints() {
        // Add subviews
        self.view.addSubview(inputField)
        self.view.addSubview(tableView)
        
        // Disable translation
        inputField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Auto layout
        NSLayoutConstraint.activate([
            
            // Input Filed
            inputField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputField.topAnchor.constraint(equalTo: view.topAnchor),
            inputField.widthAnchor.constraint(equalToConstant: 300),
            inputField.heightAnchor.constraint(equalToConstant: 100),
            
            // TableView
            tableView.topAnchor.constraint(equalTo: inputField.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            ])
        
        if #available(iOS 11.0, *) {
            let guide = view.safeAreaLayoutGuide
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        } else {
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    // MARK: - Tap handlers

    @objc private func printCurrentSong() {
        //print(mediaPlayer.nowPlayingItem?.value(forKey: MPMediaItemPropertyTitle) as? String)
    }
    
    @objc private func togglePlay() {
        
//        mediaPlayer.skipToNextItem()
//        switch self.mediaPlayer.playbackState {
//        case .playing:
//            mediaPlayer.pause()
//        case .paused,.interrupted:
//            mediaPlayer.play()
//        case .stopped:
//            mediaPlayer.play()
//        default:
//            print("State was: ", mediaPlayer.playbackState)
//        }
    }

    func get(onlySongNameContaining str: String) -> [MPMediaItem]? {
        let songNameFilter = MPMediaPropertyPredicate(value: str, forProperty: MPMediaItemPropertyTitle, comparisonType: MPMediaPredicateComparison.contains)
        let typeFilter = MPMediaPropertyPredicate(value: MPMediaType.music.rawValue, forProperty: MPMediaItemPropertyMediaType)
        let myQuery = MPMediaQuery(filterPredicates: [songNameFilter, typeFilter])
        return myQuery.items
    }
    
    func get(songNameContaining str: String) -> [MPMediaItem]? {
        let songNameFilter = MPMediaPropertyPredicate(value: str, forProperty: MPMediaItemPropertyTitle, comparisonType: MPMediaPredicateComparison.contains)
        //let typeFilter = MPMediaPropertyPredicate(value: "music", forProperty: MPMediaItemPropertyMediaType)
        let myQuery = MPMediaQuery(filterPredicates: [songNameFilter])
        return myQuery.items
    }
}

// MARK: - Extensions

// MARK: UITextFieldDelegate Extension

extension SongPickerController: UITextFieldDelegate {
    // MARK: Helpers
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        if let songs = get(onlySongNameContaining: "\(text)\(string)") {
            currentMediaItemsCollection = MPMediaItemCollection(items: songs)
        }
        
        tableView.reloadData()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let coll = currentMediaItemsCollection {
            // Play all songs that appeared in search
            musicManager.playCollection(coll)
        }
        return true
    }
}

// MARK: UITableViewControllerDelegate Extension

extension SongPickerController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = currentMediaItemsCollection?.items[indexPath.row] {
            self.musicManager.playItem(item)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SongCell.cellheight
    }
}

// MARK: UITableVIewDataSource Extension

extension SongPickerController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        if let mediaItem = currentMediaItemsCollection?.items[indexPath.row] {
            cell.setup(with: mediaItem, and: musicManager)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMediaItemsCollection?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

