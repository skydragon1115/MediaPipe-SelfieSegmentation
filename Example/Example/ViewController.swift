//
//  ViewController.swift
//  Example
//
//  Created by Tomoya Hirano on 2020/04/02.
//  Copyright © 2020 Tomoya Hirano. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, SelfieSegmentationDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toggleView: UISwitch!
    var previewLayer: AVCaptureVideoPreviewLayer!
    @IBOutlet weak var xyLabel:UILabel!
    @IBOutlet weak var featurePoint: UIView!
    let camera = Camera()
    let tracker: SelfieSegmentation = SelfieSegmentation()!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camera.setSampleBufferDelegate(self)
        camera.start()
        tracker.startGraph()
        tracker.delegate = self
        
//        previewLayer = AVCaptureVideoPreviewLayer(session: camera.session) as AVCaptureVideoPreviewLayer
//        previewLayer.frame = view.bounds
//        view.layer.addSublayer(previewLayer)
//        view.bringSubviewToFront(xyLabel)
//        view.bringSubviewToFront(featurePoint)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        tracker.processVideoFrame(pixelBuffer)

        DispatchQueue.main.async {
            if !self.toggleView.isOn {
                self.imageView.image = UIImage(ciImage: CIImage(cvPixelBuffer: pixelBuffer!))
            }
        }
    }
    
    func selfieSegmentation(_ selfieSegmentation: SelfieSegmentation!, didOutputPixelBuffer pixelBuffer: CVPixelBuffer!) {
        DispatchQueue.main.async {
            if self.toggleView.isOn {
                self.imageView.image = UIImage(ciImage: CIImage(cvPixelBuffer: pixelBuffer))
            }
        }
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension CGFloat {
    func ceiling(toDecimal decimal: Int) -> CGFloat {
        let numberOfDigits = CGFloat(abs(pow(10.0, Double(decimal))))
        if self.sign == .minus {
            return CGFloat(Int(self * numberOfDigits)) / numberOfDigits
        } else {
            return CGFloat(ceil(self * numberOfDigits)) / numberOfDigits
        }
    }
}

extension Double {
    func ceiling(toDecimal decimal: Int) -> Double {
        let numberOfDigits = abs(pow(10.0, Double(decimal)))
        if self.sign == .minus {
            return Double(Int(self * numberOfDigits)) / numberOfDigits
        } else {
            return Double(ceil(self * numberOfDigits)) / numberOfDigits
        }
    }
}
