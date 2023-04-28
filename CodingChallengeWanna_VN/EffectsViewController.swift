//
//  EffectsViewController.swift
//  CodingChallengeWanna_VN
//
//  Created by Victor Nasser on 27/04/23.
//

import UIKit
import CoreImage

class EffectsViewController: UIViewController {
    
    @IBOutlet weak var brightnessSlider: UISlider!
    @IBOutlet weak var contrastSlider: UISlider!
    @IBOutlet weak var saturationSlider: UISlider!
    
    @IBOutlet weak var imageView: UIImageView!

    var image: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        
        context = CIContext()
        currentFilter = CIFilter(name: "CIColorControls")
        beginImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FinalImageViewController
        vc.image = imageView.image
    }

    @IBAction func changeBrightness(_ sender: UISlider) {
        let brightness = "brightness"
        applyProcessing(type: brightness)
    }

    @IBAction func changeContrast(_ sender: UISlider) {
        let contrast = "contrast"
        applyProcessing(type: contrast)
    }
    
    @IBAction func changeSaturation(_ sender: UISlider) {
        let saturation = "saturation"
        applyProcessing(type: saturation)
    }
    
    func beginImage() {
        let beginImage = CIImage(image: image)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    }
    
    func applyProcessing(type: String) {
        guard let outputImage = currentFilter.outputImage else { return }

        switch type {
        case "brightness":
            currentFilter.setValue(brightnessSlider.value, forKey: kCIInputBrightnessKey)
        case "contrast":
            currentFilter.setValue(contrastSlider.value, forKey: kCIInputContrastKey)
        case "saturation":
            currentFilter.setValue(saturationSlider.value, forKey: kCIInputSaturationKey)
        default:
            break
        }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
}
