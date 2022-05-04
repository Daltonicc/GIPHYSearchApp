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

#### 2. 스크롤 딜레이 이슈

#### 3. 좋아요 로직
*

#### 4. iOS 13.0 얼럿 이슈
* 

### Reflection

#### 1. Clean Architecture 적용
* 클린아키텍처를 적용한 두번째 프로젝트이다. 첫번째 프로젝트에 비해서 프로젝트 규모가 훨씬 작음에도 불구하고 클린아키텍처를 적용한 이유는 다음과 같다. 
* 첫째, 소스코드 전반에 대한 파악을 좀더 용이하게 만들고자 했다. 폴더구조와 각 모듈들을 계층에 따라 명확하게 분리함으로써 사용자에게 코드상 이점을 줄 수 있을것이라고 판단했다.
* 둘째, 의존성 문제 해결을 위해서이다. 일반적인 구조의 경우, 의존성의 방향이 일정하기 때문에 상위 계층에 변화가 생긴다면 변화가 사소할지라도 하위 계층은 변화에 대응하기 위한 소요가 무척 커진다. 따라서, 의존성 역전을 통해 상위 계층의 변화에 유연하게 대처하고자 했다.

#### 2. 외부 라이브러리 의존성 최소화
* 이번 프로젝트는 Alamofire를 제외한 외부 라이브러리를 일체 사용하지 않았다. 개인적으로 기본에 충실할 수 있었던 프로젝트였는데, 외부 라이브러리에 의존했던 문제들(이미지 캐싱, Database, Code base UI 등)을 직접 해결하면서 어떤 구조와 형태로 해당 기능들이 라이브러리에서 구현이 됐는지 파악하는데에 큰 도움이 됐다.
* 또한 RxSwift와 RxCocoa를 사용하지 않다보니 비동기 프로그래밍에도 어려움이 있었다. 클로저를 활용하여 구현은 했으나, 뎁스가 깊어져 가독성이 나빠지는 등 어려움이 존재했다. 이러한 문제를 해결하기 위해 써드파티 플랫폼인 Rx가 아니더라도 Combine이라던지 async/await 등 퍼스트파티 플랫폼 안에서도 해결이 가능했지만 아직 거기까지는 학습이 되지 않아 실제로 적용해보지는 못했다.
* 애플의 폐쇄성을 고려하면, 지금 보편적으로 사용하고 있는 라이브러리인 RxSwift도 분명 Combine으로 대체될 것이라고 생각한다. 그런 점에서 이번 프로젝트는 외부 라이브러리에 대한 고찰과 iOS 프레임워크에 대한 중요성을 크게 느꼈던 프로젝트이다.


#### 3. 프로토콜
* 기존에 자주 사용하던 Input/Output패턴의 경우, Input과 Output을 명확하게 정의내림으로써 사용자는 각각의 뷰가 무슨 기능을 담고 있는지 한눈에 파악이 가능했다.
* Input/Output패턴을 사용하지 않은 이번 프로젝트는 어떻게 하면 사용자가 Input/Output패턴처럼 로직을 한눈에 파악할 수 있을지에 집중했다.
* 최소한 Output은 정의내릴 수 없을지라도 Input에는 어떤 이벤트들이 들어가는지 ViewModel에 프로토콜로 정의했다.

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
