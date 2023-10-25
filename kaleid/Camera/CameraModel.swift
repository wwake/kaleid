import AVFoundation
import UIKit

public class CameraModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
  @Published public var error: String?
  @Published public var image: UIImage?

  private var captureSession: AVCaptureSession?
  private var cameraQueue = DispatchQueue(label: "Camera queue")

  override init() {
    super.init()

    getPermission()
    self.captureSession = setupSession()
  }

  func reportError(_ newText: String?) {
    DispatchQueue.main.async {
      self.error = newText
    }
  }

  func getPermission() {
    reportError(nil)
    var allowedAccess = false
    let blocker = DispatchGroup()
    blocker.enter()
    AVCaptureDevice.requestAccess(for: .video) { flag in
      allowedAccess = flag
      blocker.leave()
    }
    blocker.wait()

    if !allowedAccess {
      reportError("User did not allow access to camera")
      return
    }
  }

  func setupSession() -> AVCaptureSession? {
    let session = AVCaptureSession()
    session.beginConfiguration()

    let videoDevice = AVCaptureDevice.default(for: .video)
    guard videoDevice != nil, let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else {
      reportError("No camera detected")
      return nil
    }
    session.addInput(videoDeviceInput)

    let photoOutput = AVCaptureVideoDataOutput()
    guard session.canAddOutput(photoOutput) else {
      reportError("Can't add output images to camera session")
      return nil
    }
    photoOutput.setSampleBufferDelegate(self, queue: cameraQueue)

    session.addOutput(photoOutput)
    session.commitConfiguration()

    return session
  }

  public func captureOutput(
    _ output: AVCaptureOutput,
    didOutput sampleBuffer: CMSampleBuffer,
    from connection: AVCaptureConnection
  ) {
    if let cvImage = sampleBuffer.imageBuffer {

      // copy to jpegData so we don't retain video buffer
      let resultImage = UIImage(ciImage: CIImage(cvPixelBuffer: cvImage))
      let jpegData = resultImage.jpegData(compressionQuality: 0.85)

      DispatchQueue.main.async {
        self.image = UIImage(data: jpegData!)
      }
    }
  }

  func startSession() {
    cameraQueue.async {
      if !self.isRunning {
        self.captureSession?.startRunning()
      }
    }
  }

  func stopSession() {
    if isRunning {
      self.captureSession?.stopRunning()
    }
  }

  var isRunning: Bool {
    return self.captureSession != nil && self.captureSession!.isRunning
  }
}
