Pod::Spec.new do |s|
  s.name             = 'YMSwipeTableViewCell'
  s.version          = '1.1.1'
  s.summary          = 'YMSwipeTableViewCell is a lightweight library that enables table view cell swiping.'
  s.description      = 'YMSwipeTableViewCell is a lightweight library that enables table view cell swiping (seen in most mail applications). It is implemented as a UITableViewCell class category and can detect left or right horizontal swipes. Upon a left or right swipe, a swipe view is exposed. This library is meant to be flexible, so that any views can be exposed during a swipe and a myriad of actions can be taken during the swipe (e.g., swipe view animations, or cell snap back or destruction at the completion of a swipe).'
  s.homepage         = 'https://github.com/aluong-yammer/YMSwipeTableViewCell.git'
  s.screenshots      = 'https://github.com/aluong-yammer/YMSwipeTableViewCell/blob/master/github-assets/YMSwipeTableViewCellSampleScreenShot.png?raw=true'
  s.license          = 'MIT'
  s.author           = { 'Alda Luong' => 'alluong@microsoft.com', 'Sumit Kumar' => 'sumkuma@microsoft.com' }
  s.source           = { :git => 'https://github.com/aluong-yammer/YMSwipeTableViewCell.git', :tag => '1.1.1' }
  s.platform         = :ios, '7.0'
  s.requires_arc     = true
s.source_files     = 'YMSwipeTableViewCell/PodFiles/*.{h,m}'
end
