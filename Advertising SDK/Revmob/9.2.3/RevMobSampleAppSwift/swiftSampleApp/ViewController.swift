import UIKit



class ViewController: UIViewController, RevMobAdsDelegate {
    
    let REVMOB_ID = "5106be9d0639b41100000052";
    let xPos = 10, buttonWidth = 300,buttonHeight = 50
    var yPos = 30
    var scrollView: UIScrollView = UIScrollView.init(frame: UIScreen.mainScreen().applicationFrame)
    
    var fullscreen: RevMobFullscreen?
    var video: RevMobFullscreen?
    var rewardedVideo: RevMobFullscreen?
    var banner: RevMobBanner?
    var bannerWithDelegate: RevMobBanner?
    var bannerView: RevMobBannerView?
    var link: RevMobAdLink?
    var popUp: RevMobPopup?
    var startedSession = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scrollView);
        scrollView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight,.FlexibleTopMargin]
        createButton("Start Session", selector: #selector(startSession))
        addVoid()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func closeApp(){
        exit(0)
    }
    
    //MARK:- App Layout
    
    func addSampleButtons(){
        createButton("Basic Usage: Fullscreen", selector: #selector(basicUsageFullScreen))
        createButton("Basic Usage: Banner", selector: #selector(basicUsageBanner))
        createButton("Basic Usage: Hide Banner", selector: #selector(basicUsageHideBanner))
        createButton("Basic Usage: Release Banner", selector: #selector(basicUsageReleaseBanner))
        createButton("Basic Usage: Link", selector: #selector(basicUsageLink))
        createButton("Basic Usage: PopUp", selector: #selector(basicUsagePopUp))
        addVoid()
        
        createButton("Show Fullscreen with Delegate", selector: #selector(showFullScreenWithDelegate))
        createButton("Pre-Load Fullscreen", selector: #selector(loadFullscreen))
        createButton("Show pre-loaded Fullscreen", selector: #selector(showLoadedFullscreen))
        createButton("Pre-Load Video", selector: #selector(loadVideo))
        createButton("Show pre-loaded Video", selector: #selector(showVideo))
        createButton("Pre-Load Rewarded Video", selector: #selector(loadRewardedVideo))
        createButton("Show pre-loaded Rewarded Video", selector: #selector(showRewardedVideo))
        addVoid()
        
        createButton("Load Video with completion Block", selector: #selector(loadVideoWithCompletionBlock))
        createButton("Load Rewarded Video w/ completion Block", selector: #selector(loadRewardedVideoWithCompletionBlock))
        addVoid()
        
        createButton("Show Banner With Custom Frame", selector: #selector(showBannerWithCustomFrame))
        createButton("Hide Banner With Custom Frame", selector: #selector(hideBannerWithCustomFrame))
        addVoid()
        
        createButton("Show Banner With Completion Block", selector: #selector(showBannerWithCompletionBlock))
        createButton("Hide Banner With Completion Block", selector: #selector(hideBannerWithCompletionBlock))
        createButton("Release Banner With Completion Block", selector: #selector(releaseBannerWithCompletionBlock))
        addVoid()
        
        
        createButton("Load Banner With Delegate", selector: #selector(preLoadBannerWithDelegate))
        createButton("Show Banner With Delegate", selector: #selector(showBannerWithDelegate))
        createButton("Hide Banner With Delegate", selector: #selector(hideBannerWithDelegate))
        createButton("Release Banner With Delegate", selector: #selector(releaseBannerWithDelegate))
        addVoid()
        
        createButton("Open Ad Link", selector: #selector(openAdLink))
        createButton("Load Ad Link", selector: #selector(loadAdLink))
        createButton("Open Loaded Ad Link", selector: #selector(openLoadedAdLink))
        addVoid()
        
        createButton("Show PopUp", selector: #selector(showPopUp))
        addVoid()
        createButton("Close Sample App", selector: #selector(closeApp))
        
        scrollView.contentSize = CGSizeMake(CGFloat(UIScreen.mainScreen().bounds.width), CGFloat(yPos))
    }

    func createButton(title: String, selector: Selector){
        let button = UIButton()
        button.frame = CGRectMake(CGFloat(xPos), CGFloat(yPos),CGFloat(buttonWidth) , CGFloat(buttonHeight))
        button.backgroundColor = UIColor.grayColor()
        button.setTitle(title, forState: UIControlState.Normal)
        button.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setBackgroundImage(imageWithColor(UIColor.grayColor()), forState: UIControlState.Normal)
        button.setBackgroundImage(imageWithColor(UIColor.lightGrayColor()), forState: UIControlState.Highlighted)
        button.setBackgroundImage(imageWithColor(UIColor.lightGrayColor()), forState: UIControlState.Selected)
        
        
        scrollView.addSubview(button)
        yPos += buttonHeight + 10
        
    }
    func addVoid(){
        yPos += 20
    }
    
    func imageWithColor(color: UIColor) -> UIImage{
        let rect = CGRectMake(CGFloat(0), CGFloat(0), CGFloat(1), CGFloat(1))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    //MARK:- Start Session
    
    func startSession(){
        if(!startedSession){
            startedSession = true
            RevMobAds.startSessionWithAppID(REVMOB_ID, andDelegate: self)
        }
    }
    //MARK:- Basic Usage
    func basicUsageFullScreen(){
        RevMobAds.session().showFullscreen()
    }
    
    func basicUsageBanner(){
        RevMobAds.session().showBanner()
    }
    func basicUsageHideBanner(){
        RevMobAds.session().hideBanner()
    }
    func basicUsageReleaseBanner(){
        RevMobAds.session().releaseBanner()
    }
    func basicUsagePopUp(){
        RevMobAds.session().showPopup()
    }
    func basicUsageLink(){
        RevMobAds.session().openLink()
    }
    //#MARK:- Fullscreen
    
    func showFullScreenWithDelegate(){
        let fs = RevMobAds.session().fullscreen()
        fs.delegate = self
        fs.showAd()
    }
    
    func loadFullscreen(){
        fullscreen = RevMobAds.session().fullscreen()
        fullscreen!.delegate = self
        fullscreen!.loadAd()
    }
    func showLoadedFullscreen(){
        fullscreen!.showAd()
    }
    
    //#MARK:- Video
    func loadVideo(){
        video = RevMobAds.session().fullscreen()
        video!.delegate = self
        video!.loadVideo()
    }
    func showVideo(){
        video!.showVideo()
    }
    
    func loadVideoWithCompletionBlock(){
        let videoWithCompletionBlock = RevMobAds.session().fullscreen()
        let completionBlock: (RevMobFullscreen!) -> Void = {loadedVideo in
            loadedVideo.showVideo()
        }
        let failureBlock: (RevMobFullscreen!,NSError!) -> Void = { loadedVideo,error in
            print("RevMob Video failed to load with error: \(error.localizedDescription)")
        }
        let onClickHandler: () -> Void = { loadedVideo in
            print("RevMob Video Clicked")
        }
        let onCloseHandler: () -> Void = {
            print ("RevMob Video closed")
        }
        videoWithCompletionBlock.loadVideoWithSuccessHandler(completionBlock, andLoadFailHandler: failureBlock, onClickHandler: onClickHandler, onCloseHandler: onCloseHandler)
    }
    
    func loadRewardedVideoWithCompletionBlock(){
        let rewardedVideoWithCompletionBlock = RevMobAds.session().fullscreen()
        let completionBlock: (RevMobFullscreen!) -> Void = {loadedVideo in
            loadedVideo.showRewardedVideo()
        }
        let failureBlock: (RevMobFullscreen!,NSError!) -> Void = { loadedVideo,error in
            print("RevMob Rewarded Video failed to load with error: \(error.localizedDescription)")
        }
        let onCompleteHandler: () -> Void = {
            print ("RevMob Rewarded Video completed")
        }
        rewardedVideoWithCompletionBlock.loadRewardedVideoWithSuccessHandler(completionBlock, andLoadFailHandler: failureBlock, onCompleteHandler:onCompleteHandler)
    }
    
    //#MARK:- Rewarded Video
    
    func loadRewardedVideo(){
        rewardedVideo = RevMobAds.session().fullscreen()
        rewardedVideo!.delegate = self
        rewardedVideo!.loadRewardedVideo()
    }
    func showRewardedVideo(){
        rewardedVideo!.showRewardedVideo()
    }
    //#MARK:- Banner
    func showBannerWithCustomFrame(){
        bannerView = RevMobAds.session().bannerView()
        let completionBlock: (RevMobBannerView!) -> Void = { bannerV in
            print("RevMob Banner Loaded")
            let x = CGFloat(UIScreen.mainScreen().bounds.width/4)
            let y = CGFloat(UIScreen.mainScreen().bounds.height/2)
            let width = CGFloat(UIScreen.mainScreen().bounds.width/2)
            let height = CGFloat(100)
            self.bannerView!.frame = CGRectMake(x, y, width, height)
            self.bannerView!.autoresizingMask = [.FlexibleTopMargin, .FlexibleWidth] //Optional Parameters to handle Rotation Events
            self.view.addSubview(self.bannerView!)
            print("RevMob Banner Displayed")
            
        }
        self.bannerView!.loadWithSuccessHandler(completionBlock, andLoadFailHandler: nil, onClickHandler: nil)
    }
    func hideBannerWithCustomFrame(){
        self.bannerView!.removeFromSuperview()
    }
    
    func showBannerWithCompletionBlock(){
        banner = RevMobAds.session().banner()
        let completionBlock: (RevMobBanner!) -> Void = { revMobBanner in
            print("RevMob Banner Loaded")
            revMobBanner.showAd()
        }
        let failureBlock: (RevMobBanner!, NSError!) -> Void = {revMobBanner, error in
            print("RevMob Banner failed with error: \(error.localizedDescription)")
        }
        let clickHandler: (RevMobBanner!) -> Void = {revMobBanner in
            print("RevMob Banner Clicked")
        }
        banner!.loadWithSuccessHandler(completionBlock, andLoadFailHandler: failureBlock, onClickHandler: clickHandler)
        
    }
    func hideBannerWithCompletionBlock(){
        banner!.hideAd()
    }
    
    func releaseBannerWithCompletionBlock(){
        banner!.releaseAd()
    }
    
    func preLoadBannerWithDelegate(){
        bannerWithDelegate = RevMobAds.session().banner()
        bannerWithDelegate!.delegate = self
        bannerWithDelegate!.loadAd()
    }
    
    func showBannerWithDelegate(){
        bannerWithDelegate?.showAd()
    }
    func hideBannerWithDelegate(){
        bannerWithDelegate?.hideAd()
    }
    
    func releaseBannerWithDelegate(){
        bannerWithDelegate?.releaseAd()
        bannerWithDelegate = nil
    }
    
    //#MARK:- Native Button
    func openAdLink(){
        RevMobAds.session().openLink()
    }
    func loadAdLink(){
        link = RevMobAds.session().adLink()
        link!.delegate = self
        link!.loadAd()
    }
    func openLoadedAdLink(){
        link!.openLink()
    }
    
    //#MARK:- PopUp
    func showPopUp(){
        popUp = RevMobAds.session().popup()
        let completionBlock: (RevMobPopup!) -> Void = {popup in
            print("RevMob PopUp loaded")
            self.popUp!.showAd()
            print("RevMob PopUp displayed")
        }
        let failureBlock: (RevMobPopup!, NSError!) -> Void = {popup,error in
            print("RevMob PopUp failed to load with error" , error)
        }
        let clickHandler: (RevMobPopup! ) -> Void = { popup in
            print("RevMob PopUp clicked")
        }
        popUp!.loadWithSuccessHandler(completionBlock, andLoadFailHandler: failureBlock, onClickHandler: clickHandler)
        
    }
    
    //#MARK:- Delegates
    
    //#MARK: session
    func revmobSessionDidStart() {
        print("session started")
        addSampleButtons()
    }
    
    func revmobSessionDidNotStartWithError(error: NSError!) {
        startedSession = false
        print("RevMobSession Failed to Start")
    }
    //#MARK: fullscreen
    func revmobFullscreenDidDisplay(placementId: String!) {
        
    }
    
    func revmobFullscreenDidReceive(placementId: String!) {
        print("RevMob FullScreen loaded")
    }
    
    func revmobFullscreenDidFailWithError(error: NSError!, onPlacement placementId: String!) {
        print("RevMob FullScreen failed to load with error: \(error.localizedDescription)")
    }
    
    func revmobUserDidClickOnFullscreen(placementId: String!) {
        print("RevMob FullScreen clicked")
    }
    
    func revmobUserDidCloseFullscreen(placementId: String!) {
        print("RevMob FullScreen dismissed")
        
    }
    //MARK: banner
    func revmobBannerDidDisplay(placementId: String!) {
        print("RevMob Banner displayed")
        
    }
    
    func revmobBannerDidReceive(placementId: String!) {
        print("RevMob Banner loadded")
    }
    func revmobBannerDidFailWithError(error: NSError!, onPlacement placementId: String!) {
        print("RevMob Banner failed to load with error: \(error.localizedDescription)")
        
    }
    func revmobUserDidClickOnBanner(placementId: String!) {
        print("RevMob Banner clicked")
    }
    //MARK: video
    func revmobVideoDidLoad(placementId: String!) {
        print("RevMob Video loaded")
    }
    func revmobVideoDidFailWithError(error: NSError!, onPlacement placementId: String!) {
        print("RevMob Video failed to load with error: \(error.localizedDescription)")
    }
    func revmobVideoDidStart(placementId: String!) {
        print("RevMob Video did start")
    }
    func revmobVideoDidFinish(placementId: String!) {
        print("RevMob Video did finish")
    }
    func revmobVideoNotCompletelyLoaded(placementId: String!) {
        print("RevMob Video not loaded yet")
    }
    func revmobUserDidCloseVideo(placementId: String!) {
        print("RevMob Video closed by user")
    }
    func revmobUserDidClickOnVideo(placementId: String!) {
        print("RevMob Video clicked by user")
    }
    
    //MARK: rewarded video
    func revmobRewardedVideoDidLoad(placementId: String!) {
        print("RevMob Rewarded Video  loaded")
    }
    func revmobRewardedVideoDidStart(placementId: String!) {
        print("RevMob Rewarded Videostarted")
    }
    func revmobRewardedVideoDidFailWithError(error: NSError!, onPlacement placementId: String!) {
        print("RevMob Rewarded Video failed to laod with error: \(error.localizedDescription)")
    }
    func revmobRewardedVideoDidFinish(placementId: String!) {
        print("RevMob Rewarded Video did finish")
    }
    func revmobRewardedVideoDidComplete(placementId: String!) {
        
        print("RevMob Rewarded Video did complete")
    }
    func revmobRewardedPreRollDidDisplay(placementId: String!) {
        print("RevMob Rewarded Video pre roll did display")
    }
    func revmobRewardedVideoNotCompletelyLoaded(placementId: String!) {
        print("RevMob Rewarded Video not loaded yet")
    }
    //MARK: native link
    func revmobNativeDidReceive(placementId: String!) {
        print("RevMob  Native Link received")
    }
    func revmobUserDidClickOnNative(placementId: String!) {
        print("RevMob  Native Link clicked")
    }
    func revmobNativeDidFailWithError(error: NSError!, onPlacement placementId: String!) {
        print("RevMob  Native Link  failed with error: \(error.localizedDescription)")
    }
    //MARK: popup
    
    func revmobPopUpDidDisplay(placementId: String!) {
        print("RevMob PopUp displayed")
    }
    func revmobPopUpDidReceive(placementId: String!) {
        print("RevMob PopUp received")
    }
    func revmobPopUpDidFailWithError(error: NSError!, onPlacement placementId: String!) {
        print("RevMob PopUp failed with error: \(error.localizedDescription)")
    }
    func revmobUserDidClosePopUp(placementId: String!) {
        print("RevMob PopUp closed")
    }
    func revmobUserDidClickOnPopUp(placementId: String!) {
        print("RevMob PopUp clicked")
    }
    
    
    
    
}


