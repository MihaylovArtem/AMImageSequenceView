Pod::Spec.new do |s|

  s.name         = "AMImageSequenceView"
  s.version      = "1.0.1"
  s.summary      = "AMImageSequence is a view for viewing 360-spin images."
  s.description  = "AMImageSequence is a view for viewing 360-spin images. Supports 360-degree horizontal rotation and image zooming."
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.homepage     = "https://github.com/MihaylovArtem/AMImageSequenceView"
  s.author       = { "Mihaylov Artem" => "mihaylovartem74@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/MihaylovArtem/AMImageSequenceView.git", :tag => s.version.to_s }
  s.source_files = "AMImageSequenceView/*.{h,m}"
  s.requires_arc = true

end
