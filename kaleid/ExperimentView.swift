import SwiftUI
import UIKit
import AVFoundation

class PreviewView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
  private var captureSession: AVCaptureSession?
  private var cameraQueue = DispatchQueue(label: "Kaleidoscope camera queue")
  var latestImage: UIImage?

  init() {
    super.init(frame: .zero)

    var allowedAccess = false
    let blocker = DispatchGroup()
    blocker.enter()
    AVCaptureDevice.requestAccess(for: .video) { flag in
      allowedAccess = flag
      blocker.leave()
    }
    blocker.wait()

    if !allowedAccess {
      print("!!! NO ACCESS TO CAMERA")
      return
    }

    // setup session
    let session = AVCaptureSession()
    session.beginConfiguration()

    //    let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified) //alternate
    let videoDevice = AVCaptureDevice.default(for: .video)
    guard videoDevice != nil, let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else {
      print("!!! NO CAMERA DETECTED")
      return
    }
    session.addInput(videoDeviceInput)

    let photoOutput = AVCaptureVideoDataOutput()
    guard session.canAddOutput(photoOutput) else {
      print("can't add output to camera session")
      return
    }
    photoOutput.setSampleBufferDelegate(self, queue: cameraQueue)

    //   session.sessionPreset = .photo
    session.addOutput(photoOutput)

    session.commitConfiguration()
    self.captureSession = session
  }

  override class var layerClass: AnyClass {
    AVCaptureVideoPreviewLayer.self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  var videoPreviewLayer: AVCaptureVideoPreviewLayer {
    return layer as! AVCaptureVideoPreviewLayer
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    if nil != self.superview {
      self.videoPreviewLayer.session = self.captureSession
      self.videoPreviewLayer.videoGravity = .resizeAspect
      cameraQueue.async {
        self.captureSession?.startRunning()
      }
    } else {
      self.captureSession?.stopRunning()
    }
  }

  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard let cvImage = sampleBuffer.imageBuffer else { return }

    latestImage = UIImage(ciImage: CIImage(cvPixelBuffer: cvImage))

    print("Captured image \(String(describing: latestImage))")
  }
}

struct PreviewHolder: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<PreviewHolder>) -> PreviewView {
    PreviewView()
  }

  func updateUIView(_ uiView: PreviewView, context: UIViewRepresentableContext<PreviewHolder>) {
  }

  typealias UIViewType = PreviewView
}

struct DemoVideoStreaming: View {
  var body: some View {
    VStack {
      PreviewHolder()
    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
  }
}

struct ExperimentView: View {
  @State private var someImage: Image?

  var body: some View {
    DemoVideoStreaming()
  }
}

#Preview {
    ExperimentView()
}
