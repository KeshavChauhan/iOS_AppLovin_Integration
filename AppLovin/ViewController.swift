import UIKit
import AppLovinSDK

class ViewController: UIViewController {
    // MARK: - ActionMethods
    private let adView = ALAdView(size: ALAdSize.sizeBanner())
    
    let bannerHeight: CGFloat = 50
    
    @IBOutlet weak var bannerRefreshButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        bannerRefreshButton.isEnabled = false
        bannerRefreshButton.alpha = 0.5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        adView.adLoadDelegate = self
        adView.adDisplayDelegate = self
        adView.adEventDelegate = self
        adView.translatesAutoresizingMaskIntoConstraints = false
        adView.loadNextAd()
        
        // Center the banner and anchor it to the bottom of the screen.
        view.addSubview(adView)
        view.addConstraints([
            constraint(with: adView, attribute: .leading),
            constraint(with: adView, attribute: .trailing),
            constraint(with: adView, attribute: .bottom),
            NSLayoutConstraint(item: adView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: bannerHeight)
            ])
    }
    
    private func constraint(with adView: ALAdView, attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint
    {
        return NSLayoutConstraint(item: adView,
                                  attribute: attribute,
                                  relatedBy: .equal,
                                  toItem: view,
                                  attribute: attribute,
                                  multiplier: 1.0,
                                  constant: 0.0)
    }

    @IBAction func bannerRefresh(_ sender: Any) {
        adView.loadNextAd()
    }
}

extension ViewController : ALAdLoadDelegate
{
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        print("Banner Loaded")
        bannerRefreshButton.isEnabled = true
        bannerRefreshButton.alpha = 1
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        print("Banner failed to load with error code \(code)")
    }
}

extension ViewController : ALAdDisplayDelegate
{
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView)
    {
        print("Banner Displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView)
    {
        print("Banner Dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView)
    {
        print("Banner Clicked")
    }
}

extension ViewController : ALAdViewEventDelegate
{
    func ad(_ ad: ALAd, didPresentFullscreenFor adView: ALAdView)
    {
        print("Banner did present fullscreen")
    }
    
    func ad(_ ad: ALAd, willDismissFullscreenFor adView: ALAdView)
    {
        print("Banner will dismiss fullscreen")
    }
    
    func ad(_ ad: ALAd, didDismissFullscreenFor adView: ALAdView)
    {
        print("Banner did dismiss fullscreen")
    }
    
    func ad(_ ad: ALAd, willLeaveApplicationFor adView: ALAdView)
    {
        print("Banner will leave application")
    }
    
    func ad(_ ad: ALAd, didReturnToApplicationFor adView: ALAdView)
    {
        print("Banner did return to application")
    }
    
    func ad(_ ad: ALAd, didFailToDisplayIn adView: ALAdView, withError code: ALAdViewDisplayErrorCode)
    {
        print("Banner did fail to display with error code: \(code)")
    }
}

