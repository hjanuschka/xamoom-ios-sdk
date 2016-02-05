//
// Copyright 2015 by xamoom GmbH <apps@xamoom.com>
//
// This file is part of some open source application.
//
// Some open source application is free software: you can redistribute
// it and/or modify it under the terms of the GNU General Public
// License as published by the Free Software Foundation, either
// version 2 of the License, or (at your option) any later version.
//
// Some open source application is distributed in the hope that it will
// be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
// of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with xamoom-pingeborg-ios. If not, see <http://www.gnu.org/licenses/>.
//

#import "XMMContentBlock1TableViewCell.h"

@interface XMMContentBlock1TableViewCell ()

@property (nonatomic, getter=isPlaying) BOOL playing;

@end

@implementation XMMContentBlock1TableViewCell

- (void)awakeFromNib {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(pauseAllXMMMusicPlayer)
                                               name:@"pauseAllSounds"
                                             object:nil];
  
  [self.audioControlButton setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)configureForCell:(XMMContentBlock *)block {
  //set audioPlayerControl delegate and initialize
  self.audioPlayerControl.delegate = self;
  [self.audioPlayerControl initAudioPlayerWithUrlString:block.fileID];
  
  //set title & artist
  if (block.title != nil && ![block.title isEqualToString:@""]) {
    self.titleLabel.text = block.title;
  }
  
  if (block.artists != nil && ![block.artists isEqualToString:@""]) {
    self.artistLabel.text = block.artists;
  }
  
  //set songDuration
  float songDurationInSeconds = CMTimeGetSeconds(self.audioPlayerControl.audioPlayer.currentItem.asset.duration);
  self.remainingTimeLabel.text = [NSString stringWithFormat:@"%d:%02d", (int)songDurationInSeconds / 60, (int)songDurationInSeconds % 60];
  
}

- (IBAction)playButtonTouched:(id)sender {
  //play or pause the audioplayer and change the buttonImage
  if (!self.isPlaying) {
    [self.audioPlayerControl play];
    self.playing = YES;
    [self.audioControlButton setImage:[UIImage imageNamed:@"pausebutton"] forState:UIControlStateNormal];
  } else {
    [self.audioPlayerControl pause];
    self.playing = NO;
    [self.audioControlButton setImage:[UIImage imageNamed:@"playbutton"] forState:UIControlStateNormal];
  }
}

#pragma mark - XMMMMusicPlayer delegate

-(void)didUpdateRemainingSongTime:(NSString *)remainingSongTime {
  self.remainingTimeLabel.text = remainingSongTime;
}

#pragma mark - Notification Handler

- (void)pauseAllXMMMusicPlayer {
  [self.audioPlayerControl pause];
}

@end
