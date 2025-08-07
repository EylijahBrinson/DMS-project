-- Include the full path. This will start logging to the specified output file.
spool 'C:\INSY 3304 PROJ 2\Project2_ebb.txt'

set echo on
-- This will ensure that all input and output is logged to the file.

-- Eylijah Brinson
-- INSY 3304-001
-- Project 2

ALTER SESSION SET NLS_TIMESTAMP_FORMAT='MM/DD/YYYY HH:MI AM'

-- DROP all tables in the oppopsite order they were created to prevent name is already used by an existing object
DROP TABLE AppointmentDetail_ebb;
DROP TABLE AppointmentInfo_ebb;
DROP TABLE PaymentInfo_ebb;
DROP TABLE StatusInfo_ebb;
DROP TABLE BillingInfo_ebb;
DROP TABLE ProviderInfo_ebb;
DROP TABLE InsuranceInfo_ebb;
DROP TABLE PatientInfo_ebb;
DROP TABLE TreatmentInfo_ebb;
DROP TABLE Block_ebb;


-- Part1A
CREATE TABLE Block_ebb(
BlockCode	char(2) NOT NULL,	
BlockDesc 	varchar2(20) NOT NULL,
BlockMinutes	number(3) NOT NULL,
PRIMARY KEY (BlockCode)
);

CREATE TABLE TreatmentInfo_ebb(
TreatementCode varchar2(5) NOT NULL,
TreatementDesc varchar2(30) NOT NULL,
TreatementRate number(6,2) NOT NULL,
BlockCode	char(2) NOT NULL,
BlockDesc	varchar2(20),
BlockMinutes number(3),
PRIMARY KEY (TreatementCode),
FOREIGN KEY (BlockCode) REFERENCES Block_ebb
);


CREATE TABLE PatientInfo_ebb(
PatientID number(5),
PatientFName varchar2(20),
PatientLName varchar2(20),
PRIMARY KEY (PatientID)
);

CREATE TABLE InsuranceInfo_ebb(
InsCoID number(5) NOT NULL,
InsCoName varchar2(30) NOT NULL,
PRIMARY KEY (InsCoID)
);

CREATE TABLE ProviderInfo_ebb(
ProvID number(5) NOT NULL,
ProvFName varchar2(20) NOT NULL,
ProvLName varchar2(20) NOT NULL,
PRIMARY KEY (ProvID)
);

CREATE TABLE BillingInfo_ebb(
BillingType char(2) NOT NULL,
BillingTypeDesc varchar2(20) NOT NULL,
PRIMARY KEY (BillingType)
);

CREATE TABLE StatusInfo_ebb(
ApptStatusCode char(2) NOT NULL,
ApptStatusDesc varchar2(20) NOT NULL,
PRIMARY KEY (ApptStatusCode)
);

CREATE TABLE PaymentInfo_ebb(
PmtStatus char(2) NOT NULL,
PmtDesc varchar2(20) NOT NULL,
PRIMARY KEY (PmtStatus)
);

CREATE TABLE AppointmentInfo_ebb(
ApptID number(5) NOT NULL,
ApptDate date NOT NULL,
ApptTime varchar2(10) NOT NULL,
PatientID number(5) NOT NULL,
PatientFName varchar2(20) NOT NULL,
PatientLName varchar2(20) NOT NULL,
PatientPhone varchar2(20),
BillingType char(2) NOT NULL,
BillingTypeDesc varchar2(20) NOT NULL,
InsCoID number(5),
InsCoName varchar2(20),
ProvID number(5) NOT NULL,
ProvFName varchar2(20) NOT NULL,
ProvLName varchar2(20) NOT NULL,
ApptStatusCode char(2) NOT NULL,
ApptStatusDesc varchar2(20) NOT NULL,
PmtStatus char(2) NOT NULL,
PmtDesc varchar2(20) NOT NULL,
PRIMARY KEY (ApptID), 
FOREIGN KEY (PatientID) REFERENCES PatientInfo_ebb,
FOREIGN KEY (InsCoID) REFERENCES InsuranceInfo_ebb,
FOREIGN KEY (ProvID) REFERENCES ProviderInfo_ebb ,
FOREIGN KEY (ApptStatusCode) REFERENCES StatusInfo_ebb,
FOREIGN KEY (PmtStatus) REFERENCES PaymentInfo_ebb ,
FOREIGN key (BillingType) REFERENCES BillingInfo_ebb
);

CREATE TABLE AppointmentDetail_ebb (
ApptID         number(5)     NOT NULL,
TreatmentCode  varchar2(5)   NOT NULL,
PRIMARY KEY (ApptID, TreatmentCode),
FOREIGN KEY (TreatmentCode) REFERENCES TreatmentInfo_ebb,
FOREIGN KEY (ApptID) REFERENCES AppointmentInfo_ebb
);
-- 1B
DESCRIBE AppointmentInfo_ebb
DESCRIBE PaymentInfo_ebb
DESCRIBE StatusInfo_ebb
DESCRIBE BillingInfo_ebb
DESCRIBE ProviderInfo_ebb
DESCRIBE InsuranceInfo_ebb
DESCRIBE PatientInfo_ebb
DESCRIBE AppointmentDetail_ebb
DESCRIBE TreatmentInfo_ebb
DESCRIBE Block_ebb

-- part2

INSERT INTO Block_ebb
VALUES('L1','Level 1',15);

INSERT INTO Block_ebb
VALUES('L2','Level 2',20);

INSERT INTO Block_ebb
VAlUES('L3','Level 3',30);

INSERT INTO Block_ebb
VAlUES('L4','Level 4',60);
-- Row inserted

INSERT INTO TreatmentInfo_ebb(TreatementCode, TreatementDesc, TreatementRate, BlockCode) 
VALUES ('NP','New Patient',45,'L1');

INSERT INTO TreatmentInfo_ebb(TreatementCode, TreatementDesc, TreatementRate, BlockCode) 
VALUES ('GBP','General Back Pain',60,'L2');

INSERT INTO TreatmentInfo_ebb(TreatementCode, TreatementDesc, TreatementRate, BlockCode) 
VALUES ('XR','X-Ray',250,'L2');

INSERT INTO TreatmentInfo_ebb(TreatementCode, TreatementDesc, TreatementRate, BlockCode) 
VALUES ('PSF','Post-Surgery Follow Up',30,'L1');

INSERT INTO TreatmentInfo_ebb(TreatementCode, TreatementDesc, TreatementRate, BlockCode) 
VALUES ('SR','Suture Removal',50, 'L2');

INSERT INTO TreatmentInfo_ebb(TreatementCode, TreatementDesc, TreatementRate, BlockCode) 
VALUES ('PT30','Physical Therapy 30',65, 'L4');

INSERT INTO TreatmentInfo_ebb(TreatementCode, TreatementDesc, TreatementRate, BlockCode) 
VALUES ('BI','Back Injury', 110,'L2');

INSERT INTO TreatmentInfo_ebb(TreatementCode, TreatementDesc, TreatementRate, BlockCode) 
VALUES ('PT60','Physical Therapy 60',110, 'L3');

INSERT INTO TreatmentInfo_ebb(TreatementCode, TreatementDesc, TreatementRate, BlockCode) 
VALUES ('HP','Hip Pain',250,'L2');
-- Row inserted

INSERT INTO PatientInfo_ebb 
VALUES (101,'Wesley','Tanner');

INSERT INTO PatientInfo_ebb 
VALUES (100,'Brenda','Rhodes');

INSERT INTO PatientInfo_ebb 
VALUES (15,'Jeff','Miner');

INSERT INTO PatientInfo_ebb 
VALUES (77,'Kim','Jackson');

INSERT INTO PatientInfo_ebb 
VALUES (119,'Mary','Vaughn');

INSERT INTO PatientInfo_ebb 
VALUES (97,'Chris','Mancha');

INSERT INTO PatientInfo_ebb 
VALUES (28,'Renee','Walker');

INSERT INTO PatientInfo_ebb 
VALUES (105,'Johnny','Redmond');

INSERT INTO PatientInfo_ebb 
VALUES (84,'James','Clayton');

INSERT INTO PatientInfo_ebb 
VALUES (23,'Shelby','Davis');
-- row inserted


INSERT INTO InsuranceInfo_ebb 
VALUES (323,'Humana');

INSERT INTO InsuranceInfo_ebb 
VALUES (129,'Blue Cross');

INSERT INTO InsuranceInfo_ebb 
VALUES (135,'TriCare');

INSERT INTO InsuranceInfo_ebb 
VALUES (210,'State Farm');
-- Row inserted


INSERT INTO ProviderInfo_ebb 
VALUES (2, 'Michael','Smith');

INSERT INTO ProviderInfo_ebb 
VALUES (5, 'Janice','May');

INSERT INTO ProviderInfo_ebb 
VALUES (1,'Kay','Jones');

INSERT INTO ProviderInfo_ebb 
VALUES (3, 'Ray','Schultz');
-- Row inserted


INSERT INTO BillingInfo_ebb 
VALUES ('I','Insurance');

INSERT INTO BillingInfo_ebb 
VALUES ('SP','Self-Pay');

INSERT INTO BillingInfo_ebb 
VALUES ('WC','Worker''s Comp');
-- Row inserted


INSERT INTO StatusInfo_ebb 
VALUES ('CM','Complete');

INSERT INTO StatusInfo_ebb 
VALUES ('CN','Confirmed');

INSERT INTO StatusInfo_ebb 
VALUES ('NC','Not Confirmed');
-- Row inserted


INSERT INTO PaymentInfo_ebb 
VALUES ('PD','Paid in Full');

INSERT INTO PaymentInfo_ebb 
VALUES ('PP','Partial Pmt');

INSERT INTO PaymentInfo_ebb 
VALUES ('NP','Not Paid');
-- Row inserted

-- ApptID 101
INSERT INTO AppointmentInfo_ebb VALUES (
  101, TO_TIMESTAMP('2/19/2024 09:00 AM', 'MM/DD/YYYY HH:MI AM'), '9:00 AM',
  101, 'Wesley', 'Tanner', '(817)555-1193',
  'I', 'Insurance', 323, 'Humana',
  2, 'Michael', 'Smith',
  'CM', 'Complete',
  'PD', 'Paid in Full'
);

-- ApptID 102
INSERT INTO AppointmentInfo_ebb VALUES (
  102, TO_TIMESTAMP('2/19/2024 09:00 AM', 'MM/DD/YYYY HH:MI AM'), '9:00 AM',
  100, 'Brenda', 'Rhodes', '(214)555-9191',
  'I', 'Insurance', 129, 'Blue Cross',
  5, 'Janice', 'May',
  'CM', 'Complete',
  'PP', 'Partial Pmt'
);

-- ApptID 103
INSERT INTO AppointmentInfo_ebb VALUES (
  103, TO_TIMESTAMP('2/19/2024 10:00 AM', 'MM/DD/YYYY HH:MI AM'), '10:00 AM',
  15, 'Jeff', 'Miner', '(469)555-2301',
  'SP', 'Self-Pay', 129, 'Blue Cross',
  2, 'Michael', 'Smith',
  'CM', 'Complete',
  'PD', 'Paid in Full'
);

-- ApptID 104
INSERT INTO AppointmentInfo_ebb VALUES (
  104, TO_TIMESTAMP('2/19/2024 10:30 PM', 'MM/DD/YYYY HH:MI AM'), '10:30 PM',
  77, 'Kim', 'Jackson', '(817)555-4911',
  'WC', 'Worker''s Comp', 210, 'State Farm',
  1, 'Kay', 'Jones',
  'CM', 'Complete',
  'PP', 'Partial Pmt'
);

-- ApptID 105
INSERT INTO AppointmentInfo_ebb VALUES (
  105, TO_TIMESTAMP('2/19/2024 10:30 AM', 'MM/DD/YYYY HH:MI AM'), '10:30 AM',
  119, 'Mary', 'Vaughn', '(817)555-2334',
  'I', 'Insurance', 129, 'Blue Cross',
  2, 'Michael', 'Smith',
  'CM', 'Complete',
  'PP', 'Partial Pmt'
);

-- ApptID 106
INSERT INTO AppointmentInfo_ebb VALUES (
  106, TO_TIMESTAMP('2/19/2024 10:30 AM', 'MM/DD/YYYY HH:MI AM'), '10:30 AM',
  97, 'Chris', 'Mancha', '(469)555-3440',
  'SP', 'Self-Pay', 129, 'Blue Cross',
  3, 'Ray', 'Schultz',
  'CM', 'Complete',
  'NP', 'Not Paid'
);

-- ApptID 107
INSERT INTO AppointmentInfo_ebb VALUES (
  107, TO_TIMESTAMP('2/20/2024 11:30 AM', 'MM/DD/YYYY HH:MI AM'), '11:30 AM',
  28, 'Renee', 'Walker', '(214)555-9285',
  'I', 'Insurance', 129, 'Blue Cross',
  3, 'Ray', 'Schultz',
  'CN', 'Confirmed',
  'NP', 'Not Paid'
);

-- ApptID 108
INSERT INTO AppointmentInfo_ebb VALUES (
  108, TO_TIMESTAMP('2/20/2024 11:30 AM', 'MM/DD/YYYY HH:MI AM'), '11:30 AM',
  105, 'Johnny', 'Redmond', '(214)555-1084',
  'I', 'Insurance', 323, 'Humana',
  2, 'Michael', 'Smith',
  'CN', 'Confirmed',
  'NP', 'Not Paid'
);

-- ApptID 109
INSERT INTO AppointmentInfo_ebb VALUES (
  109, TO_TIMESTAMP('2/20/2024 02:00 PM', 'MM/DD/YYYY HH:MI AM'), '02:00 PM',
  84, 'James', 'Clayton', '(214)555-9285',
  'I', 'Insurance', 135, 'TriCare',
  5, 'Janice', 'May',
  'NC', 'Not Confirmed',
  'NP', 'Not Paid'
);

-- ApptID 110
INSERT INTO AppointmentInfo_ebb VALUES (
  110, TO_TIMESTAMP('2/20/2024 08:30 AM', 'MM/DD/YYYY HH:MI AM'), '8:30 AM',
  84, 'James', 'Clayton', '(214)555-9285',
  'I', 'Insurance', 135, 'TriCare',
  3, 'Ray', 'Schultz',
  'NC', 'Not Confirmed',
  'NP', 'Not Paid'
);

-- ApptID 111
INSERT INTO AppointmentInfo_ebb VALUES (
  111, TO_TIMESTAMP('2/20/2024 08:30 AM', 'MM/DD/YYYY HH:MI AM'), '8:30 AM',
  23, 'Shelby', 'Davis', '(817)555-1198',
  'WC', 'Worker''s Comp', 323, 'Humana',
  5, 'Janice', 'May',
  'CN', 'Confirmed',
  'NP', 'Not Paid'
);
-- Row inserted

INSERT INTO AppointmentDetail_ebb VALUES (101,'NP');
INSERT INTO AppointmentDetail_ebb VALUES (101,'GBP');
INSERT INTO AppointmentDetail_ebb VALUES (101,'XR');


INSERT INTO AppointmentDetail_ebb VALUES (102,'PSF');
INSERT INTO AppointmentDetail_ebb VALUES (102,'SR');

INSERT INTO AppointmentDetail_ebb VALUES (103,'PSF');
INSERT INTO AppointmentDetail_ebb VALUES (103,'SR');

INSERT INTO AppointmentDetail_ebb VALUES (104,'PT30');

INSERT INTO AppointmentDetail_ebb VALUES (105,'NP');
INSERT INTO AppointmentDetail_ebb VALUES (105,'BI');

INSERT INTO AppointmentDetail_ebb VALUES (106,'PT60');

INSERT INTO AppointmentDetail_ebb VALUES (107,'PT30');

INSERT INTO AppointmentDetail_ebb VALUES (108,'GBP');

INSERT INTO AppointmentDetail_ebb VALUES (109,'PSF');
INSERT INTO AppointmentDetail_ebb VALUES (109,'SR');

INSERT INTO AppointmentDetail_ebb VALUES (110,'PT30');
INSERT INTO AppointmentDetail_ebb VALUES (110,'NP');

INSERT INTO AppointmentDetail_ebb VALUES (111,'HP');
INSERT INTO AppointmentDetail_ebb VALUES (111,'XR');
-- Row inserted

COMMIT;

-- Part2B
SELECT * FROM AppointmentInfo_ebb;
SELECT * FROM PaymentInfo_ebb;
SELECT * FROM StatusInfo_ebb;
SELECT * FROM BillingInfo_ebb;
SELECT * FROM ProviderInfo_ebb;
SELECT * FROM InsuranceInfo_ebb;
SELECT * FROM PatientInfo_ebb;
SELECT * FROM AppointmentDetail_ebb;
SELECT * FROM TreatmentInfo_ebb;
SELECT * FROM Block_ebb;

-- Part3

UPDATE AppointmentInfo_ebb
SET PatientPhone = '2145551234'
WHERE PatientID = 100;

INSERT INTO PatientInfo_ebb
VALUES (120, 'Amanda', 'Green');

INSERT INTO TreatmentInfo_ebb (TreatementCode, TreatementDesc, TreatementRate, BlockCode)
VALUES ('CI1', 'Cortizone Injection 1', 50, 'L1');

INSERT INTO TreatmentInfo_ebb (TreatementCode, TreatementDesc, TreatementRate, BlockCode)
VALUES ('CI2', 'Cortizone Injection 2', 100, 'L1');

UPDATE AppointmentInfo_ebb
SET ApptDate = TO_TIMESTAMP('2/21/2024 11:30 AM', 'MM/DD/YYYY HH:MI AM')
WHERE ApptID = 108;

UPDATE AppointmentInfo_ebb
SET ApptDate = TO_TIMESTAMP('2/21/2024 11:30 AM', 'MM/DD/YYYY HH:MI AM')
WHERE ApptID = 108;

UPDATE AppointmentInfo_ebb
SET BillingType = 'WC', BillingTypeDesc = 'Worker''s Comp'
WHERE ApptID = 107;

INSERT INTO AppointmentInfo_ebb
VALUES (
  112, TO_TIMESTAMP('2/21/2024 09:00 AM', 'MM/DD/YYYY HH:MI AM'), '9:00 AM',
  120, 'Amanda', 'Green', NULL,
  'SP', 'Self-Pay', NULL, NULL,
  2, 'Michael', 'Smith',
  'NC', 'Not Confirmed',
  'NP', 'Not Paid'
);


INSERT INTO AppointmentDetail_ebb VALUES (112, 'NP');
INSERT INTO AppointmentDetail_ebb VALUES (112, 'HP');
INSERT INTO AppointmentDetail_ebb VALUES (112, 'CI2');

DELETE FROM AppointmentDetail_ebb
WHERE ApptID = 105 AND TreatmentCode = 'BI';

INSERT INTO AppointmentDetail_ebb VALUES (105, 'GBP');

SELECT * FROM AppointmentInfo_ebb
ORDER BY ApptID;

SELECT * FROM AppointmentDetail_ebb
ORDER BY ApptID, TreatmentCode;

SELECT * FROM BillingInfo_ebb
ORDER BY BillingType;

SELECT * FROM Block_ebb
ORDER BY BlockCode;

SELECT * FROM InsuranceInfo_ebb
ORDER BY InsCoID;

SELECT * FROM PatientInfo_ebb
ORDER BY PatientID;

SELECT * FROM PaymentInfo_ebb
ORDER BY PmtStatus;

SELECT * FROM ProviderInfo_ebb
ORDER BY ProvID;

SELECT * FROM StatusInfo_ebb
ORDER BY ApptStatus;

SELECT * FROM TreatmentInfo_ebb
ORDER BY TreatementCode;

-- This will turn off logging.
set echo off
-- This will close the file.
spool off
