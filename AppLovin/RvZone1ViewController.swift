import UIKit
import AppLovinSDK

class RvZone1ViewController: UIViewController {
     // MARK: - ActionMethods
    @IBOutlet weak var reqRvButton: UIButton!
    @IBOutlet weak var showRvButton: UIButton!
    
    var rvZone1 = "33f15d4fac8b3acc"
    
    private var rvAd: ALIncentivizedInterstitialAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showRvButton.isEnabled = false
        showRvButton.alpha = 0.5
        
        rvAd = ALIncentivizedInterstitialAd(zoneIdentifier: rvZone1)
    }
    
    @IBAction func loadRvAd(_ sender: Any) {
        print("loadRvAd called")
        rvAd.preloadAndNotify(self)
    }
    
    @IBAction func showRvAd(_ sender: Any) {
        print("showRvAd called")
        showRvButton.isEnabled = false
        showRvButton.alpha = 0.5
        if rvAd.isReadyForDisplay {
            rvAd.showAndNotify(self)
        }
        else {
            loadRvAd((Any).self)
        }
    }
}

extension RvZone1ViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        print("Rewarded Video Loaded")
        showRvButton.isEnabled = true
        showRvButton.alpha = 1
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        print("Rewarded video failed to load with error code \(code)")
    }
}

extension RvZone1ViewController : ALAdRewardDelegate
{
    func rewardValidationRequest(for ad: ALAd, didSucceedWithResponse response: [AnyHashable: Any])
    {
        if let amount = response["amount"] as? NSString, let currencyName = response["currency"] as? NSString
        {
            print("Rewarded \(amount.floatValue) \(currencyName)")
        }
    }
    
    func rewardValidationRequest(for ad: ALAd, didFailWithError responseCode: Int)
    {
        if responseCode == kALErrorCodeIncentivizedUserClosedVideo
        {
            // Exited the video prematurely.
        }
        else if responseCode == kALErrorCodeIncentivizedValidationNetworkTimeout || responseCode == kALErrorCodeIncentivizedUnknownServerError
        {
            // Some server issue.
        }
        else if responseCode == kALErrorCodeIncentiviziedAdNotPreloaded
        {
            // Called for a rewarded video before one was available.
        }
        
        print("Reward validation request failed with error code \(responseCode)")
    }
    
    func rewardValidationRequest(for ad: ALAd, didExceedQuotaWithResponse response: [AnyHashable: Any])
    {
        print("Reward validation request did exceed quota with response: \(response)")
    }
    
    func rewardValidationRequest(for ad: ALAd, wasRejectedWithResponse response: [AnyHashable: Any])
    {
        print("Reward validation request was rejected with response: \(response)")
    }
}

extension RvZone1ViewController : ALAdDisplayDelegate
{
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView)
    {
        print("Ad Displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView)
    {
        print("Ad Dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView)
    {
        print("Ad Clicked")
    }
}

extension RvZone1ViewController : ALAdVideoPlaybackDelegate
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
