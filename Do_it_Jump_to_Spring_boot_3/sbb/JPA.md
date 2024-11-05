### JPA 메서드

|SQL의 연산자|리포지터리의 메서드 예|설명|
|:---:|:---:|:---:|
|And|findBySubjectAndContent(String subject, String content)|Subject, Content 열과 일치하는 데이터를 조회|
|Or|findBySubjectOrContent(String subject, String content)|Subject 열 또는 Content 열과 일치하는 데이터를 조회|
|Between|findByCreateDateBetween(LocalDateTime fromDate, LocalDateTime toDate)|CreateDate 열의 데이터 중 정해진 범위 내에있는 데이터를 조회|
|LessThan|findByIdLessThan(Integer id)|Id 열에서 조건보다 작은 데이터를 조회|
|GreaterThanEqual|findByIdGreaterThanEqual(Integer id)|Id 열에서 조건보다 크거나 같은 데이터를 조회|
|Like|findBySubjectLike(String subject)|Subject 열에서 문자열 'subject'와 같은 문자열을 포함한 데이터를 조회|
|In|findBySubjectIn(String[] subjects)|Subject 열의 데이터가 주어진 배열에 포함되는 데이터만 조회|
|OrderBy|findBySubjectOrderByCreateDateAsc(String subject)|Subject 열 중 조건에 일치하는 데이터를 조회하여 그 데이터를 반환할 때 CreateDate 열을 오름차순으로 정렬하여 반환|
|...|...|...|

[더 많은 메소드 목록 보기](https://docs.spring.io/spring-data/jpa/reference/jpa/query-methods.html)

### JPA Like 메소드의 조건문 표기
|표기 예|표기 위치에 따른 의미|
|---|---|
|sbb%|'sbb'로 시작하는 문자열|
|%sbb|'sbb'로 끝나는 문자열|
|%sbb%|'sbb'를 포함하는 문자열|
