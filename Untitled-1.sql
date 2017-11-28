/*
create table arac(
aracno int IDENTITY(1,1) NOT NULL PRIMARY KEY,
a_model int, marka nchar(20),
plaka char(20),
fiyat int,
Constraint chck_model check (a_model >=1900 or a_model <=9999))

create table musteri(
    mno int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    madi nvarchar(20),msoyadi nvarchar(20),
    madres nvarchar(50),mtelefon varchar(11))

create table satis(
    satno int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    mno int,
    aracno int,
    sat_tar date,
    sfiyat money,
    CONSTRAINT fkey_mno foreign key(mno) REFERENCES musteri(mno) on UPDATE CASCADE on delete cascade,
    Constraint fkey_aracno foreign key(aracno) references arac(aracno) on update cascade on delete cascade)

Create table alim(
    alimno int identity(1,1) primary key,
    mno int,
    aracno int,
    alim_tarih date,
    afiyat money,
    constraint fk_mno foreign key(mno) references musteri(mno) on delete cascade on update CASCADE,
    constraint fk_aracno foreign key(aracno) references arac(aracno) on delete cascade on update CASCADE)
GO
insert into musteri VALUES('turgut','ozseven','Turhal/Tokat','035622222'),
    ('Mustafa','caglayan','meram/konya','032121232'),
    ('ahmet','kara','zile/Tokat','0663242312'),
    ('murat','beyaz','Turhal/Tokat','0354543222'),
    ('elif','kurt','besiktas/Istanbul','01232222'),
    ('ayse','ucar','Tasova/Amasya','035661231'),
    ('Bulent','ayar','Turhal/Tokat','0399934999')
insert into arac VALUES(2004,'Fiat Marea','60 tt 6060',16000),
    (2000,'Renault megane','60 tt 6061',14000),
    (2007,'Ford Focus','60 tt 6062',28000),
    (2005,'Volkswagen golf','60 tt 6063',26000),
    (1998,'Opel astra','60 tt 6064',9000)

insert into satis values(1,1,'2010/05/04',17000),
    (4,5,'2010/06/01',11500),
    (7,4,'2010/06/15',27000),
    (2,1,'2010/07/02',17500)

insert into alim values(3,1,'2010/02/08',15000),
    (6,1,'2010/04/12',15500),
    (2,5,'2010/04/15',9500),
    (1,2,'2010/05/12',14000),
    (5,3,'2010/08/22',26000)

select arac.marka,arac.a_model,satis.sfiyat,satis.sat_tar
from arac,satis 
where satis.aracno = arac.aracno AND
satis.sat_tar > '2010/04/01'

select musteri.mno,arac.marka,arac.a_model,satis.sfiyat,musteri.madi,musteri.msoyadi,musteri.madres
from arac,satis,musteri
where musteri.madres like 'Turhal/%' and
(musteri.mno = satis.mno AND
arac.aracno = satis.aracno)
*/
--Bolum 7
select fiyat+fiyat*0.20 from arac
select fiyat+fiyat*0.15,a_model,fiyat from arac where datepart(year,getdate())-a_model < 3
select concat(madi,' ',msoyadi) adsoyad from musteri order by adsoyad
select concat(sat_tar,' ',sfiyat) from satis where mno in(1,4,7) and aracno in(1,2,5) order by sat_tar desc
select substring(madi,1,1)+'.'+msoyadi from musteri
select * from alim ORDER by datepart(month,alim_tarih),afiyat DESC
SELECT left(madi,1)+left(msoyadi,5) as adsoyad FROM musteri where len(msoyadi) > 5 order by madi
select substring(madres,charindex('/',madres)+1,len(madres)) as il from musteri order by il
select * from satis where datepart(year,sat_tar) between 2008 and 2010 and datepart(month,sat_tar) in (3,4)
select sum(sfiyat) from satis where datepart(year,sat_tar) between 2008 and 2010 and datepart(month,sat_tar) in (3,4)
select sum(sfiyat) as toplamfiyat,avg(sfiyat) as ortalama,sum(sfiyat)-avg(sfiyat) fark from satis where datepart(year,sat_tar) between 2008 and 2010 and datepart(month,sat_tar) between 1 and 8
select max(fiyat) - min(fiyat) from arac
select count(*) from alim where datepart(year,alim_tarih) = 2010
select * from satis where sat_tar between '2010/01/01' and '2010/12/31'
select * from alim where datediff(month,alim_tarih,'2010/10/21') > 6
select *,datename(weekday,sat_tar) from satis
--Bolum 8
select avg(fiyat) from arac where 2010 - a_model > 3
select avg(sfiyat) from satis
select aracno, avg(afiyat) from alim group by aracno having avg(afiyat) > 10000
select aracno, max(sfiyat)-min(sfiyat) from satis GROUP by aracno