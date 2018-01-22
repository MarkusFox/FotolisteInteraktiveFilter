//
//  ImageViewController.swift
//  FotolisteInteraktiveFilter
//
//  Created by Markus Fox on 21.01.18.
//  Copyright © 2018 Markus Fox. All rights reserved.
//

import UIKit
import Photos

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            activityIndicator.stopAnimating()
        }
    }
    
    private var isSwiping: Bool = false
    private var initialPosition: CGPoint?
    
    func setDisplayImage(_ image: PHAsset, imageManager: PHCachingImageManager) {
        activityIndicator.startAnimating()
        /*
         might be unneccessary in this assignment but: use [weak self] to prevent a memory cycle loop
         we don't want the imagerequest to keep the controller alive, although it might not even be used anymore
        */
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            imageManager.requestImageData(for: image, options: nil) { (data, _, _, _) in
                let retrievedPhoto = UIImage(data: data!)
                DispatchQueue.main.async {
                    self?.image = retrievedPhoto
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSwiping = true
        initialPosition = touches.first?.location(in: self.view)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let from = initialPosition, let to = touches.first?.location(in: self.view) {
            let xDiff = max(from.x, to.x) - min(from.x, to.x)
            let yDiff = max(from.y, to.y) - min(from.y, to.y)
            //print(xDiff)
            //print(yDiff)
            if xDiff >= yDiff {
                //TODO Sättigung Filter
                print("Sättigung")
            } else {
                //TODO CIStyllize Filter
                print("CIStylize")
            }
        }
        isSwiping = false
        initialPosition = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
