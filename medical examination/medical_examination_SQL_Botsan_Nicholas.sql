/*Исправить БД и сделать поля код направления, рецепта и выписки не ключами, а обычными полями, так как они могут повторяться!!!!!!!!*/

create database Despanser
go

use Despanser
go




create type Adres from varchar(70)
go

create type FIO from varchar(50)
go

create type Telefon from char(12)
go

create table Med_inst(cod_MI smallint primary key,
					  name_MI varchar(20),
					  legal_adres Adres,
					  Tel_numb Telefon,
					  Stamp varchar(20))
go

create table Family_doctor(Cod_fam_doctor int primary key,
						   fio_doct FIO,
						   Tel_munb Telefon,
						   area varchar(70),
						   Stamp varchar(20))
go

create table Tratement(cod_trate int primary key,
					   trat_name varchar(25),
					   trat_method varchar(50),
					   duration smallint)
go

create table Medicaments(cod_med int primary key,
					     med_name varchar(20),
						 purpose varchar(30),
						 dosage smallint,
						 instruction varchar(100))
go

create table Tratement_Medicaments(cod_trate int foreign key references Tratement(cod_trate) not null,
								   cod_med int foreign key references Medicaments(cod_med) not null)
go

create table Speciallist(cod_spec int primary key,
						 fio_spec FIO,
						 post varchar(20),
						 Stamp varchar(20),
						 cod_MI smallint foreign key references Med_inst(cod_MI) not null)
go

create table Patient(cod_pac int primary key,
					 fio_pac FIO,
					 age smallint check (age>0 and age <150),
					 gender char check(gender = 'M' or gender = 'F'),
					 Birth_date date,
					 pac_adres Adres,
					 Cod_fam_doctor int foreign key references Family_doctor(Cod_fam_doctor) not null,
					 pac_tel Telefon,
					 Number_insurance_police int,
					 Work varchar(20),
					 IDNP varchar(13))
go

create table Diagnoza(cod_diagnoz int primary key,
					  name_diagnoz varchar(30),
					  cod_trate int foreign key references Tratement(cod_trate) not null)
go

create table Referral(cod_ref int primary key,
					  cod_pac int foreign key references Patient(cod_pac) not null,
					  cod_diagnoz int foreign key references Diagnoza(cod_diagnoz) not null,
					  Cod_fam_doctor int foreign key references Family_doctor(Cod_fam_doctor) not null,
					  cod_spec int foreign key references Speciallist(cod_spec) not null,
					  vizit_date datetime,
					  cod_MI smallint foreign key references Med_inst(cod_MI) not null)
go

create table Note(note_numb int primary key,
				  cod_spec int foreign key references Speciallist(cod_spec) not null,
				  cod_pac int foreign key references Patient(cod_pac) not null,
				  cod_diagnoz int foreign key references Diagnoza(cod_diagnoz) not null,
				  cod_MI smallint foreign key references Med_inst(cod_MI) not null)
go

create table Recept(recept_numb int primary key,
					cod_pac int foreign key references Patient(cod_pac) not null,
					cod_med int foreign key references Medicaments(cod_med) not null,
					Dosage smallint,
					trat_duration smallint default 30,
					prescription_date date,
					cod_MI smallint foreign key references Med_inst(cod_MI) not null,
					cod_spec int foreign key references Speciallist(cod_spec) not null)
go










insert into Med_inst(cod_MI, name_MI, legal_adres, Tel_numb, Stamp)
values (1001, 'Med Family', 'str.Sadovianu 7/5', '+37369982418', 'MedFamily'),
	   (1002, 'Galaxia', 'str.Puskin 21/1', '+37367756224', 'Galaxia gr.')
Go

select * from Med_inst
Go






insert into Family_doctor(Cod_fam_doctor, fio_doct, Tel_munb, area, Stamp)
values (2067, 'Burlakova Anna Sergei', '+37367766545', 'Dacia', 'Burlakova A.S.'),
	   (2068, 'Fulger Elena Matvei', '+37368453213', 'Nicolae Milescu Spataru', 'Fulger A.M.'),
	   (2069, 'Antonescu Anton Anton', '+37369999675', 'Sodoveanu', 'Antonescu A.A.'),
	   (2070, 'Maskov Andrei Mihail', '+37367893421', 'Petru Zadnipru', 'Maskov A.M.'),
	   (2071, 'Nastasiu Olgo Ivan', '+37368568258', 'Alecu Russo', 'Nastasiu O.I.')
Go

insert into Family_doctor(Cod_fam_doctor, fio_doct, Tel_munb, area, Stamp)
values (2075, 'Burlakova Anna Sergei', '+37367766545', 'Dacia', 'Burlakova A.S.')
go

delete from Family_doctor where Cod_fam_doctor = 2075
go

select * from Family_doctor
Go





insert into Tratement(cod_trate, trat_name, trat_method, duration)
values (1000, 'Phiziotherapy', 'Light phizical load', 20),
	   (1001, 'Electroforez', 'Light electric discharges', 20),
	   (1002, 'Aqua procedures', 'swimming in the pool', 30),
	   (1003, 'Magnetic rezonans', 'Magnetic belt', 20),
	   (1004, 'Massage', 'massage', 15)
Go

select * from Tratement
Go

update Tratement
set trat_method = 'Swimming in the pool'
where trat_method = 'swimming in the pool'
Go

update Tratement
set trat_method = 'Massage'
where trat_method = 'massage'
go


delete from Tratement where trat_method = 'massage'
Go

select * from Tratement
Go




insert into Medicaments(cod_med, med_name, purpose, dosage, instruction)
values (2000, 'Menovazan', 'Knees', 100, 'Apply to knees'),
	   (2001, 'Geucamen', 'Back', 70, 'Apply to back'),
	   (2002, 'Aertal', 'Joints', 80, 'Apply to joints or back'),
	   (2003, 'Lorista', 'Headache', 120, '1 pill per 24 hours'),
	   (2005, 'Aspirin', 'Thins the blood', 75, 'for Headache')
Go

select * from Medicaments
Go

update Medicaments
set instruction = 'For headache'
where instruction = 'for Headache'
Go

update Medicaments
set purpose = 'Joints and back'
where purpose = 'Joints'
go

update Medicaments
set purpose = 'Joints'
where purpose = 'Joints and back'
go



insert into Tratement_Medicaments(cod_trate, cod_med)
values (1000, 2000),
	   (1003, 2002),
	   (1002, 2003)
Go



insert into Tratement_Medicaments values ('Palm', 2000)
go


select * from Tratement_Medicaments
Go





insert into Speciallist(cod_spec, fio_spec, post, Stamp, cod_MI)
values (10001, 'Crudov Dmitrii Anton', 'Nevrolog', 'Crudov D.M.', 1001),
	   (12002, 'Malahov Andrei Nicolai', 'Terapeft', 'Malahov A.N.', 1002),
	   (11003, 'Malisheva Elena Vasilii', 'Cardiolog', 'Malisheva E.V.', 1002),
	   (11004, 'Cojocaru Aliona Eugen', 'Genicolog', 'Cojocaru A.E.', 1001)
go

select * from Speciallist
Go






insert into Patient(cod_pac, fio_pac, age, gender, Birth_date, pac_adres, Cod_fam_doctor, pac_tel, Number_insurance_police, Work, IDNP)
values (10001, 'Botnaru Iurii Ivan', 24, 'M', '1998-03-13', 'str.Sadovianu 7/5, 13', 2069,'+37369982417', 100872, 'Combinat Poligrafic', '1998475612432'),
	   (10002, 'Botsan Nicolai Vladimir', 17, 'M', '2004-08-22', 'str.Nicolae Milescu Spataru 32, 323', 2068,'+37367722224', 164535, 'CEITI student', '2004500167543'),
	   (10003, 'Globu Sergei Vitalii', 37, 'M', '1985-11-11', 'str.Puskin 19, 123', 2069,'+37368888967', 562369, 'Librarius', '1985550354233'),
	   (10004, 'Gutu Vladimir Vladimir', 41, 'M', '1981-12-31', 'str.Petru Zadnipru 36, 66', 2071,'+37369123456', 164535, 'Paza Bercut', '1981300300300'),
	   (10005, 'Leanu Vasilisa Andrei', 28, 'F', '1994-07-05', 'str.Nicolae Milescu Spataru 2, 100', 2067,'+37360564354', 974530, 'Mobias Banca', '1994500111112')
go

select * from Patient
Go


update Patient
set Cod_fam_doctor = 2068
where fio_pac = 'Leanu Vasilisa Andrei'
go

update Patient
set Cod_fam_doctor = 2070
where fio_pac = 'Gutu Vladimir Vladimir'
go




insert into Diagnoza(cod_diagnoz, name_diagnoz, cod_trate)
values (5007, 'Fracture', 1000),
	   (5010, 'Back pain', 1003),
	   (5015, 'Headache', 1002),
	   (5100, 'Breast pain', 1000)
go

select * from Diagnoza
Go






insert into Note(note_numb, cod_spec, cod_pac, cod_diagnoz, cod_MI)
values (19751, 12002, 10005, 5100, 1001),
	   (16859, 10001, 10003, 5015, 1002),
	   (16860, 10001, 10001, 5015, 1002)
go

select * from Note
Go

--delete Note where cod_diagnoz = 5015 or cod_diagnoz = 5100
--go






insert into Referral(cod_ref, cod_pac, cod_diagnoz, Cod_fam_doctor, cod_spec, vizit_date, cod_MI)
values (16543, 10002, 5015, 2068, 10001, '2022-02-17 15:30:00', 1001),
	   (18599, 10003, 5015, 2069, 10001, '2022-02-09 16:30:00', 1001),
	   (18600, 10003, 5010, 2069, 12002, '2022-02-10 14:00:00', 1002),
	   (28564, 10005, 5010, 2068, 12002, '2022-02-18 17:00:00', 1001)
go

select * from Referral
Go





insert into Recept(recept_numb, cod_pac, cod_med, Dosage, trat_duration, prescription_date, cod_MI, cod_spec)
values (98346, 10003, 2000, 100, 30, '2022-02-09', 1001, 10001),
	   (98347, 10003, 2001, 100, 30, '2022-02-09', 1001, 12002),
	   (86253, 10005, 2005, 50, 15, '2022-02-18', 1001, 10001)
go

select * from Recept
Go








create index med_inst_indx on Med_inst(name_MI)
go

create index med_inst_stamp_indx on Med_inst(Stamp)
go


create index family_doct_intx on Family_doctor(fio_doct)
go

create index family_doct_stamp_indx on Family_doctor(Stamp)
go


create index tratement_indx on Tratement(trat_name)
go

create index tratement_method_indx on Tratement(trat_method)
go














--Классная работа--


/*Вывести информацию о всех пациентах, состоящих на цчёте*/

select *
from Patient
Go



/*Вывести Фамилии и адресавсех пациентов, состоящих на цчёте*/

/*Без псевдонимов  столбцов*/

select fio_pac, pac_adres 
from Patient
Go

/*C псевдонимами  столбцов*/
select fio_pac as Pacients, pac_adres as Adres
from Patient
Go



/*Вывести информациию о всех Семейных врачах*/

select *
from Family_doctor
Go


/*Вывести Семейного врача, на участке улицы Дачия*/

select fio_doct as Doctor
from Family_doctor
where area = 'Dacia'
Go





/*Вывести информацию (ФИО и специальность) о всех специалистах*/

select fio_spec as Speciallist, post as Speciality
from Speciallist
Go

/*Вывести Фамилию о всех кардиологах*/

select fio_spec as Speciallist
from Speciallist 
where post = 'Cardiolog'
Go






/*Вывести названия медикаментов и из дозы (где доза дана в миллиграммах)*/
/*С добавлением дополнительного поля (mg)*/

select med_name as Medicament, dosage*0.0001 as Doza, 'mg' as unit
from Medicaments
Go



/*Вывести названия медикаментов и из дозы (где доза дана в миллиграммах)*/
/*С добавлением дополнительного поля (gr)*/

select med_name as Medicament, dosage as Doza, 'gr' as unit
from Medicaments
Go




/*Вывести информацию о пациентах, возраст которых превышает 40 лет*/

select fio_pac as Pacient, Birth_date as Birthday_date, pac_adres as Adress
from Patient
where year(getdate()) - year(Birth_date) > 40
Go

/*Вывести информацию о пациентах, возраст которых меньше 18 лет*/

select fio_pac as Pacient, Birth_date as Birthday_date, pac_adres as Adress
from Patient
where year(getdate()) - year(Birth_date) < 18
Go


/*Вывести информацию о пациентах, возраст которых меньше 40, но больше 18 лет*/

select fio_pac as Pacient, Birth_date as Birthday_date, pac_adres as Adress
from Patient
where   ( year(getdate()) - year(Birth_date) > 18 ) and ( year(getdate()) - year(Birth_date) < 40 )
Go


/*Вывести информацию о пациентах (ФИО и адрес), которые родились в ноябре*/

select fio_pac as Pacient, Birth_date as Birthday_date, pac_adres as Adress
from Patient
where month(Birth_date) = 11
Go


/*Вывести информацию о пациентах (ФИО и адрес), которые родились 13-го числа*/

select fio_pac as Pacient, Birth_date as Birthday_date, pac_adres as Adress
from Patient
where day(Birth_date) = 13
Go


/*Вывести информацию о пациентах (ФИО и адрес), которые родились зимой*/

select fio_pac as Pacient, Birth_date as Birthday_date, pac_adres as Adress
from Patient
where ( month(Birth_date) >= 12 ) or ( month(Birth_date) <= 2 )
Go


/*Вывести информацию о пациентах (ФИО и адрес), которые родились летом*/

select fio_pac as Pacient, Birth_date as Birthday_date, pac_adres as Adress
from Patient
where ( month(Birth_date) >= 6 ) and ( month(Birth_date) <= 8 )
Go


select *
from Patient
Go



/*Вывести продолжительность лечения "Массаж"*/

select duration
from Tratement
where trat_name = 'Massage'
Go


select *
from Tratement
Go

--Домашняя работа--

--Вывести список преперетов, предназначенных для спины--

select med_name as medicament_name, purpose, dosage, 'mg' as unit, instruction
from Medicaments
where purpose like '%_ack%'
go


--Вывести названия болезней, в которых содержится слово "боль (pain)"--
select name_diagnoz as Diagnoz_name
from Diagnoza
where name_diagnoz like '% pain%'
go


--Вывести название c "лёгкими"(light) методами лечения--

select trat_name as Tratement_name, trat_method as Tratement_method, duration, 'days' as unit
from Tratement
where trat_method like '%_ight %'   --% - это либо 0, либо 1, либо 2 и т.д. любых символов;		_ - это 1 любой символ--
go									--'%_ight', a не '%Light', так как может быть не только "Light", но и "light" --


--Вывести информацию (ФИО) о всех неврологах--
select  fio_spec as Speciallist_FIO
from Speciallist
where post = 'Nevrolog'
go

--Вывести информацию о всех специаллисте с фамилией Malahov--

select cod_spec as Speciallist_code, fio_spec as Speciallist_FIO, post as Speciallist_function, Stamp
from Speciallist
where fio_spec like 'Malahov %'
go


--* Вывести информацию о всех специаллисте с именем Елена--

select cod_spec as Speciallist_code, fio_spec as Speciallist_FIO, post as Speciallist_function, Stamp
from Speciallist
where fio_spec like '% Elena %'
go


--Вывести информацию о семейном враче на участке Nicolae Milescu Spataru--

select fio_doct as Family_doctor_FIO, Tel_munb as Telephone, Stamp
from Family_doctor
where area = 'Nicolae Milescu Spataru'
go

--Вывести информацию о всех пациентах, чей возраст <= 18--
select fio_pac as Pacient_FIO, age, gender, Birth_date as Birthday_date, pac_adres as Adress, pac_tel as Telephone, Number_insurance_police as Polise_name, Work as work, IDNP
from Patient
where age <= 18 
go

--Вывести информацию о всех пациентах, чей возраст > 18 и <= 30--

select fio_pac as Pacient_FIO, age, gender, Birth_date as Birthday_date, pac_adres as Adress, pac_tel as Telephone, Number_insurance_police as Polise_name, Work as work, IDNP
from Patient
where  (age > 18) and (age <= 30) 
go

--Вывести информацию о всех пациентах, чей возраст > 30--

select fio_pac as Pacient_FIO, age, gender, Birth_date as Birthday_date, pac_adres as Adress, pac_tel as Telephone, Number_insurance_police as Polise_name, Work as work, IDNP
from Patient
where age > 30 
go

--Вывести информацию о пациенте, чья фамилия Botsan--

select fio_pac as Pacient_FIO, age, gender, Birth_date as Birthday_date, pac_adres as Adress, pac_tel as Telephone, Number_insurance_police as Polise_name, Work as work, IDNP
from Patient
where fio_pac like 'Botsan %' 
go

--Вывести информацию о пациенте, чьё имя Николай--

select fio_pac as Pacient_FIO, age, gender, Birth_date as Birthday_date, pac_adres as Adress, pac_tel as Telephone, Number_insurance_police as Polise_name, Work as work, IDNP
from Patient
where fio_pac like '% Nicolai %' 
go






--***Дополнительно (с естественным соединением)***--




--Вывести информацию о семейном враче пациента Botnaru Iurii Ivan

select Patient.fio_pac as Pacient_FIO, Family_doctor.fio_doct as Family_doctor_FIO, Family_doctor.Tel_munb as Telephone, Family_doctor.area, Family_doctor.Stamp
from Patient
inner join Family_doctor on Patient.Cod_fam_doctor = Family_doctor.Cod_fam_doctor --Естественное соединение '%_ack %'  c Family_doctor. Результат - новая таблица со столбцами Patient и Family_doctor--
where (Patient.fio_pac = 'Botnaru Iurii Ivan') --Выборка из нового отношения (после естественного соединеия) со значениями из Patient и из Family_doctor => уже не нужно условие  and (Patient.Cod_fam_doctor = Family_doctor.Cod_fam_doctor)--
go


--Вывести лечение для болезни Back pain--

select Diagnoza.name_diagnoz as Diagnoz, Tratement.trat_name as Tratement_name, Tratement.trat_method as Tratement_method, Tratement.duration --as duration--s
from Diagnoza
inner join Tratement on (Diagnoza.cod_trate = Tratement.cod_trate) --Естественное соединение Diagnoza c Tratement. Результат - новая таблица со столбцами Diagnoza и Tratement--
where Diagnoza.name_diagnoz = 'Back pain' --Выборка из нового отношения (после естественного соединеия) со значениями из Patient и из Family_doctor => уже не нужно условие  and (Patient.Cod_fam_doctor = Family_doctor.Cod_fam_doctor)--
go

--Вывести лечение для всех болезней со спиной (Back)--
select Diagnoza.name_diagnoz as Diagnoz, Tratement.trat_name as Tratement_name, Tratement.trat_method as Tratement_method, Tratement.duration --as duration--s
from Diagnoza
inner join Tratement on (Diagnoza.cod_trate = Tratement.cod_trate) --Естественное соединение Diagnoza c Tratement. Результат - новая таблица со столбцами Diagnoza и Tratement--
where Diagnoza.name_diagnoz like '%_ack %' --'%_ack %' так как может быть и Back и back--
go






--Классная работа--





--Вывести количество участков у каждого семейного врача--

select fio_doct as Medic, count(area) as Area_number --count - функция для подсчитывания числа картежей--
from Family_doctor
group by fio_doct
go

select *
from Family_doctor
go



--Вывести колличество наименований с каждой дозировкой--

select dosage as Dozirovka, count(med_name) as Medicaments_number
from Medicaments
group by dosage
go

select *
from Medicaments
go



--Вывести число пациентов в поликлинике--

select count(*) as number_of_pacients  --* - означает, что подсчитываем все записи--
from Patient 
go


select *
from Patient 
go



--Вывести количество наименований медикоментов--

select count(*) as number_of_medicaments  --* - означает, что подсчитываем все записи--
from Medicaments 
go





--Вывесьти количество пациентов мужского и женского полла--

select gender, count(*) as number_of_genders
from Patient 
group by gender
go

select *
from Patient 
go










--домашняя работа--


--вывести количество специаллистов по каждой специальности--
select post as Speciallity, count(*) as number_of_speciallists
from Speciallist
group by post
go


--Вывести число пациентов у каждого семейного врача--
select Cod_fam_doctor as Famyli_doctor, count(*) as number_of_patients
from Patient
group by Cod_fam_doctor
go



--вывести число пациентов каждого года, начиная с 1990, состоящих на учёте у врача--
select year(Birth_date) as PYear, count(*) as number_of_patients
from Patient
group by year(Birth_date)
having year(Birth_date) >= 1990
go


--Вывести число заключений, выписанных каждым специаллистом--
select cod_spec as Speciallist, count(*) as number_of_notes
from Note
group by cod_spec
go


--вывести число пациентов для каждого диагноза, поставленных специаллистом--
select cod_diagnoz as Diagnoza, count(*) as number_of_patients
from Note
group by cod_diagnoz
go


--вывести число препаратов для каждого предназначения--
select purpose, count(*) as number_of_medicaments 
from Medicaments
group by purpose
go




















--Домашняя работа 15.03.22--
--создайте  все виды сложных (+ может быть и пересечение, и разность, и объединение (- тоже сложные, так как работают не с одним отношением)) запросов и  подзапросов, которые выводят самую необходимую информацию по проекту.--



--Подзапросы (когда для естественного соединения (или пересечения, разности, или объединения) слишком много информации)--



--Вывести методы лечения, при помощи которых лечится Боль в спине--
select  trat_name as Traement
from Tratement
where cod_trate in (select cod_trate
				 from Diagnoza
				 where name_diagnoz = 'Back pain')




--вывести каких специалистов прошёл пациент Globu Sergei Vitalii--
select fio_spec as Speciallist, post
from Speciallist
where cod_spec in (select cod_spec
				   from Referral
				   where cod_pac = (select cod_pac
									from Patient
									where fio_pac = 'Globu Sergei Vitalii'
									)
				  )
go

--вывести какие препараты были выписаны пациенту Globu Sergei Vitalii--
select med_name
from Medicaments inner join Recept on Medicaments.cod_med = Recept.cod_med
where cod_pac = (select cod_pac
				 from Patient
				 where fio_pac = 'Globu Sergei Vitalii'
				 )
go


--Вывести какими препаратами лечится диагноз: боль в спине--
select med_name as Medicament_name
from Medicaments
where cod_med in (select cod_med /*in, а не =, так как может повторяться в отношении Tratement_Medicaments*/
				  from Tratement_Medicaments
				  where cod_trate = (select cod_trate /* =, а не in, так как не может повторяться в отношении Tratement*/
									 from Tratement
									 where cod_trate in (select cod_trate
														 from Diagnoza
														 where name_diagnoz = 'Back pain'
														 )
									)
				) 
go


--или без отношения tratement (напрямую Diagnoza -> Tratement_Medicaments -> Medicaments)
select med_name as Medicament_name
from Medicaments
where cod_med in (select cod_med /*in, а не =, так как может повторяться в отношении Tratement_Medicaments*/
				  from Tratement_Medicaments
				  where cod_trate in (select cod_trate /*in, а не =, так как повторяется в отношении Diagnoza*/
														 from Diagnoza
														 where name_diagnoz = 'Back pain'
									)
				) 
go





--Вывести информацию о пациентах жалующихся на боль в спине--
select fio_pac as Pacient_FIO, age, gender, pac_adres as Pacient_adres, pac_tel as Telephone, fio_doct as Doctor_FIO
from Patient inner join Family_doctor on Patient.Cod_fam_doctor = Family_doctor.Cod_fam_doctor
where cod_pac in(select cod_pac
				 from Referral
				 where cod_diagnoz = (select cod_diagnoz
									  from Diagnoza
									  where name_diagnoz = 'Back pain'
									  )
				)
go
									  



--вывести информацию о всех пациентах для семейного врача Maskov Andrei Mihail--
select fio_pac as Pacient_FIO, age, gender, pac_adres as Pacient_adres, pac_tel as Telephone
from Patient
where Cod_fam_doctor = (select Cod_fam_doctor
						from Family_doctor
						where fio_doct = 'Antonescu Anton Anton'
						)
go





--вывести все заболевания (диагнозы) пациента Globu Sergei Vitalii--
select name_diagnoz as Diagnoz_name
from Diagnoza
where cod_diagnoz in (select cod_diagnoz
					  from Referral
					  where cod_pac = (select cod_pac
									   from Patient
									   where fio_pac = 'Globu Sergei Vitalii'
									  )
					  )
go


/*Если не указать условие у врача, то подзапрос выдаст не одно значение, а целое множество (то есть всех врачей) => надо было бы писать не =, а in, а результат был бы не для одного врача, а для всех...*/



--? Подсчитать общее количество рецептов, выписанных для пациента Globu Sergei Vitalii--
select count(*) as number_of_recepts
from  Recept
where cod_pac = (select cod_pac
				 from Patient
				 where fio_pac = 'Globu Sergei Vitalii'
				 )
go

select *
from Referral
go



--? Подсчитать общее количество напревлений, выписанных для пациента Globu Sergei Vitalii--
select count(*) as number_of_referrals
from  Referral
where cod_pac = (select cod_pac
				 from Patient
				 where fio_pac = 'Globu Sergei Vitalii'
				 )
go







--Естественное соединение (сложные запросы)--



--вывести информацию о всех пациентах и их семейных врачей-- 
select fio_doct as doctor, fio_pac as patient, age, gender, Birth_date as Birthday, pac_adres as adres, pac_tel as telephone, Work, IDNP 
from Family_doctor inner join Patient on Family_doctor.Cod_fam_doctor = Patient.Cod_fam_doctor
go


--вывести заболевание и способ его лечения--
select name_diagnoz as Diagnoz_name, trat_name as Tratement_method
from Diagnoza inner join Tratement on Diagnoza.cod_trate = Tratement.cod_trate
go





--*вывести заболевание, способ его лечения и препараты, которыми оно лечится--
/*Для этого я использовал представления:
1)соединим Diagnoza и Trtatement 
2)соединим Medicaments и Tratement_Medicanents
3)соединяем в одно общее представление (по коду лечения)

В таком порядке быстрее и удобнее
*/

--1.--
create view Diagnoza_Tratement_view as
select cod_diagnoz, name_diagnoz, Tratement.cod_trate, trat_name
from Diagnoza inner join Tratement on Diagnoza.cod_trate = Tratement.cod_trate
go

select *
from Diagnoza_Tratement_view
go

--2.--
create view Medicament_Tratement_view as
select med_name, cod_trate
from Medicaments inner join Tratement_Medicaments on Medicaments.cod_med = Tratement_Medicaments.cod_med
go

select *
from Medicament_Tratement_view
go

--3.--
create view Diagnoza_Tratement_Medicament_view as
select cod_diagnoz, name_diagnoz, trat_name, med_name
from Diagnoza_Tratement_view inner join Medicament_Tratement_view on Diagnoza_Tratement_view.cod_trate = Medicament_Tratement_view.cod_trate
go

select *
from Diagnoza_Tratement_Medicament_view
go




--Вывести информацию о тех пациентах, которые жалуются на головную боль, но не жалуются на боль в спине--
/*(этот запрос и со сложным запросом, и с подзапросами, и с оперцацией разности (хотя она тоже относится к сложным запросам))*/
(select fio_pac as Pacient_FIO, age, gender, pac_adres as Pacient_adres, pac_tel as Telephone, Work, fio_doct
from Patient inner join Family_doctor on Patient.Cod_fam_doctor = Family_doctor.Cod_fam_doctor
where cod_pac in (select cod_pac
				  from Referral
				  where cod_diagnoz = (select cod_diagnoz
								       from Diagnoza
									   where name_diagnoz = 'Headache')
				  )
)
except
(select fio_pac as Pacient_FIO, age, gender, pac_adres as Pacient_adres, pac_tel as Telephone, Work, fio_doct
from Patient inner join Family_doctor on Patient.Cod_fam_doctor = Family_doctor.Cod_fam_doctor
where cod_pac in (select cod_pac
				  from Referral
				  where cod_diagnoz = (select cod_diagnoz
								       from Diagnoza
									   where name_diagnoz = 'Back pain')
				  )
)
go

--Вывести информацию о специаллистах и медицинское учреждение на которые они работают--
select fio_spec as Speciallist, post, name_MI
from Speciallist inner join Med_inst on Speciallist.cod_MI = Med_inst.cod_MI
go

--***вывести число специаллистов, работающих на мед. учреждение, для каждого мед. учреждения--
select name_MI, count(*) as number_of_speciallists
from Med_inst inner join Speciallist on Med_inst.cod_MI = Speciallist.cod_MI
group by Med_inst.name_MI
go


--вывести парами специаллистов в одинаковыми должностями--
select S1.fio_spec as Speciallist_1, S2.fio_spec as Speciallist_2, S1.post
from Speciallist as S1, Speciallist as S2
where S1.post = S2.post and S1.fio_spec < S2.fio_spec /* "and ... <" - так как я буду смотреть всех тех специаллистов, что ниже, (а они > рассматриваемого => знак <)*/
go


/*
Чтобы работало

select *
from Speciallist
go

insert into Speciallist(cod_spec, fio_spec, post, Stamp, cod_MI)
values (11005, 'A A A', 'Genicolog', 'A A.A.', 1001)
go

delete from Speciallist where cod_spec = 11005
go

*/



--Классная работа за 21.03.22--


--Создадим представление Пациент-Семейный врач--
create view Patient_Fam_doctor_view as
select cod_pac, fio_pac, age, gender, Birth_date, pac_adres, pac_tel, Number_insurance_police, Work, IDNP, fio_doct, Tel_munb, area, Stamp
from Patient inner join Family_doctor on Patient.Cod_fam_doctor = Family_doctor.Cod_fam_doctor
go

select *
from Patient_Fam_doctor_view
go

create view Patient_Fam_doctor_Referral_view as
select fio_pac, age, gender, Birth_date, pac_adres, pac_tel, Number_insurance_police, Work, IDNP, fio_doct, Tel_munb, area, Stamp, cod_diagnoz, vizit_date
from Patient_Fam_doctor_view inner join Referral on Patient_Fam_doctor_view.cod_pac = Referral.cod_pac
go


select *
from Patient_Fam_doctor_Referral_view
go

--Вывести список на приём к семейному врачу за 2022-02-17 число--
select fio_pac as Patient, vizit_date as Visit_time
from Patient_Fam_doctor_Referral_view
where year(vizit_date) = 2022 and month(vizit_date) = 02 and day(vizit_date) = 17
go




--Создадим представление для записей к специалистам--
create view Patient_Referral_view as
select fio_pac, age, gender, Birth_date, pac_adres, pac_tel, Number_insurance_police, Work, IDNP, cod_spec, cod_diagnoz, vizit_date
from Patient inner join Referral on Patient.cod_pac = Referral.cod_pac
go

select *
from Patient_Referral_view
go



create view Inst_Spec_view as
select cod_spec, fio_spec, post, Speciallist.Stamp, name_MI, legal_adres, Tel_numb
from Speciallist inner join Med_inst on Speciallist.cod_MI = Med_inst.cod_MI
go

create view Patient_Referral_Spec_view as
select fio_pac, age, gender, Birth_date, pac_adres, pac_tel, Number_insurance_police, Work, cod_diagnoz, vizit_date, fio_spec, post, Stamp, name_MI, legal_adres, Tel_numb
from Patient_Referral_view inner join Inst_Spec_view on Patient_Referral_view.cod_spec = Inst_Spec_view.cod_spec
go


select *
from Patient_Referral_Spec_view
go


--вывести фамилии пациентов и даты приема, которым дали направление к неврологу--
select fio_pac, vizit_date
from Patient_Referral_Spec_view
where post = 'Nevrolog'
go


--Посмотреть в каком мед. учреждении принимает невролог, к которому были направлены пациенты--
select distinct name_MI /*distinct - убирает повторения*/ 
from Patient_Referral_Spec_view
where post = 'Nevrolog'
go






select *
from Inst_Spec_view
go
select *
from Referral
go










select *
from Diagnoza
go
select *
from Family_doctor
go
select *
from Med_inst
go
select *
from Medicaments
go
select *
from Note
go
select *
from Patient
go
select *
from Recept
go
select *
from Referral
go
select *
from Speciallist
go
select *
from Tratement
go
select *
from Tratement_Medicaments
go




--Домашняя работа за 29.03.2022--

--Задание: создайте  все  необходимые для проекта представления и обоснуйте необходимость их создания.--



--Создадим представление Пациент-Семейный врач--
create view Patient_Fam_doctor_view as
select cod_pac, fio_pac, age, gender, Birth_date, pac_adres, pac_tel, Number_insurance_police, Work, IDNP, fio_doct, Tel_munb, area, Stamp
from Patient inner join Family_doctor on Patient.Cod_fam_doctor = Family_doctor.Cod_fam_doctor
go


select *
from Patient_Fam_doctor_view
go

create view Patient_Fam_doctor_Referral_view as
select fio_pac, age, gender, Birth_date, pac_adres, pac_tel, Number_insurance_police, Work, IDNP, fio_doct, Tel_munb, area, Stamp, cod_diagnoz, vizit_date
from Patient_Fam_doctor_view inner join Referral on Patient_Fam_doctor_view.cod_pac = Referral.cod_pac
go


select *
from Patient_Fam_doctor_Referral_view
go





--Создадим представление для записей к специалистам--
create view Patient_Referral_view as
select fio_pac, age, gender, Birth_date, pac_adres, pac_tel, Number_insurance_police, Work, IDNP, cod_spec, cod_diagnoz, vizit_date
from Patient inner join Referral on Patient.cod_pac = Referral.cod_pac
go


select *
from Patient_Referral_view
go



create view Inst_Spec_view as
select cod_spec, fio_spec, post, Speciallist.Stamp, name_MI, legal_adres, Tel_numb
from Speciallist inner join Med_inst on Speciallist.cod_MI = Med_inst.cod_MI
go

create view Patient_Referral_Spec_view as
select fio_pac, age, gender, Birth_date, pac_adres, pac_tel, Number_insurance_police, Work, cod_diagnoz, vizit_date, fio_spec, post, Stamp, name_MI, legal_adres, Tel_numb
from Patient_Referral_view inner join Inst_Spec_view on Patient_Referral_view.cod_spec = Inst_Spec_view.cod_spec
go


select *
from Patient_Referral_Spec_view
go

/*Данные представления нам необходимы для того, чтобы быстро получить информацию о записях пациентов к врачам...*/





--Создадим представление о всех заболеваниях и способах их лечения--
/*Данное представление нам необходимо для того, чтобы знать, каким образом лечится то или иное заболевание (а также какими препаратами - полезно для выписывания рецептов)*/
create view Tratement_diagnoza_view as
select name_diagnoz, trat_name, trat_method, duration, Tratement.cod_trate
from Tratement inner join Diagnoza on Tratement.cod_trate = Diagnoza.cod_trate
go


select *
from Tratement_diagnoza_view
go

create view Tratement_medicaments_view as
select cod_trate, med_name, purpose, dosage, instruction
from Medicaments inner join Tratement_Medicaments on Medicaments.cod_med = Tratement_Medicaments.cod_med
go


select *
from Tratement_medicaments_view
go

create view Tratement_view as
select name_diagnoz, trat_name, trat_method, duration, med_name, purpose, dosage, instruction
from Tratement_diagnoza_view inner join Tratement_medicaments_view on Tratement_diagnoza_view.cod_trate = Tratement_medicaments_view.cod_trate
go


select *
from Tratement_view
go





--Создадим представление для всех препаратах, выписанных в рецептах--
/*Данное представление в дальнейшем нам необходимо для того, чтобы узнать какие препараты были выписаны тому или иному пациенту*/
create view Reciept_Medicaments_view as
select recept_numb, med_name, purpose, instruction, Recept.Dosage, trat_duration, prescription_date
from Recept inner join Medicaments on Recept.cod_med = Medicaments.cod_med
go


select *
from Reciept_Medicaments_view
go





--Создадим представление о пациентах и их заболеваниях--
/*Данное представление полезно, если необходимо узнать чем болел тот или иной пациент, а также для статистики*/
create view TPatient_Referral_view as
select Patient_Fam_doctor_view.cod_pac, fio_pac, age, gender, Birth_date, pac_adres, fio_doct, Stamp, pac_tel, Number_insurance_police, Work, IDNP, cod_diagnoz
from Patient_Fam_doctor_view inner join Referral on Patient_Fam_doctor_view.cod_pac = Referral.cod_pac
go


select *
from TPatient_Referral_view
go

create view Patient_Diagnoza_view as
select cod_pac, fio_pac, age, gender, Birth_date, pac_adres, fio_doct, Stamp, pac_tel, Number_insurance_police, Work, IDNP, name_diagnoz
from TPatient_Referral_view inner join Diagnoza on TPatient_Referral_view.cod_diagnoz = Diagnoza.cod_diagnoz
go


select *
from Patient_Diagnoza_view
go





--Создадим представление о всех рецептах выписанных пациентам--
/*Данное представление нам необходимо по той причине, что достаточно часто необходимо узнать, какие препараты и в какой дозизовке были выписаны тому или иному пациенту*/

create view Reciept_Patient_view as
select recept_numb, fio_pac, age, gender, Birth_date, pac_adres, fio_doct, pac_tel, Number_insurance_police, Work, IDNP, name_diagnoz, cod_med, Dosage, trat_duration, prescription_date, cod_MI, cod_spec
from Recept inner join Patient_Diagnoza_view on Recept.cod_pac = Patient_Diagnoza_view.cod_pac
go


select *
from Reciept_Patient_view
go

create view TReciept_Medicament_view as
select recept_numb, fio_pac, age, gender, Birth_date, pac_adres, fio_doct, pac_tel, Number_insurance_police, Work, IDNP, name_diagnoz, med_name, purpose, Reciept_Patient_view.Dosage, trat_duration, prescription_date, cod_MI, cod_spec
from Medicaments inner join Reciept_Patient_view on Medicaments.cod_med = Reciept_Patient_view.cod_med
go


select *
from TReciept_Medicament_view
go

create view Reciept_MediclInst_view as
select recept_numb, fio_pac, age, gender, Birth_date, pac_adres, fio_doct, pac_tel, Number_insurance_police, Work, IDNP, name_diagnoz, med_name, purpose, TReciept_Medicament_view.Dosage, trat_duration, prescription_date, name_MI, Stamp as Stamp_MI, cod_spec
from Med_inst inner join TReciept_Medicament_view on Med_inst.cod_MI = TReciept_Medicament_view.cod_MI
go


select *
from Reciept_MediclInst_view
go


create view Reciept_view as
select recept_numb, fio_pac, age, gender, Birth_date, pac_adres, fio_doct, pac_tel, Number_insurance_police, Work, IDNP, name_diagnoz, med_name, purpose, Reciept_MediclInst_view.Dosage, trat_duration, prescription_date, name_MI, Stamp as Stamp_MI, fio_spec, post, Stamp
from Speciallist inner join Reciept_MediclInst_view on Speciallist.cod_spec = Reciept_MediclInst_view.cod_spec
go


select *
from Reciept_view
go

insert into Reciept_view (recept_numb, fio_pac, age, gender, Birth_date, pac_adres, fio_doct, pac_tel, Number_insurance_police, Work, IDNP, name_diagnoz, med_name, purpose, Dosage, trat_duration, prescription_date, name_MI, Stamp_MI, fio_spec, post, Stamp) values(1111, 'A', 1, 'M', '1985-11-11', 'Asasas', 'Antonescu Anton Anton', '+37368888967', 562369, 'Librarius', '1985550354233', 'Headache', 'Geucamen', 'Back', 100, 30, '2022-02-09', 'Med Family', 'Malahov A.N.', 'Malahov Andrei Nicolai', 'Terapeft', 'Malahov A.N.') 


delete from Reciept_view where recept_numb = 1111
go
