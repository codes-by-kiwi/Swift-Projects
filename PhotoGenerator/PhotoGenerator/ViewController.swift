//
//  ViewController.swift
//  PhotoGenerator
//
//  Created by Fizza Usman on 9/27/22.
//

// in the viewcontroller you build out your app

import UIKit

class ViewController: UIViewController {

    //bring in the image view which will show a random image every time button is tapped
    // the imageView is going to be a user interface image view
    
    private let imageView: UIImageView = {
        //create an imageview
        let imageView = UIImageView()
        //we dont want the image we bring in to be stretched and look weird
        // we want this to maintain aspect ratio and fit inside or fill inside the image's frame
        imageView.contentMode = .scaleAspectFill
        // we are going to assign image a background color to see something as we dont have any image yet
        imageView.backgroundColor = .white
        return imageView
    }()
    
    // create a button that automatically generates a new photo instead of user logging in and out of app repetedly
    private let button: UIButton = {
        let button = UIButton()
        //give button title and a background color
        button.backgroundColor = .magenta
        //for the normal state show this title
        button.setTitle("Generate New Pic", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // change background color everytime new pic is generated
    
    let colors: [UIColor] = [.systemPink, .systemBlue, .systemGreen, .systemTeal, .systemPurple]
    override func viewDidLoad() {
        super.viewDidLoad()
        // we want a different background color
        view.backgroundColor = .systemBlue
        //create the image as a subview
        view.addSubview(imageView)
        // give the image view a height and a width by assigning its frame
        // x and y at 0,0 refer to top left of your view
        imageView.frame = CGRect(x:0,y:0,width:300,height:400)
        // center the image view by saying that the imageview center is same as current view center
        imageView.center = view.center
        
        view.addSubview(button)
        getRandomPhoto()
        // the func we want to call resides in the current class so write self
        //A selector is the name used to select a method to execute for an object,
        // apple calls tap a touchUpInside
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
//objc is needed to attach func to a button
   @objc func didTapButton() {
     // whenever we tap button we want to get a random pic
        getRandomPhoto()
        
       view.backgroundColor = colors.randomElement()
    }
    
    // The button will get pushed up from the home bar because you are not putting this func info in viewDidLoad
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //give the button a frame
        // the width is going to be the entire width of the current view minus 40
        //safeAreaInsets take into account the amount that the home bar is taking up
        button.frame = CGRect(x: 35, y: view.frame.size.height-120-view.safeAreaInsets.bottom, width: view.frame.size.width-40, height: 60)
        //as you will see button appears to the bottom of the screen here
        
    }
// get a random photo from the internet
    
    func getRandomPhoto () {
        let urlString =
            "https://picsum.photos/500/500"
        // we are going to convert String into an image
        // add an exclamation point at the end to indicate to swift that we know that the url is valid
        let url = URL(string : urlString)!
        // get contents of url via data, if not possible then just stop
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        // create an image from the data. assign imageView's image property
        // by saying that this is a ui image created using data gotten back from the internet
        imageView.image = UIImage(data: data)
        
    }

}

