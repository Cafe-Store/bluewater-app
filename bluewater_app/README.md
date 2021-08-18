# bluewater_app

A new Flutter project.

## Getting Started

flutter 코드를 체크아웃 받은 후, 프로젝트의 루트에서 'flutter packages pub run build_runner build --delete-conflicting-outputs' 명령어를 입력하여 자동으로 생성해야할 파일들 생성하도록 한다.

### Dart

dart 언어 관련된 문서 <https://dart.dev/guides>

### Flutter

Flutter 관련 정보는 <https://flutter.dev/docs> 에서 확인할 수 있음.

>Flutter State Management

* 내 생각에 Flutter에서 상태 관리만 알면 반은 먹음.
* 요거 읽어보면 좋음 <https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro>
  * 공식문서 뭔 개소리지할 수도 있음..

* 상태 관리 라이브러리 목록 <https://flutter.dev/docs/development/data-and-backend/state-mgmt/options>

* 여기서는 get(GetX)를 사용하자!
  * 요게 1위임
  * bloc 사용해봤는데 bloc보다 사용하기 개편함.
  * 라우터 관리도 개꿀임
    * GetX 라우터 관련 예제 <https://github.com/jonataslaw/getx/tree/master/example_nav2>

> 사용하는 라이브러리

* **pubspec.yaml** 파일에 보면 의존하는 라이브러리들이 작성되어 있음.
* 구글링하면서 학습하면 도움이 됨.
  * dartz
  * equatable
  * get
  * retrofit
  * connectivity_plus

> 이름에 따른 역활

* Service: App의 생명주기와 동일한 생명주기를 갖음
* Controller: 뷰의 생명주기와 동일한 생명주기를 갖음
* View: 사용자가 보는 화면
* Widget: 뷰를 구성하는 요소
* Binding: View/Widget을 Controller/Service와 연결
* Usecase: 하나의 기능으로 생각을 해보자. 다른 의견이 있을 수 있는데 나도 애매해서 의견을 주면 좋을 것 같음. 위키의 내용 참고해서 생각함(<https://en.wikipedia.org/wiki/Use_case>)
* Repository: 데이터 저장소의 역활을 수행
* DataSource: 데이터를 얻어올 수 있는 기원? 가령 로컬 db, sharedPreference, network를 통한 데이터?

> Flutter Theme

* shared/ui/theme에 blueWater앱에서 사용할 Theme 관리
* 색상, 텍스트 스타일 등 여러가지를 다룰 수 있음.
* Theme.of(context).textTheme.headline6 혹은 Theme.of(context).accentColor 방식으로 사용 가능
