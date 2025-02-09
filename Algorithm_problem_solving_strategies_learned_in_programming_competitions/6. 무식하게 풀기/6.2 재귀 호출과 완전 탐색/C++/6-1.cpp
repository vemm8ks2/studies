/*
 * 재귀 호출
 * 코드 6.1 1부터 n까지의 합을 계산하는 반복 함수와 재귀 함수
 *
 * 필수 조건: n >= 1
 * 결과: 1부터 n까지의 합을 반환한다
 */

#include <iostream>
using namespace std;

int sum(int n) {
  int res = 0;

  for (int i = 1; i <= n; i++) {
    res += i;
  }

  return res;
}

int recursiveSum(int n) {
  if (n == 1) return 1; // 더 이상 쪼개지지 않을 때
  return n + recursiveSum(n - 1);
}

int main() {
  int n;

  cout << "숫자를 입력해주세요: ";
  cin >> n;

  cout << "1부터 입력한 숫자까지 반복문을 사용하여 더한 값: ";
  cout << sum(n) << endl;

  cout << "1부터 입력한 숫자까지 재귀를 사용하여 더한 값: ";
  cout << recursiveSum(n) << endl;

  return 0;
}