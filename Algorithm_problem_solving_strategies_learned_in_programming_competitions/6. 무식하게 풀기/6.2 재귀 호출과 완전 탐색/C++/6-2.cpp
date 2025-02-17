/*
 * 재귀 호출
 * 코드 6.2 n개의 원소 중 m개를 고르는 모든 조합을 찾는 알고리즘

  ```
  for (int i = 0; i < n; ++i)
    for (int j = i + 1; j < n; ++j)
      for (int k = j + 1; k < n; ++k)
        for (itn l = k + 1; l < n; ++l)
          cout << i << " " << j << " " << k << " " << l << end;
  ```

 * 위와 같은 4중 for문을 반복문 깊이에 관계없이 대응할 수 있도록 재귀함수로 구현하기
 */

#include <iostream>
#include <vector>

using namespace std;

void printPicked(const vector<int>& picked) {
  for (int i = 0; i < picked.size(); ++i) {
    cout << picked[i] << " ";
  }
  cout << endl;
}

// n: 전체 원소의 수
// picked: 지금까지 고른 원소들의 번호
// toPick: 더 고를 원소의 수
// 일 때, 앞으로 toPick개의 원소를 고르는 모든 방법을 출력한다.
void pick(int n, vector<int>& picked, int toPick) {
  // 기저 사례: 더 고를 원소가 없을 때 고른 원소들을 출력한다.
  if (toPick == 0) {
    printPicked(picked);
    return;
  }

  // 고를 수 있는 가장 작은 번호를 계산한다.
  int smallest = picked.empty() ? 0 : picked.back() + 1;

  // 이 단계에서 원소 하나를 고른다.
  for (int next = smallest; next < n; ++next) {
    picked.push_back(next);
    pick(n, picked, toPick - 1);
    picked.pop_back();
  }
}

int main() {
  int n;
  int m;

  cout << "전체 원소의 수를 입력해주세요: ";
  cin >> n;

  cout << "고를 원소의 수를 입력해주세요: ";
  cin >> m;

  vector<int> picked;
  pick(n, picked, m);

  return 0;
}