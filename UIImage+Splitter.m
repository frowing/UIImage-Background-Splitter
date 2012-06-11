//
//  UIImage+Videowall.m
//  VideoWall
//
//  Created by frowing on 5/9/12.
//

#import "UIImage+Splitter.h"

@implementation UIImage (Splitter)
 

- (void)splitIntoRows:(NSUInteger)rows
              columns:(NSUInteger)columns 
  withCompletionBlock:(void (^)(NSArray* images))completionBlock {
  
  if ((rows == 0) || (columns == 0)) {
      completionBlock(nil);
  }
  
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0ul); 
  
  dispatch_async(queue, ^{
    CGImageRef anImage = [self CGImage];
    CGSize imageSize = CGSizeMake(CGImageGetWidth(anImage), CGImageGetHeight(anImage));
    NSMutableArray *splitImages = [NSMutableArray array];  
    
    for(int row = 0; row < rows; row ++) {
      for(int column = 0; column < columns; column ++) {
        CGRect frame = CGRectMake((imageSize.width / columns) * column,
                                  (imageSize.height / rows) * row,
                                  (imageSize.width / columns),
                                  (imageSize.height / rows));
        CGImageRef subimage = CGImageCreateWithImageInRect(anImage, frame);
        UIImage *image = [UIImage imageWithCGImage:subimage];
        CFRelease(subimage);
        NSData *imageData = UIImagePNGRepresentation(image);
        [splitImages addObject:imageData];
      }
    }
    
    dispatch_sync(dispatch_get_main_queue(), ^{ 
      completionBlock(splitImages);
    });
  });
}

@end
