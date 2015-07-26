//
//  CardsViewController.swift
//  LoveGuru
//
//  Created by Kashish Goel on 2015-07-24.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, SwipeviewDelegate {
    
    struct Card {
        let cardView:CardView
        let swipeView:SwipeView
        let user:User
    }
    
    
    let frontCardTopMargin:CGFloat = 0
    let backCardTopMargin:CGFloat = 10
    @IBOutlet weak var cardStackView: UIView!
    
    @IBOutlet weak var nahButton: UIButton!
    @IBOutlet weak var yeahButton: UIButton!
    
    var backCard:Card?
    var frontCard:Card?
    var users: [User]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "nav-header"))
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToProfile:")
        navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        backCard = createCard(backCardTopMargin)
//        self.cardStackView.addSubview(backCard!.swipeView)
//        
//        frontCard = createCard(frontCardTopMargin)
//        self.cardStackView.addSubview(frontCard!.swipeView)
        
        cardStackView.backgroundColor = UIColor.clearColor()
        nahButton.setImage(UIImage(named: "nah-button-pressed"), forState: UIControlState.Highlighted)
        yeahButton.setImage(UIImage(named: "yeah-button-pressed"), forState: UIControlState.Highlighted)
        
        fetchUnViewedUsers { (users) -> () in
            self.users = users
            if let card = self.popCard() {
            self.frontCard = card
                self.cardStackView.addSubview(self.frontCard!.swipeView)
            }
            
            if let card = self.popCard() {
            self.backCard = card
                self.backCard?.swipeView.frame = self.createCardFrame(self.backCardTopMargin)
                self.cardStackView.insertSubview(self.backCard!.swipeView, belowSubview: self.frontCard!.swipeView)
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //button actions
    @IBAction func nahButtonPressed(sender: UIButton) {
        if let card = frontCard {
        card.swipeView.swipe(SwipeView.Direction.Left)
        }
    }
    @IBAction func yeahButtonPressed(sender: UIButton) {
        if let card = frontCard {
        card.swipeView.swipe(SwipeView.Direction.Left)
        }
    }
    
    
    private func createCardFrame(topMargin:CGFloat) -> CGRect {
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
        
        
    }
    private func createCard(user:User)-> Card {
        let cardView = CardView ()
        cardView.name = user.name
        user.getPhoto { (image) -> () in
            cardView.image = image
        }
        
        let swipeView = SwipeView(frame: createCardFrame(0))
        swipeView.delegate = self
        swipeView.innerView = cardView
        return Card(cardView: cardView, swipeView: swipeView, user:user)
    }
    
    private func popCard ()-> Card? {
        if users != nil && users?.count > 0 {
        return self.createCard(users!.removeLast())
        }
        return nil
    
    }
    
    func swipedLeft() {
        println("left")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()
            saveSkip(frontCard.user)
            switchCards()
        } }
    
    func swipedRight() {
        println("right")
        if let frontCard = frontCard
        { frontCard.swipeView.removeFromSuperview()}
        saveLike(frontCard!.user)
        switchCards()
    }
    
    func goToProfile (button:UIBarButtonItem) {
    pageController.goToPreviousVC()
    }
    
    private func switchCards() {
        if let card = backCard {
        frontCard = card
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.frontCard!.swipeView.frame = self.createCardFrame(self.frontCardTopMargin)
            })
        }
        if let card = self.popCard() {
        self.backCard = card
            self.backCard!.swipeView.frame = self.createCardFrame(self.backCardTopMargin)
            self.cardStackView.insertSubview(self.backCard!.swipeView, belowSubview: self.frontCard!.swipeView)
        }
    
    
    }
    
    
    
}


