create table member1
(주민번호 char(14) unique, 이름 varchar(30))

exec sp_helpconstraint member1 -- 제약명칭 알려죠!!

create table #t
(이름 char(20), 직업 char(30) default'학생')

-- !default로 지정한 테이블에 레코드 입력하는 방법!

--1. 전체 열값을 차례로 입력하면서 default부분 채우기
insert into #t values('홍길동', default)

--2. default를 제외하고 나머지 열을 입력
insert into #t(이름) values('홍길동')

select * from #t

create table 화장품
(코드 int primary key, 제품명 char(20))
insert 화장품 values (1,'로션'),(2,'립스틱'),(3,'마스카라')

create table 주문
(주문번호 int, 아이디 char(20), 
상품코드 int foreign key references 화장품(코드)) -- 화장품테이블의 코드를 참조한다.
insert 주문 values (1,'abc123',1),(2,'xy123',2)
insert 주문 values (1,'abc123',5) -- 오류!

select * from 화장품 -- primery key 필요
select * from 주문 -- foreign key references 필요

drop table 화장품
drop table 주문

-- 워크북 11장 무결성 제약조건
-- 1. 테이블 학과를 생성하시오. 
-- 학과코드 : char(3) 기본키 제약 설정, 학과 char(20)
create table 학과1 (학과코드 char(3) primary key, 학과 char(20))
insert 학과1 values ('D1','컴퓨터'),('D2','유아교육'),('D3','식품영양'),('D4','비서')
insert 학과1 values ('D1','조리') -- 오류! (프라이머리 위배)

-- 2. 테이블 재학생을 생성하시오.
-- 학번 int, 이름 char(20), 학과코드 char(3) 학과1 테이블의 학과코드 참조
create table 재학생 (학번 int, 이름 char(20), 
학과코드 char(3) foreign key references 학과1(학과코드) 
on update cascade on delete cascade) -- 
insert 재학생 values (1,'홍길동','D1'),(2,'김선달','D2'),(3,'성춘향','D3'),(4,'김철수','D4')
insert 재학생 values (5,'홍길동','D7') -- 오류! (포린키 위배!)

select * from 학과1
select * from 재학생 

--3. 테이블 재학생에 다음 레코드를 입력하시오. 만약, 오류가 발생한다면 이유는? 
-- insert 재학생 values (5,'김배화','D5')
-- 답 : primary key 위배

--4. 학과1 테이블에 다음 레코드를 입력하시오.
-- insert 학과1 values ('D5','조리')

--5. 3번 문제를 다시 풀어보고 결과를 설명하시오.
-- 답 : 학과1 테이블의 학과코드에 D5가 생겨서 참조가 가능하기 때문이다.

--6. 학과1 테이블과 재학생 테이블을 삭제하시오. 이때 삭제 순서에 맞게 구문을 작성하시오.
drop table 재학생 -- 첫번째
drop table 학과1 -- 두번째

--7. 학과 테이블과 재학생 테이블을 순서에 맞게 생성을 하면서 
--학과테이블의 학과코드가 수정되면 
--재학생테이블의 학과코드가 연동되어 수정되도록 구문을 작성하시오. 
--또한 학과테이블의 학과코드가 삭제되면 따라서 
--재학생테이블의 정보도 삭제되도록 구문을 작성하시오.  

-- 초기에 테이블을 생성할때 on update cascade / on delete cascade 옵션이 없다면 오류!
update 학과1 set 학과코드='D0' where 학과코드='D1' 
delete from 학과1 where 학과코드='D2'
delete from 학과1 where 학과코드='D3'
delete from 학과1 where 학과코드='D4'

-- 만일 나중에 제약키를 설정하고 싶다면?
alter table 학과1
add constraint p_학과코드 primary key(학과코드)

-- 만일 나중에 제약키를 삭제하고 싶다면?
alter table 학과1
drop constraint p_학과코드