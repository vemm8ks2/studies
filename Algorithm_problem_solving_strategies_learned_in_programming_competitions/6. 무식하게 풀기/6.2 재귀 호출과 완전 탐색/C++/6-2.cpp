/*
 * ��� ȣ��
 * �ڵ� 6.2 n���� ���� �� m���� ���� ��� ������ ã�� �˰���

  ```
  for (int i = 0; i < n; ++i)
    for (int j = i + 1; j < n; ++j)
      for (int k = j + 1; k < n; ++k)
        for (itn l = k + 1; l < n; ++l)
          cout << i << " " << j << " " << k << " " << l << end;
  ```

 * ���� ���� 4�� for���� �ݺ��� ���̿� ������� ������ �� �ֵ��� ����Լ��� �����ϱ�
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

// n: ��ü ������ ��
// picked: ���ݱ��� �� ���ҵ��� ��ȣ
// toPick: �� �� ������ ��
// �� ��, ������ toPick���� ���Ҹ� ���� ��� ����� ����Ѵ�.
void pick(int n, vector<int>& picked, int toPick) {
  // ���� ���: �� �� ���Ұ� ���� �� �� ���ҵ��� ����Ѵ�.
  if (toPick == 0) {
    printPicked(picked);
    return;
  }

  // �� �� �ִ� ���� ���� ��ȣ�� ����Ѵ�.
  int smallest = picked.empty() ? 0 : picked.back() + 1;

  // �� �ܰ迡�� ���� �ϳ��� ����.
  for (int next = smallest; next < n; ++next) {
    picked.push_back(next);
    pick(n, picked, toPick - 1);
    picked.pop_back();
  }
}

int main() {
  int n;
  int m;

  cout << "��ü ������ ���� �Է����ּ���: ";
  cin >> n;

  cout << "�� ������ ���� �Է����ּ���: ";
  cin >> m;

  vector<int> picked;
  pick(n, picked, m);

  return 0;
}