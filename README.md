# GIPHYSearchApp

GIPHY 검색 API를 활용한 iOS 어플리케이션.

## Description
- 최소 타겟 : iOS 13.0
- 외부 라이브러리 최소화(Alamofire만 적용)
- Clean Architecture 패턴 적용
- Core Data 프레임워크 사용으로 즐겨찾기 목록 유지
- Storyboard를 활용하지 않고 코드로만 UI 구성
- Pagination 구현
- [개발 공수](https://maze-mozzarella-6e5.notion.site/5e5d19f60849440084d56bad52b37aea)

### Update(5/13)
* Image Loading Logic 개선(Multi threading 조치) -> 스크롤 버벅임 현상 개선
```swift
func cellConfig(gifURL: String) {
    cellView.indicatorAction(bool: true)
    DispatchQueue.global().async { [weak self] in
        let image = UIImage.gifImageWithURL(gifURL)
        DispatchQueue.main.async {
            self?.cellView.imageView.image = image
            self?.cellView.indicatorAction(bool: false)
        }
    }
}
```


## Feature
* 검색 뷰
  + 카테고리별(GIFs, Stickers, Text) GIF 검색 기능
  + 페이지네이션
  + 액티비티 인디케이터
* 디테일 뷰
  + 즐겨찾기 추가/제거
  + 액티비티 인디케이터
* 즐겨찾기 뷰
  + 즐겨찾기 목록 관리
  + 즐겨찾기 데이터 제거
  
## Getting Started

### Skill

    Swift 
    Clean Architecture
    UIKit, AutoLayout, CoreData
    Alamofire

### Issue

#### 1. Gradient 이슈
* 시간을 가장 많이 소요했던 이슈이다. 실제 GIPHY앱의 Search화면 하단부를 보면 검은색 그라데이션이 점점 탭바쪽으로 갈수록 짙어진다. 해당 기능을 구현하기 위해 CAGradientLayer를 활용했으나 구현 과정에서 총 두가지의 이슈가 존재했다.
* (1) Gradient 미적용 이슈
  + 기존 코드의 경우, 그라데이션 관련 메서드를 구현하고 ViewDidLoad쪽에서 실행했다. 그러나 그라데이션이 전혀 적용되지 않았다.
  + 원인을 파악해보니, CAGradientLayer는 CALayer의 자식 클래스로, 뷰의 레이아웃에 관한 클래스이다. 뷰의 생명주기처럼 레이아웃에도 생명주기와 비슷한게 존재하는데, 즉 레이아웃의 생명주기 관련 메서드에서 그라데이션 기능을 구현해야했다.

```swift

// UIView에서 레이아웃과 관련된 메서드인 layoutSubView에서 그라데이션 메서드를 실행했다.
override func layoutSubviews() {
    super.layoutSubviews()

    gradientConfig()
}

func gradientConfig() {

    gradientView.setGradient(gradient: viewGradientLayer,
                             startColor: UIColor(red: 100/255, green: 100/255, blue: 50/255, alpha: 0),
                             finishColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1),
                             start: CGPoint(x: 1.0, y: 0.0),
                             end: CGPoint(x: 1.0, y: 1.0))
}

```

* (2) Gradient가 점점 진해지는 이슈
  + 그러나, 이번에는 그라데이션이 적용은 됐으나 뷰에서 User interaction이 있을때마다 그라데이션이 점점 짙어지는 현상이 발생했다.
  + [원인을 파악해보니](https://stackoverflow.com/questions/65524360/gradient-gets-darker-whenever-leaving-app-and-then-coming-back), layoutSubView메서드의 경우 여러번 호출이 될 수 있다고 한다. 따라서, GradientLayer가 계속해서 덧씌워지고 있었던 것이다.
  + 문제해결을 위해, layoutSubView메서드에서는 GradientLayer의 frame만 잡아주게 하고 Gradient의 configuration은 이니셜라이저쪽에서 실행했다.

```swift

private var viewGradientLayer = CAGradientLayer()

override init(frame: CGRect) {
    super.init(frame: frame)
    gradientConfig()
}

override func layoutSubviews() {
    super.layoutSubviews()

    viewGradientLayer.frame = gradientView.bounds
}

func gradientConfig() {

    gradientView.setGradient(gradient: viewGradientLayer,
                             startColor: UIColor(red: 100/255, green: 100/255, blue: 50/255, alpha: 0),
                             finishColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1),
                             start: CGPoint(x: 1.0, y: 0.0),
                             end: CGPoint(x: 1.0, y: 1.0))
}

```

#### 2. 스크롤 딜레이 이슈
* GIF기능 구현을 위해 공개된 샘플 소스코드를 가져와서 사용했다. 그러나 해당 코드에서는 이미지 캐싱을 따로 해주지 않아서 GIF로딩이 끝난 데이터도 나중에 다시 확인하면 로딩을 또 기다려야했다. 또한 스크롤 버벅임도 상당히 심했다.
* 문제해결을 위해 해당 소스코드에 이미지 캐싱 기능을 넣어줬다. 이미지 캐싱 덕분에 최초에 새로운 GIF데이터를 호출할 때만 스크롤이 딜레이되고 이후에는 딜레이 현상이 없어졌다.
* 추가적으로 cellConfig에서 멀티쓰레딩을 해줌으로써 스크롤 딜레이를 개선했다.

```swift
public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {

    // 캐시에 사용될 Key 값
    let cacheKey = NSString(string: gifUrl)

    // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
    if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
        return cachedImage
    }
    guard let bundleURL:URL = URL(string: gifUrl)
        else {
            print("image named \"\(gifUrl)\" doesn't exist")
            return nil
    }
    guard let imageData = try? Data(contentsOf: bundleURL) else {
        print("image named \"\(gifUrl)\" into NSData")
        return nil
    }
    // 다운로드된 이미지를 캐시에 저장
    ImageCacheManager.shared.setObject(gifImageWithData(imageData)!, forKey: cacheKey)
    return gifImageWithData(imageData)
}
```

#### 3. iOS 13.0 얼럿 이슈
* 시뮬레이터상으로 테스트 했을 때, iOS 14.0과 15.4버전에서는 이상이 없으나 13.0버전에서는 얼럿을 호출할때 런타임 오류가 발생하는 이슈가 존재했다.
* iOS 13.7 실기기로 테스트 결과, 문제가 없는 것으로 확인했고 해당 이슈는 시뮬레이터 이슈로 판단된다.

### Reflection

#### 1. Clean Architecture 적용
* 클린아키텍처를 적용한 두 번째 프로젝트이다. [첫 번째 프로젝트](https://github.com/Daltonicc/SeSACFriendsApp)에 비해서 프로젝트 규모가 훨씬 작음에도 불구하고 클린아키텍처를 적용한 이유는 다음과 같다. 
* 첫째, 소스코드 전반에 대한 파악을 좀더 용이하게 만들고자 했다. 폴더구조와 각 모듈들을 계층에 따라 명확하게 분리함으로써 사용자에게 코드상 이점을 줄 수 있을것이라고 판단했다.
* 둘째, 의존성 문제 해결을 위해서이다. 일반적인 구조의 경우, 의존성의 방향이 일정하기 때문에 상위 계층에 변화가 생긴다면 변화가 사소할지라도 하위 계층은 변화에 대응하기 위한 소요가 무척 커진다. 따라서, 의존성 역전을 통해 상위 계층의 변화에 유연하게 대처하고자 했다.

#### 2. 외부 라이브러리 의존성 최소화
* 이번 프로젝트는 Alamofire를 제외한 외부 라이브러리를 일체 사용하지 않았다. 개인적으로 기본에 충실할 수 있었던 프로젝트였는데, 외부 라이브러리에 의존했던 문제들(이미지 캐싱, Database, Code base UI 등)을 직접 해결하면서 어떤 구조와 형태로 해당 기능들이 라이브러리에서 구현이 됐는지 파악하는데에 큰 도움이 됐다.
* 또한 RxSwift와 RxCocoa를 사용하지 않다보니 비동기 프로그래밍에도 어려움이 있었다. 클로저를 활용하여 구현은 했으나, 뎁스가 깊어져 가독성이 나빠지는 등 어려움이 존재했다. 이러한 문제를 해결하기 위해 써드파티 플랫폼인 Rx가 아니더라도 Combine이라던지 async/await 등 퍼스트파티 플랫폼 안에서도 해결이 가능했지만 아직 거기까지는 학습이 되지 않아 실제로 적용해보지는 못했다.
* 애플의 폐쇄성을 고려하면, 지금 보편적으로 사용하고 있는 라이브러리인 RxSwift도 분명 Combine으로 대체될 것이라고 생각한다. 그런 점에서 이번 프로젝트는 외부 라이브러리에 대한 방향성과 iOS 프레임워크에 대한 중요성을 크게 느꼈던 프로젝트이다.

#### 3. 프로토콜
* 기존에 자주 사용하던 Input/Output패턴의 경우, Input과 Output을 명확하게 정의내림으로써 사용자는 각각의 뷰가 무슨 기능을 담고 있는지 한눈에 파악이 가능했다.
* Input/Output패턴을 사용하지 않은 이번 프로젝트는 어떻게 하면 사용자가 Input/Output패턴처럼 로직을 한눈에 파악할 수 있을지에 집중했다.
* Output은 정의내릴 수 없을지라도 최소한 Input에는 어떤 이벤트들이 들어가는지 ViewModel에 프로토콜로 정의했다.

```swift

protocol SearchViewModelProtocol {
    func requestGIFData(style: CategoryStatus, query: String, completion: @escaping (Bool, String?) -> Void)
    func requestNextGIFData(style: CategoryStatus, query: String, completion: @escaping (String?) -> Void)
}

final class SearchViewModel: SearchViewModelProtocol {

...

}

```
  
*****

## ScreenShot
<div markdown="1">  
    <div align = "center">
    <img src="https://user-images.githubusercontent.com/87598209/166632513-0c42a674-3ae7-466b-8062-c8e505f4b821.png" width="225px" height="500px"></img>
    <img src="https://user-images.githubusercontent.com/87598209/166632519-e1423576-f536-423e-823f-656411781657.png" width="225px" height="500px"></img>
    <img src="https://user-images.githubusercontent.com/87598209/166632524-8fa28176-192a-41b6-9cf3-485ec81ebca4.png" width="225px" height="500px"></img>
</div>
<div markdown="2">  
    <div align = "center">
    <img src="https://user-images.githubusercontent.com/87598209/166632562-effba0f9-a3d5-4dc9-914a-943f0bb3ee38.png" width="225px" height="500px"></img>
    <img src="https://user-images.githubusercontent.com/87598209/166632573-fbe39dc5-9f03-44cb-b6f9-ec3200bd81b9.png" width="225px" height="500px"></img>
    <img src="https://user-images.githubusercontent.com/87598209/166632583-d0553b14-ed80-4275-993a-9ae8a8b484b2.png" width="225px" height="500px"></img>
</div>

## Video

<table align="center">
<tr>
<th colspan="1"> 검색 화면 </th>
<th colspan="2"> 페이지네이션 </th>
</tr>
<tr>
<td>
<p align="center">
<video src="https://user-images.githubusercontent.com/87598209/166635430-08180da8-32c6-4aa6-b3c9-c7c398be8a83.mp4">
</p>
</td>
<td>
<p align="center">
<video src="https://user-images.githubusercontent.com/87598209/166636110-0f4e70c1-3d99-4e30-9c53-8a864c8c3149.mp4">
</p>
</td> 
</tr>
</table>

<table align="center">
<tr>
<th colspan="1"> 좋아요 동기화 </th>
<th colspan="2"> 즐겨찾기 목록관리 </th>
</tr>
<tr>
<td>
<p align="center">
<video src="https://user-images.githubusercontent.com/87598209/166636210-aa89ec3a-fba7-44d0-9ed7-798422d19e3b.mp4">
</p>
</td>
<td>
<p align="center">
<video src="https://user-images.githubusercontent.com/87598209/166636981-de3b8e2c-e8ee-4c28-b468-59dd7419e77b.mp4">
</p>
</td> 
</tr>
</table>
