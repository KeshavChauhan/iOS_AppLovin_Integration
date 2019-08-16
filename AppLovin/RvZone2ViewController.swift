import UIKit
import AppLovinSDK

class RvZone2ViewController: UIViewController {
     // MARK: - ActionMethods
    @IBOutlet weak var reqRvZ2Button: UIButton!
    @IBOutlet weak var showRvZ2Button: UIButton!
    
    var rvZone2 = "7a3d13c85f0a7ecc"
    
    private var rvAd: ALIncentivizedInterstitialAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showRvZ2Button.isEnabled = false
        showRvZ2Button.alpha = 0.5
        
        rvAd = ALIncentivizedInterstitialAd(zoneIdentifier: rvZone2)
    }
    
    @IBAction func reqAd(_ sender: Any) {
        print("loadRvAd called")
        rvAd.preloadAndNotify(self)
    }
    
    @IBAction func showAd(_ sender: Any) {
        showRvZ2Button.isEnabled = false
        showRvZ2Button.alpha = 0.5
        print("showRvAd called")
        if rvAd.isReadyForDisplay{
            rvAd.showAndNotify(self)
        }
        else{
            reqAd((Any).self)
        }
    }
}

extension RvZone2ViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        print("Rewarded Video Loaded")
        showRvZ2Button.isEnabled = true
        showRvZ2Button.alpha = 1
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        print("Rewarded video failed to load with error code \(code)")
    }
}

extension RvZone2ViewController : ALAdRewardDelegate
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
            // Some issue, don't reward.
        }
        else if responseCode == kALErrorCodeIncentiviziedAdNotPreloaded
        {
            // Rewarded video called before it was available.
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

extension RvZone2ViewController : ALAdDisplayDelegate
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

extension RvZone2ViewController : ALAdVideoPlaybackDelegate
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
