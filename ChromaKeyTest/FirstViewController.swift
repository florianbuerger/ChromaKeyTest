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
    @IBOutlet weak var colorView: UIView!
    var picture: PictureInput? = nil
    var filter = ChromaKeying()
    var color: Color = Color(red: 0, green: 0, blue: 0)
    
    
    @IBAction func pickImageTapped(sender: UIButton) {
        let controller = UIImagePickerController()
        controller.delegate = self
        presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func redSliderMoved(sender: UISlider) {
        color = Color(red: sender.value, green: color.green, blue: color.blue)
        updateFilter()
    }

    @IBAction func greenSliderMoved(sender: UISlider) {
        color = Color(red: color.red, green: sender.value, blue: color.blue)
        updateFilter()
    }

    @IBAction func blueSliderMoved(sender: UISlider) {
        color = Color(red: color.red, green: color.green, blue: sender.value)
        updateFilter()
    }
    
    private func updateFilter() {
        colorView.backgroundColor = UIColor(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: 1.0)
        filter.colorToReplace = color
    }
    
    @IBAction func applyFilterTapped(sender: UIButton) {
        guard let picture = self.picture else { return }
        picture.removeAllTargets()
        picture --> filter --> renderView
        picture.processImage()
    }
}

extension FirstViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let input = PictureInput(image: image)
        input --> renderView
        input.processImage()
        dismissViewControllerAnimated(true, completion: nil)
        picture = input
    }
}
