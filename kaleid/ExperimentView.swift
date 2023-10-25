import AVFoundation
import SwiftUI
import UIKit
import VideoToolbox

public class CameraModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
  @Published public var error: String?
  @Published public var image: UIImage?
  @Published public var updateCount: Int = 0

  private var captureSession: AVCaptureSession?
  private var cameraQueue = DispatchQueue(label: "Kaleidoscope camera queue")

  override init() {
    super.init()

    getPermission()
    self.captureSession = setupSession()

    startSession()
  }

  func reportError(_ newText: String?) {
    DispatchQueue.main.async {
      self.error = newText ?? "No error detected"
    }
    print("Camera error: \(String(describing: newText))")
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
    print("got permission")
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

    print("session is set up")
    return session
  }

  public func captureOutput(
    _ output: AVCaptureOutput,
    didOutput sampleBuffer: CMSampleBuffer,
    from connection: AVCaptureConnection
  ) {
    if let cvImage = sampleBuffer.imageBuffer {
      let resultImage = UIImage(ciImage: CIImage(cvPixelBuffer: cvImage))

      let pngData = resultImage.jpegData(compressionQuality: 0.85)

      DispatchQueue.main.async {
        self.image = UIImage(data: pngData!)
        //self.image = UIImage(ciImage: CIImage(cvPixelBuffer: cvImage))
        self.updateCount += 1
        print("Captured image \(String(describing: self.image))")
      }

    }
//    guard let cvImage = sampleBuffer.imageBuffer else {
//      return
//    }
//
//    let resultImage = UIImage(ciImage: CIImage(cvPixelBuffer: cvImage)).copy()
//
//    DispatchQueue.main.async {
//      self.image = resultImage as? UIImage
//      //self.image = UIImage(ciImage: CIImage(cvPixelBuffer: cvImage))
//      self.updateCount += 1
//      print("Captured image \(String(describing: self.image))")
//    }
  }

  func startSession() {
    cameraQueue.async {
      self.captureSession?.startRunning()
    }
  }

  func stopSession() {
    self.captureSession?.stopRunning()
  }
}

struct ExperimentView: View {
  @StateObject private var camera = CameraModel()

  var body: some View {
    VStack {
      if camera.error != nil {
        Text(verbatim: camera.error!)
      }

      Text(verbatim: "\(camera.updateCount)")
     // PreviewHolder(image: $image)

      if camera.image != nil {
        Text("image changed \(camera.image!)")
        Image(uiImage: camera.image!)
          .border(Color.green)
      }
    }
    .onChange(of: camera.image) {
      print("image changed \(camera.image)")
    }
   // .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
  }
}

#Preview {
    ExperimentView()
}
