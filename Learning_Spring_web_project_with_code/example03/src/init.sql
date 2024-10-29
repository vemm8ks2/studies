// 테이블 생성
CREATE SEQUENCE seq_board; // 시퀀스 생성 시 DB의 다른 오브젝트들과 구분하기 우히ㅐ 'seq_'와 같이 시작하는 것이 일반적이다.

CREATE TABLE tbl_board( // 테이블 생성 시 'tbl_로 시작하거나 't_'와 같이 구분이 가능한 단어를 앞에 붙여주는 것이 좋다.'
    bno NUMBER(10, 0),
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writer VARCHAR2(50) NOT NULL,
    regdate DATE DEFAULT sysdate,
    updatedate DATE DEFAULT sysdate
);

ALTER TABLE tbl_board ADD CONSTRAINT pk_board PRIMARY KEY(bno);

// 더미 데이터 생성
INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');
INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user01');
INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user02');
INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user03');
INSERT INTO tbl_board (bno, title, content, writer) VALUES (seq_board.nextval, '테스트 제목', '테스트 내용', 'user04');

COMMIT;

// 테이블 생성 및 더미 데이터 생성 후 조회
SELECT * FROM tbl_board;

// 8.1.2
SELECT * FROM tbl_board WHERE bno > 0;

// 12.1.1
-- 재귀 복사를 통해서 데이터의 개수를 늘린다. 반복해서 여러 번 실행
INSERT INTO tbl_board (bno, title, content, writer)
(SELECT seq_board.nextval, title, content, writer FROM tbl_board);

// 17.2
CREATE TABLE tbl_reply (
    rno NUMBER(10, 0),
    bno NUMBER(10, 0) NOT NULL,
    reply VARCHAR2(1000) NOT NULL,
    replyer VARCHAR2(50) NOT NULL,
    replyDate DATE DEFAULT SYSDATE,
    updateDate DATE DEFAULT SYSDATE
);

CREATE SEQUENCE seq_reply;

ALTER TABLE tbl_reply ADD CONSTRAINT pk_reply PRIMARY KEY (rno);

ALTER TABLE tbl_reply ADD CONSTRAINT fk_reply_board FOREIGN KEY (bno) REFERENCES tbl_board (bno);

// 17.6.1 데이터베이스의 인덱스 설계
CREATE INDEX idx_reply ON tbl_reply (bno DESC, rno ASC);