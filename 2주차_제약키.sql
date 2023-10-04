create table member1
(�ֹι�ȣ char(14) unique, �̸� varchar(30))

exec sp_helpconstraint member1 -- �����Ī �˷���!!

create table #t
(�̸� char(20), ���� char(30) default'�л�')

-- !default�� ������ ���̺� ���ڵ� �Է��ϴ� ���!

--1. ��ü ������ ���ʷ� �Է��ϸ鼭 default�κ� ä���
insert into #t values('ȫ�浿', default)

--2. default�� �����ϰ� ������ ���� �Է�
insert into #t(�̸�) values('ȫ�浿')

select * from #t

create table ȭ��ǰ
(�ڵ� int primary key, ��ǰ�� char(20))
insert ȭ��ǰ values (1,'�μ�'),(2,'����ƽ'),(3,'����ī��')

create table �ֹ�
(�ֹ���ȣ int, ���̵� char(20), 
��ǰ�ڵ� int foreign key references ȭ��ǰ(�ڵ�)) -- ȭ��ǰ���̺��� �ڵ带 �����Ѵ�.
insert �ֹ� values (1,'abc123',1),(2,'xy123',2)
insert �ֹ� values (1,'abc123',5) -- ����!

select * from ȭ��ǰ -- primery key �ʿ�
select * from �ֹ� -- foreign key references �ʿ�

drop table ȭ��ǰ
drop table �ֹ�

-- ��ũ�� 11�� ���Ἲ ��������
-- 1. ���̺� �а��� �����Ͻÿ�. 
-- �а��ڵ� : char(3) �⺻Ű ���� ����, �а� char(20)
create table �а�1 (�а��ڵ� char(3) primary key, �а� char(20))
insert �а�1 values ('D1','��ǻ��'),('D2','���Ʊ���'),('D3','��ǰ����'),('D4','��')
insert �а�1 values ('D1','����') -- ����! (�����̸Ӹ� ����)

-- 2. ���̺� ���л��� �����Ͻÿ�.
-- �й� int, �̸� char(20), �а��ڵ� char(3) �а�1 ���̺��� �а��ڵ� ����
create table ���л� (�й� int, �̸� char(20), 
�а��ڵ� char(3) foreign key references �а�1(�а��ڵ�) 
on update cascade on delete cascade) -- 
insert ���л� values (1,'ȫ�浿','D1'),(2,'�輱��','D2'),(3,'������','D3'),(4,'��ö��','D4')
insert ���л� values (5,'ȫ�浿','D7') -- ����! (����Ű ����!)

select * from �а�1
select * from ���л� 

--3. ���̺� ���л��� ���� ���ڵ带 �Է��Ͻÿ�. ����, ������ �߻��Ѵٸ� ������? 
-- insert ���л� values (5,'���ȭ','D5')
-- �� : primary key ����

--4. �а�1 ���̺� ���� ���ڵ带 �Է��Ͻÿ�.
-- insert �а�1 values ('D5','����')

--5. 3�� ������ �ٽ� Ǯ��� ����� �����Ͻÿ�.
-- �� : �а�1 ���̺��� �а��ڵ忡 D5�� ���ܼ� ������ �����ϱ� �����̴�.

--6. �а�1 ���̺�� ���л� ���̺��� �����Ͻÿ�. �̶� ���� ������ �°� ������ �ۼ��Ͻÿ�.
drop table ���л� -- ù��°
drop table �а�1 -- �ι�°

--7. �а� ���̺�� ���л� ���̺��� ������ �°� ������ �ϸ鼭 
--�а����̺��� �а��ڵ尡 �����Ǹ� 
--���л����̺��� �а��ڵ尡 �����Ǿ� �����ǵ��� ������ �ۼ��Ͻÿ�. 
--���� �а����̺��� �а��ڵ尡 �����Ǹ� ���� 
--���л����̺��� ������ �����ǵ��� ������ �ۼ��Ͻÿ�.  

-- �ʱ⿡ ���̺��� �����Ҷ� on update cascade / on delete cascade �ɼ��� ���ٸ� ����!
update �а�1 set �а��ڵ�='D0' where �а��ڵ�='D1' 
delete from �а�1 where �а��ڵ�='D2'
delete from �а�1 where �а��ڵ�='D3'
delete from �а�1 where �а��ڵ�='D4'

-- ���� ���߿� ����Ű�� �����ϰ� �ʹٸ�?
alter table �а�1
add constraint p_�а��ڵ� primary key(�а��ڵ�)

-- ���� ���߿� ����Ű�� �����ϰ� �ʹٸ�?
alter table �а�1
drop constraint p_�а��ڵ�