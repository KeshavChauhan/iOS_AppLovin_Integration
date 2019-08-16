import UIKit
import AppLovinSDK

class IntZone2ViewController: UIViewController {
     // MARK: - ActionMethods
    @IBOutlet weak var reqIntZ1Button: UIButton!
    @IBOutlet weak var showIntZ2Button: UIButton!
    
    var ad: ALAd?
    var interstitialZone2 = "eb0a39c04772b2f6"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad called")
        showIntZ2Button.isEnabled = false
        showIntZ2Button.alpha = 0.5
    }
    
    @IBAction func reqAd(_ sender: Any) {
        print("Load clicked")
        ALSdk.shared()?.adService.loadNextAd(forZoneIdentifier: interstitialZone2, andNotify: self)
    }
    
    @IBAction func showAd(_ sender: Any) {
        print("Show Clicked")
        
        showIntZ2Button.isEnabled = false
        showIntZ2Button.alpha = 0.5
        
        if let ad = self.ad
        {
            ALInterstitialAd.shared().adDisplayDelegate = self
            ALInterstitialAd.shared().adVideoPlaybackDelegate = self
            ALInterstitialAd.shared().show(ad)
            print("Interstitial Shown")
        }
    }
}

extension IntZone2ViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        self.ad = ad
        showIntZ2Button.isEnabled = true
        showIntZ2Button.alpha = 1
        print("ad loaded")
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32) {
        print("Failed to load ad with error")
    }
}

extension IntZone2ViewController : ALAdDisplayDelegate
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

extension IntZone2ViewController : ALAdVideoPlaybackDelegate
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
