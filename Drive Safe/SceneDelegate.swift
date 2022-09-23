//
//  SceneDelegate.swift
//  Drive Safe
//
//  Created by Nadine Saimua, 2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    // These closures do not get called from the main thread. Depending on
// the use case, you may need to use `DispatchQueue.main.async`, for
// example to update your UI.
let stylePackCancelable = offlineManager.loadStylePack(for: .outdoors,
                                                       loadOptions: stylePackLoadOptions) { _ in
    //
    // Handle progress here
    //
} completion: { result in
    //
    // Handle StylePack result
    //
    switch result {
    case let .success(stylePack):
        // Style pack download finishes successfully
        print("Process \(stylePack)")

    case let .failure(error):
        // Handle error occurred during the style pack download
        if case StylePackError.canceled = error {
            handleCancelation()
        } else {
            handleFailure()
        }
    }
}

// Cancel the download if needed
stylePackCancelable.cancel()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let options = StylePackLoadOptions(glyphsRasterizationMode: .ideographsRasterizedLocally,
                                   metadata: ["my-key": "my-value"],
                                   acceptExpired: false)
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {// When providing a `TileStore` to `ResourceOptions`, you must ensure that
// the `TileStore` is correctly initialized using `setOptionForKey(_:value:)`.
// This includes providing an access token, if you are not using a default
// from the application's Info.plist
tileStore.setOptionForKey(TileStoreOptions.mapboxAccessToken, value: accessToken as Any)

let offlineManager = OfflineManager(resourceOptions: ResourceOptions(accessToken: accessToken,
                                                                     tileStore: tileStore))

// 1. Create the tile set descriptor
let options = TilesetDescriptorOptions(styleURI: .outdoors, zoomRange: 0...16)
let tilesetDescriptor = offlineManager.createTilesetDescriptor(for: options)

// 2. Create the TileRegionLoadOptions
let tileRegionLoadOptions = TileRegionLoadOptions(
    geometry: Geometry(coordinate: tokyoCoord),
    descriptors: [tilesetDescriptor],
    acceptExpired: true)

    }

    func sceneDidBecomeActive(_ scene: UIScene) {let metadata = ["my-key": "my-style-pack-value"]
let options = StylePackLoadOptions(glyphsRasterizationMode: .ideographsRasterizedLocally,
                                   metadata: metadata)
    }

    func sceneWillResignActive(_ scene: UIScene) {
       let metadata = [
    "name": "my-region",
    "my-other-key": "my-other-tile-region-value"]
let tileRegionLoadOptions = TileRegionLoadOptions(
    geometry: Geometry(coordinate: tokyoCoord),
    descriptors: [],
    metadata: metadata,
    acceptExpired: true)
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    // Declare the map's gesture manager delegate
mapView.gestures.delegate = self
...

// Conform to the GestureManagerDelegate protocol
extension BasicMapExample: GestureManagerDelegate {
    public func gestureManager(_ gestureManager: GestureManager, didBegin gestureType: GestureType) {
        print("\(gestureType) didBegin")
    }
    
    public func gestureManager(_ gestureManager: GestureManager, didEnd gestureType: GestureType, willAnimate: Bool) {
        print("\(gestureType) didEnd")
    }
    
    public func gestureManager(_ gestureManager: GestureManager, didEndAnimatingFor gestureType: GestureType) {
        print("didEndAnimatingFor \(gestureType)")
    }
}
}

