
import AVFoundation

public class PlayerService: PlayerServiceProtocol {
    var avPlayer: AVPlayer
    
    public init(avPlayer: AVPlayer) {
        self.avPlayer = avPlayer
    }

    public func play(item: PlayableItem) {
        let item = AVPlayerItem(url: item.fileURL)
        avPlayer.replaceCurrentItem(with: item)
        avPlayer.play()
    }
    
    public func pause() {
        avPlayer.pause()
    }
    
    public func resume() {
        avPlayer.play()
    }
}
