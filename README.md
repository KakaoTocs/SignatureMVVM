# SignatureMVVM
- MVVM(+Unidirectional) + Coordinator + PureDI

# 빙글빙글 돌아가는 머리 - 족보
<img width="686" alt="image" src="https://user-images.githubusercontent.com/22838614/198546115-1717472e-891e-443c-a87f-b40cffcb2027.png">

# ViewModel 구조
Input: UI의 Event와 1대 1로 연결되는 입력 공간
State: Input과 N대 1로 연결되고, Input의 요청을 처리한 결과 Data(=ViewModel이 가지는 현재 State에 대한 Data)
Output: State와 1대 N으로 연결되고, 실제 UI와는 1대1로 바인딩 되는 Data, State의 Data를 가공한 Data
<img width="1082" alt="image" src="https://user-images.githubusercontent.com/22838614/198550497-e2b60382-05df-4754-a343-598d3012046d.png">
