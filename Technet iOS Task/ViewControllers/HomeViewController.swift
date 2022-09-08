//
//  HomeViewController.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import Foundation
import UIKit
import SDWebImage

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, APIServiceDelegate, UIContextMenuInteractionDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let url: String = "https://content-cache.watchcorridor.com/v6/interview"
    
    var videos = [Video]()
    
    var apiService = APIService()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.delegate = self
        apiService.retrieveJSON(forUrl: url)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.clipsToBounds = false
        collectionView.register(UINib(nibName:"ImageCell", bundle: nil), forCellWithReuseIdentifier:"imageCell")
        collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(collectionViewLongPress)))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    // MARK: Collection View Methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        let images = videos[indexPath.row].images
        if let thumbnailImage = images?.first(where: { image in
            image.type == "thumbnail"
        }) {
            cell.titleLabel.isHidden = true
            cell.mainImageView.sd_setImage(with: URL(string: thumbnailImage.url!))
        } else {
            cell.titleLabel.text = videos[indexPath.row].title
            cell.titleLabel.isHidden = false
        }

        cell.durationLabel.text = videos[indexPath.row].duration
        cell.addInteraction(UIContextMenuInteraction(delegate: self))
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "IDViewController") as! IDViewController
        vc.id = videos[indexPath.row].id
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = (collectionView.frame.width - 20) / 2
        return CGSize(width: dimension, height: dimension)
    }
    
    // MARK: - Context Menu Methods
 
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: {
                let vc = self.storyboard?.instantiateViewController(identifier: "imageViewerViewController") as! ImageViewerViewController
                
                let images = self.videos[indexPath.row].images
                if let thumbnailImage = images?.first(where: { image in
                    image.type == "thumbnail"
                }) {
                    vc.imageUrl = thumbnailImage.url
                }
                
                vc.imageDescription = self.videos[indexPath.row].description
                
                return vc
            })
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: nil)
    }
    
    
    // MARK: - API Delegate Methods
    
    func onVideoResponse(videos: [Video]) {
        self.videos = videos.sorted {
            AppServices.convertDateFromISODateString(isoDate: $0.releaseDate!)
            < AppServices.convertDateFromISODateString(isoDate: $1.releaseDate!) }
        collectionView.reloadData()
    }
    
    // MARK: - Gesture Methods
    
    @objc func collectionViewLongPress(_ gr: UILongPressGestureRecognizer) {
        if gr.state == .began {
            let loc = gr.location(in: collectionView)
            if let index = collectionView.indexPathForItem(at: loc) {
                // Handle popup out with description here
            }
        }
    }
    
    @objc func handleLogOut() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
