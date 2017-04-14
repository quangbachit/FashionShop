//
//  ViewScroll.swift
//  FashionShop
//
//  Created by Quang Bach on 4/14/17.
//  Copyright © 2017 QuangBach. All rights reserved.
//

import UIKit

@objc
class ViewScroll: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var sliderScale: UISlider!
    
    var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "coffee"))
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height)
        imageView.isUserInteractionEnabled = true
        imageView.isMultipleTouchEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: imageView.bounds.width, height: imageView.bounds.height)
        scrollView.maximumZoomScale = 5
        scrollView.minimumZoomScale = 0.5
        scrollView.addSubview(imageView)    
        
    }

    func addTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(oneTap(_:)))
        tap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tap)
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture(_:)))
        doubleTap.numberOfTapsRequired = 2
        tap.require(toFail: doubleTap)
        imageView.addGestureRecognizer(doubleTap)
        
    }
    
    func oneTap(_ gesture: UITapGestureRecognizer){
        let position = gesture.location(in: self.imageView)
        zoomRectForScale(scale: scrollView.zoomScale * 1.5, center: position)
    }
    func doubleTapGesture(_ gesture: UITapGestureRecognizer){
        let position = gesture.location(in: self.imageView)
        zoomRectForScale(scale: scrollView.zoomScale * -1.5, center: position)

    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.size.height = scrollViewSize.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.height / 2)
        
        scrollView.zoom(to: zoomRect, animated: true)
        
        
    }
    
    @IBAction func scaleSlider(_ sender: Any) {
        scrollView.zoomScale = CGFloat(sliderScale.value)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
