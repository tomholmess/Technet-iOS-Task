//
//  HomeViewController.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import Foundation
import UIKit
import SDWebImage

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, APIServiceDelegate {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        let images = videos[indexPath.row].images
        if let thumbnailImage = images?.first(where: { image in
            image.type == "thumbnail"
        }) {
            cell.mainImageView.sd_setImage(with: URL(string: thumbnailImage.url!))
        }

        cell.durationLabel.text = videos[indexPath.row].duration
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "IDViewController") as! IDViewController
        vc.modalPresentationStyle = .fullScreen
        vc.id = videos[indexPath.row].id
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 175)
    }
    
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//        return UIContextMenuConfiguration(
//            identifier: nil,
//            previewProvider: {
//
//            })
//    }
    
    func onVideoResponse(videos: [Video]) {
        self.videos = videos
        collectionView.reloadData()
    }
    
}