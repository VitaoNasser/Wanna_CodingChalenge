//
//  FinalImageViewController.swift
//  CodingChallengeWanna_VN
//
//  Created by Victor Nasser on 27/04/23.
//

import UIKit
import Photos

class FinalImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.white.cgColor
    }
    
    func saveToAlbum() {
        PHPhotoLibrary.shared().performChanges({
            
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
            let addAssetRequest = PHAssetCollectionChangeRequest()
            addAssetRequest.addAssets([creationRequest.placeholderForCreatedAsset as Any] as NSArray)
            
        }) { (success, error) in
            if !success {
                print(error!.localizedDescription)
            } else {
                let alert = UIAlertController(title: "Image saved", message: "Your image was saved in the album", preferredStyle: .alert)
            }
        }
    }

    @IBAction func saveImage(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.saveToAlbum()
            default:
                let alert = UIAlertController(title: "ERROR", message: "You should allow to access your album to save the image", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func restart(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
