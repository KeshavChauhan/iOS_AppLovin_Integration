import UIKit
import AppLovinSDK

class IntZone1ViewController: UIViewController {
    // MARK: - ActionMethods
    @IBOutlet weak var reqButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    
    var ad: ALAd?
    var interstitialZone1 = "a45262325bad5d82"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad called")
        showButton.isEnabled = false
        showButton.alpha = 0.5
    }
    
    @IBAction func loadAd(_ sender: Any) {
        print("Load clicked")
        ALSdk.shared()?.adService.loadNextAd(forZoneIdentifier: interstitialZone1 , andNotify: self)
    }
    
    @IBAction func showAd(_ sender: Any) {
        print("Show Clicked")
        
        showButton.isEnabled = false
        showButton.alpha = 0.5
        
        if let ad = self.ad {
            ALInterstitialAd.shared().adDisplayDelegate = self
            ALInterstitialAd.shared().adVideoPlaybackDelegate = self
            ALInterstitialAd.shared().show(ad)
            print("Interstitial Shown")
        }
    }    
}

extension IntZone1ViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        self.ad = ad
        showButton.isEnabled = true
        showButton.alpha = 1
        print("ad loaded")
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        print("Failed to load ad with error")
    }
}

extension IntZone1ViewController : ALAdDisplayDelegate
{
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView)
    {
        print("Interstitial Displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView)
    {
        print("Interstitial Dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView)
    {
        print("Interstitial Clicked")
    }
}

extension IntZone1ViewController : ALAdVideoPlaybackDelegate
{
    func videoPlaybackBegan(in ad: ALAd)
    {
        print("Video Started")
    }
    
    func videoPlaybackEnded(in ad: ALAd, atPlaybackPercent percentPlayed: NSNumber, fullyWatched wasFullyWatched: Bool)
    {
        print("Video Ended")
    }
}
