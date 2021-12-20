1. [twitter_swift_ui_tutorial](#twitter_swift_ui_tutorial)
2. [무엇을 배울 것인가?](#무엇을_배울_것인가?)
3. [무엇을 구현 할 것인가?](#무엇을_구현_할_것인가?)
4. [Screen shots](#Screen_shots)
5. [끄적끄적](#끄적끄적)
   - [State](#State)
   - [ObservedObject](#ObservedObject)
   - [EnvironmentObject](#EnvironmentObject)
6. [CodeCoverage](#CodeCoverage)

# twitter_swift_ui_tutorial

MVVM 아키텍쳐와 Swift UI를 이용해서 Twitter의 MVP 버전 앱을 제작하는 방법을 배운다.
API를 Firestore 및 데이터 모델과 통합하는 작업, 유저를 팔로우하고, tweet 생성, 좋아요, direct messaging, 프로필 수정, 회원가입 등
소셜 네트워크의 중요 컴포넌트들을 제작한다.

# 무엇을 배울 것인가?

- SwiftUI 이용해서 어플리케이션을 만드는 방법
- SwiftUI를 이용해서 복잡한 UI와 animation 구현
- Cloud Firestore 이용해서 back end 구현
- 데이터 업로드 및 다운로드
- MVVM framework 사용
- data model 과 API 를 이용한 상호작용
- Swift UI 기초 프로그래밍 지식 습득
- CocoaPod 대신 SwiftPackageManager 사용해보기

# 무엇을 구현 할 것인가?

- 다이렉트 메시지 기능
- 회원가입
- 유저 프로필 작성
- user Authenticate
- 유저 검색
- 트윗 포스팅
- 트윗 피드 리스트
- 유저 팔로우/팔로잉
- 뷰 파일을 제외한 코드 커버리지 90퍼센트 이상 달성

# Screen shots

![twitter_clone](https://user-images.githubusercontent.com/34573243/142721271-8a805407-48e1-4d06-9533-dd8752651d44.png)

# 끄적끄적

## State

- SwiftUI는 state로 선언한 모든 프로퍼티의 스토리지를 관리.
- state 값이 변경되면 view가 appearance를 invalidates하고 body를 다시 계산(recomputes)
- view의 body에서만 state프로퍼티에 접근 할 것. 따라서 view의 클라이언트에서 state에 접근하지 못하도록 state프로퍼티를 private으로 선언할 것. (state는 특정 view에 속하고, view 외부에서 "절대" 사용되지 않은 간단한 프로퍼티에 적합 -> 해당 상태가 절대로 escape되지 않도록 설계되었다는 것을 강조하기 위해 private으로 표시하는 것이 중요함.)
- @State를 앞에 추가하면 SwiftUI가 자동으로 변경사항을 observe하고 해당 state를 사용하는 view부분을 업데이트

## ObservedObject

@State같은 경우에는 특정 view에서만 사용하는 프로퍼티였다면 ObservedObject는

- 더 복잡한 프로퍼티(여러 프로퍼티나 메소드가 있거나, 여러 view에서 공유할 수 있는 커스텀 타입이 있는 경우) 대신 @ObservedObject를 사용.
- String이나 integer같은 간단한 로컬 프로퍼티대신 외부 참조 타입(external reference type)을 사용한다는 점을 제외하면 @State와 매우 유사.
- @ObservedObject와 함께 사용하는 타입은 ObservableObject프로토콜을 따라야함.
- observed object가 데이터가 변경되었음을 view에 알리는 방법은 여러가지가 있지만 가장 쉬운 방법은 @Published 프로퍼티 래퍼를 사용하는 것. = SwiftUI에 view reload를 트리거.

## EnvironmentObject

- 모든 view가 읽을 수 있는 shared data

# CodeCoverage
```
xcov -p twitter/twitter.xcodeproj -s twitter -o xcov_output
```
![스크린샷 2021-12-20 오후 9 02 37](https://user-images.githubusercontent.com/34573243/146764464-762424b6-b6df-483e-adff-05a5a047c693.png)

