//
//  ViewController.swift
//  CodingChallengeWanna_VN
//
//  Created by Victor Nasser on 27/04/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EffectsViewController
        vc.image = sender as? UIImage
    }

    @IBAction func selectSource(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select photo", message: "Where your photo comes from?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Photos library", style: .default, handler: { (action) in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Album", style: .default, handler: { (action) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        })
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            let originalWidth = image.size.width
            let aspectRatio = originalWidth / image.size.height
            var smallSize: CGSize
            if aspectRatio > 1 {  //landscape
                smallSize = CGSize(width: 1000, height: 1000/aspectRatio)
            } else { // portrait
                smallSize = CGSize(width: 1000*aspectRatio, height: 1000)
            }
            
            UIGraphicsBeginImageContext(smallSize)
            image.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
            let smallImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dismiss(animated: true, completion: {
                self.performSegue(withIdentifier: "effectsSegue", sender: smallImage)
            })
        }
    }
}

