insert into sp.p (pCOD, PNAME, COLOR, WEIGHT, CITY) values (1,'Nut','Red',12,'London');
insert into sp.p (pCOD, PNAME, COLOR, WEIGHT, CITY) values (2,'Bolt','Green',17,'Paris');
insert into sp.p (pCOD, PNAME, COLOR, WEIGHT, CITY) values (3,'Screw','Blue',17,'Rome');
insert into sp.p (pCOD, PNAME, COLOR, WEIGHT, CITY) values (4,'Screw','Red',14,'London');
insert into sp.p (pCOD, PNAME, COLOR, WEIGHT, CITY) values (5,'Cam','Blue',12,'Paris');
insert into sp.p (pCOD, PNAME, COLOR, WEIGHT, CITY) values (6,'Cog','Red',19,'London');

insert into sp.S (sCOD, sNAME, status, CITY) values (1,'Smith',20, 'London');
insert into sp.S (sCOD, sNAME, status, CITY) values (2,'Jones',10, 'Paris');
insert into sp.S (sCOD, sNAME, status, CITY) values (3,'Blake',30, 'Paris');
insert into sp.S (sCOD, sNAME, status, CITY) values (4,'Clark',20, 'London');
insert into sp.S (sCOD, sNAME, status, CITY) values (5,'Adams',30, 'Athens');

insert into sp.sp (scod, pcod, qty) values (1,1,300);
insert into sp.sp (scod, pcod, qty) values (1,2,200);
insert into sp.sp (scod, pcod, qty) values (1,3,400);
insert into sp.sp (scod, pcod, qty) values (1,4,200);
insert into sp.sp (scod, pcod, qty) values (1,5,100);
insert into sp.sp (scod, pcod, qty) values (1,6,100);
insert into sp.sp (scod, pcod, qty) values (2,1,300);
insert into sp.sp (scod, pcod, qty) values (2,2,400);
insert into sp.sp (scod, pcod, qty) values (3,2,200);
insert into sp.sp (scod, pcod, qty) values (4,2,200);
insert into sp.sp (scod, pcod, qty) values (4,4,300);
insert into sp.sp (scod, pcod, qty) values (4,5,400);
