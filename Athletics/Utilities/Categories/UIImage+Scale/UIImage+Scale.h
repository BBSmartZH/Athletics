//
//  UIImage+Scale.h
//  Athletics
//
//  Created by mrzj_sc on 16/4/29.
//  Copyright © 2016年 李宛. All rights reserved.
//

#import <UIKit/UIKit.h>


/*!
 * @brief UIImage扩展方法
 * @author huangyibiao
 */
@interface UIImage (Scale)


/*!
 * @brief 根据指定的Rect来截取图片，返回截取后的图片
 * @param rect 指定的Rect，如果大小超过图片大小，就会返回原图片
 * @return 返回截取后的图片
 */
- (UIImage *)subImageWithRect:(CGRect)rect;

/*!
 * @brief 把图片等比例缩放到指定的size
 * @param size 缩放后的图片的大小
 * @return 返回缩放后的图片
 */
- (UIImage *)scaleToSize:(CGSize)size;


#pragma mark - 高质量处理图片的方法
/*!
 * @brief 根据指定的模式来压缩图片
 * @param contentMode 压缩模式
 * @param bounds      压缩到bounds
 * @param quality     压缩质量
 */
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

/*!
 * @brief 自动调整图片到目标大小
 * @param destImageSize 目标图片大小，单位是MB
 * @param quality     压缩质量
 */
- (UIImage *)resizedImageWithUncompressedSizeInMB:(CGFloat)destImageSize
                             interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;
- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;

#pragma mark - 图片与base64之间的转换
//- (NSString *)toBase64;

@end
