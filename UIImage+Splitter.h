//
//  UIImage+Splitter.h
//  VideoWall
//
//  Created by frowing on 5/9/12.
//

#import <UIKit/UIKit.h>

@protocol UIImageVideoWallDelegate 

- (void)imageSplitIntoImages:(NSArray*)images;

@end

@interface UIImage (Splitter)

- (void)splitIntoRows:(NSUInteger)rows
              columns:(NSUInteger)columns 
  withCompletionBlock:(void (^)(NSArray* images))completionBlock;

@end
