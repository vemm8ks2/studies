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

// 5x5 보글 게임 판의 해당 위치에서 주어진 단어가 시작하는지를 반환
bool hasWord(int x, int y, const string& word) {

	// 기저 사례 1: 시작 위치가 범위 밖이면 무조건 실패
	if (!inRange(x, y)) {
		return false;
	}

	// 기저 사례 2: 첫 글자가 일치하지 않으면 실패
	if (board[y][x] != word[0]) {
		return false;
	}

	// 기저 사례 3: 단어 길이가 1이면 성공
	if (word.size() == 1) {
		return true;
	}

	// 인접한 여덟 칸을 검사
	for (int direction = 0; direction < 8; ++direction) {
		int nextX = x + dx[direction];
		int nextY = y + dy[direction];

		if (hasWord(nextX, nextY, word.substr(1))) {
			return true;
		}
	}

	return false;
}

// 게임판 출력 함수
void printBoard() {
	cout << "보글 게임 보드판:" << endl;
	for (int i = 0; i < 5; i++) {
		for (int j = 0; j < 5; j++) {
			cout << board[i][j] << " ";
		}
		cout << endl;
	}
}

int main() {
	// 게임판 직접 입력 여부
	char choose;

	cout << "게임판을 직접 생성하시겠습니까? (Y/N): ";
	cin >> choose;

	if (choose == 'Y' || choose == 'y') {
		for (int i = 0; i < 5; i++) {
			for (int j = 0; j < 5; j++) {
				cout << "(" << i << ", " << j << ") 좌표의 값 입력: ";
				cin >> board[i][j];
			}
		}
	}

	// 게임판 출력
	printBoard();

	// 단어 입력 받기
	string word;

	cout << "찾고자 하는 단어를 입력해주세요: ";
	cin >> word;

	// 시작 위치 입력 받기
	int startX, startY;

	cout << "시작할 X 좌표 위치를 입력해주세요: ";
	cin >> startX;

	cout << "시작할 Y 좌표 위치를 입력해주세요: ";
	cin >> startY;

	if (hasWord(startX, startY, word)) {
		cout << "단어가 존재합니다!" << endl;
	} else {
		cout << "단어를 찾지 못했습니다." << endl;
	}

	return 0;
}