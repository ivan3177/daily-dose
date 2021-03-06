//
//  HomeVC.swift
//  daily-dose
//
//  Created by Иван on 28.01.2018.
//  Copyright © 2018 iSOKOL DEV. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeVC: UIViewController {
    // Outlets
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var removeAdsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAds()
    }
    
    func removeAds() {
        removeAdsButton.removeFromSuperview()
        bannerView.removeFromSuperview()
    }
    
    func setupAds() {
        if !UserDefaults.standard.bool(forKey: IAP_REMOVE_ADS) {
            bannerView.adUnitID = GOOGLE_ADMOB_ADBLOCK_BANNER
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        } else {
            removeAds()
        }
    }

    @IBAction func removeAdsPressed(_ sender: Any) {
        PurchaseManager.instance.purhcaseRemoveAds { (success) in
            if success {
                self.removeAds()
            } else {
                print("Failed")
            }
        }
    }
    @IBAction func restoreBtnPressed(_ sender: Any) {
        PurchaseManager.instance.restorePurchases { (success) in
            if success {
                self.setupAds()
            }
        }
    }
}

