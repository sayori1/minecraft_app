// Autogenerated from Pigeon (v4.1.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class InterstitialError;
@class InterstitialImpression;

@interface InterstitialError : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithCode:(NSNumber *)code
    description:(NSString *)description;
@property(nonatomic, strong) NSNumber * code;
@property(nonatomic, copy) NSString * description;
@end

@interface InterstitialImpression : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithData:(NSString *)data;
@property(nonatomic, copy) NSString * data;
@end

///The codec used by YandexAdsInterstitial.
NSObject<FlutterMessageCodec> *YandexAdsInterstitialGetCodec(void);

@protocol YandexAdsInterstitial
- (void)makeId:(NSString *)id error:(FlutterError *_Nullable *_Nonnull)error;
- (void)loadId:(NSString *)id error:(FlutterError *_Nullable *_Nonnull)error;
- (void)showId:(NSString *)id error:(FlutterError *_Nullable *_Nonnull)error;
- (void)onAdLoadedId:(NSString *)id completion:(void(^)(FlutterError *_Nullable))completion;
- (void)onAdFailedToLoadId:(NSString *)id completion:(void(^)(InterstitialError *_Nullable, FlutterError *_Nullable))completion;
- (void)onAdShownId:(NSString *)id completion:(void(^)(FlutterError *_Nullable))completion;
- (void)onAdDismissedId:(NSString *)id completion:(void(^)(FlutterError *_Nullable))completion;
- (void)onAdClickedId:(NSString *)id completion:(void(^)(FlutterError *_Nullable))completion;
- (void)onLeftApplicationId:(NSString *)id completion:(void(^)(FlutterError *_Nullable))completion;
- (void)onReturnedToApplicationId:(NSString *)id completion:(void(^)(FlutterError *_Nullable))completion;
- (void)onImpressionId:(NSString *)id completion:(void(^)(InterstitialImpression *_Nullable, FlutterError *_Nullable))completion;
@end

extern void YandexAdsInterstitialSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<YandexAdsInterstitial> *_Nullable api);

NS_ASSUME_NONNULL_END