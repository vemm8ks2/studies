#include <iostream>
#include <string>

using namespace std;

const int dx[8] = { -1, -1, -1, 1, 1, 1, 0, 0 };
const int dy[8] = { -1, 0, 1, -1, 0, 1, -1, 1 };

char board[5][5] = {
	{'U', 'R', 'L', 'P', 'M'},
	{'X', 'P', 'R', 'E', 'T'},
	{'G', 'I', 'A', 'E', 'T'},
	{'X', 'T', 'N', 'Z', 'Y'},
	{'X', 'O', 'Q', 'R', 'S'}
};

bool inRange(int x, int y) {
	return x >= 0 && x < 5 && y >= 0 && y < 5;
}

// 5x5 ���� ���� ���� �ش� ��ġ���� �־��� �ܾ �����ϴ����� ��ȯ
bool hasWord(int x, int y, const string& word) {

	// ���� ��� 1: ���� ��ġ�� ���� ���̸� ������ ����
	if (!inRange(x, y)) {
		return false;
	}

	// ���� ��� 2: ù ���ڰ� ��ġ���� ������ ����
	if (board[y][x] != word[0]) {
		return false;
	}

	// ���� ��� 3: �ܾ� ���̰� 1�̸� ����
	if (word.size() == 1) {
		return true;
	}

	// ������ ���� ĭ�� �˻�
	for (int direction = 0; direction < 8; ++direction) {
		int nextX = x + dx[direction];
		int nextY = y + dy[direction];

		if (hasWord(nextX, nextY, word.substr(1))) {
			return true;
		}
	}

	return false;
}

// ������ ��� �Լ�
void printBoard() {
	cout << "���� ���� ������:" << endl;
	for (int i = 0; i < 5; i++) {
		for (int j = 0; j < 5; j++) {
			cout << board[i][j] << " ";
		}
		cout << endl;
	}
}

int main() {
	// ������ ���� �Է� ����
	char choose;

	cout << "�������� ���� �����Ͻðڽ��ϱ�? (Y/N): ";
	cin >> choose;

	if (choose == 'Y' || choose == 'y') {
		for (int i = 0; i < 5; i++) {
			for (int j = 0; j < 5; j++) {
				cout << "(" << i << ", " << j << ") ��ǥ�� �� �Է�: ";
				cin >> board[i][j];
			}
		}
	}

	// ������ ���
	printBoard();

	// �ܾ� �Է� �ޱ�
	string word;

	cout << "ã���� �ϴ� �ܾ �Է����ּ���: ";
	cin >> word;

	// ���� ��ġ �Է� �ޱ�
	int startX, startY;

	cout << "������ X ��ǥ ��ġ�� �Է����ּ���: ";
	cin >> startX;

	cout << "������ Y ��ǥ ��ġ�� �Է����ּ���: ";
	cin >> startY;

	if (hasWord(startX, startY, word)) {
		cout << "�ܾ �����մϴ�!" << endl;
	} else {
		cout << "�ܾ ã�� ���߽��ϴ�." << endl;
	}

	return 0;
}