//
//  FirstViewController.swift
//  ChromaKeyTest
//
//  Created by Florian Bürger on 08/07/16.
//  Copyright © 2016 Florian Bürger. All rights reserved.
//

import UIKit
import GPUImage

class FirstViewController: UIViewController {
    
    @IBOutlet weak var renderView: RenderView!
    
    @IBOutlet weak var smoothingSlider: UISlider!
    @IBOutlet weak var tresholdSlider: UISlider!
    
    var picture = PictureInput(image: UIImage(named: "test.jpg")!)
    var blendPicture = PictureInput(image: UIImage(named: "forest.jpg")!)
    var filter = ChromaKeying()
    var color: Color = Color(red: 42/255, green: 253/255, blue: 52/255)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filter.thresholdSensitivity = 0.3
        filter.colorToReplace = color
        
        smoothingSlider.value = filter.smoothing
        tresholdSlider.value = filter.thresholdSensitivity
        
        renderView.backgroundRenderColor = Color(red: 1, green: 1, blue: 1)
        renderView.backgroundColor = UIColor.clearColor()
        
        process()
    }
    
    
    @IBAction func thresholdSliderMoved(sender: UISlider) {
        filter.thresholdSensitivity = sender.value
        process()
    }

    @IBAction func smoothingSliderMoved(sender: UISlider) {
        filter.smoothing = sender.value
        process()
    }

    @IBAction func applyFilterTapped(sender: UIButton) {
        process()
    }
    
    private func process() {
        picture --> filter --> renderView
        picture.processImage()
    }
    
    func pictureURL() -> NSURL {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let url = NSURL(fileURLWithPath: path)
        return url.URLByAppendingPathComponent("picture.png")
    }
}
