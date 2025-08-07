-- PartI 
start C:\Users\Eylij\Downloads\3304_Project3Starter_sm2025.sql
-- Create an output file
spool 'C:\INSY 3304 PROJ 2\Project3inputebb.txt'

-- Log all input( In addition to the output) to the spooled output(.txt) file 

SET echo on 

-- Eylijah Brinson
-- Project 3
-- INSY 3304-001


-- PartII
	ALTER SESSION SET nls_date_format='MM/DD/YYYY HH12:MI AM' ;

-- 2. Make sure no column headings are truncated

-- 3. Set the linesize to minimize wrapping
SET LINESIZE 175

-- 4. Dot notation and aliases will ber applied to necessary in Part III

-- 5. Through 7. Use update statements to modify the rows as required 

UPDATE TREATMENT_ebb
SET TreatmentDesc = 'Cortizone Injection-20 ml'
WHERE TreatmentCode = 'CI1';

UPDATE TREATMENT_ebb
SET TreatmentDesc = 'Cortizone Injection-40 ml'
WHERE TreatmentCode = 'CI2';

-- 6. Change the ApptStatus to “CN” for Appointment 109.
UPDATE APPOINTMENT_ebb
SET ApptStatusCode = 'CN'
WHERE ApptID = 109;

-- 7. Change the ApptStatus to “CM” and the PmtStatus to “PD” for Appointment 107.
UPDATE APPOINTMENT_ebb
SET ApptStatusCode = 'CM',
    PmtStatus = 'PD'
WHERE ApptID = 107;

-- 8. Add a new Appointment. Generate the ApptID by incrementing the max ApptID by 1.
INSERT INTO APPOINTMENT_ebb ( ApptID, ApptDateTime, PatientID, BillingType, InsCoID, ProvID, ApptStatusCode, PmtStatus)
SELECT MAX(ApptID) + 1, TO_DATE('02/21/2024 10:00AM', 'MM/DD/YYYY HH:MIAM'), 105, 'I', 323, 3, 'NC', 'NP'
FROM APPOINTMENT_ebb;

INSERT INTO APPTDETAIL_ebb
SELECT MAX(ApptID), 'PT60' FROM APPOINTMENT_ebb;

-- 9. Add a new Appointment. Generate the ApptID by incrementing the max ApptID by 1.
INSERT INTO APPOINTMENT_ebb ( ApptID, ApptDateTime, PatientID, BillingType, InsCoID, ProvID, ApptStatusCode, PmtStatus)
SELECT MAX(ApptID) + 1, TO_DATE('02/22/2024 10:00AM', 'MM/DD/YYYY HH:MIAM'), 15, 'SP', 2, 3, 'NC', 'NP'
FROM APPOINTMENT_ebb;

INSERT INTO APPTDETAIL_ebb
SELECT MAX(ApptID), 'PSF' FROM APPOINTMENT_ebb;

-- 10. Change the phone number for Patient 15 to 469-555-8918 
UPDATE PATIENT_ebb
SET PatientPhone = '4695558918'
WHERE PatientID = 15;

COMMIT;

-- PART III

-- 1
SELECT PatientID AS "Patient ID", PatientFName || ' ' || PatientLName AS "Patient Name"
FROM PATIENT_ebb
ORDER BY PatientLName ASC;

-- 2.
SELECT a.ApptID AS "ApptID", t.TreatmentDesc AS "Treatment", TO_CHAR(t.TreatmentRate, '$999,999.00') AS "Rate"
FROM APPTDETAIL_ebb a
JOIN TREATMENT_ebb t ON a.TreatmentCode = t.TreatmentCode
WHERE a.ApptID = 111
    AND t.TreatmentRate = (
        SELECT MAX(t2.TreatmentRate)
        FROM APPTDETAIL_ebb a2
        JOIN TREATMENT_ebb t2 ON a2.TreatmentCode = t2.TreatmentCode
        WHERE a2.ApptID = 111
    );

-- 3.
SELECT 
    b.BlockCode AS "BlockCode",
    b.BlockDesc AS "Description",
    b.BlockMinutes AS "Minutes",
    COUNT(t.TreatmentCode) AS "TreatmentCount"
FROM BLOCKCODE_ebb b
LEFT JOIN TREATMENT_ebb t ON b.BlockCode = t.BlockCode
GROUP BY b.BlockCode, b.BlockDesc, b.BlockMinutes
ORDER BY COUNT(t.TreatmentCode) ASC;

-- 4.
SELECT 
    a.ApptID AS "ApptID",
    t.TreatmentCode AS "TreatCode",
    t.TreatmentDesc AS "TreatDesc",
    t.BlockCode AS "BlockCode",
    b.BlockDesc AS "BlockCodeDesc",
    b.BlockMinutes AS "Minutes",
    TO_CHAR(t.TreatmentRate, '$999,999.00') AS "Rate"
FROM APPTDETAIL_ebb a
JOIN TREATMENT_ebb t ON a.TreatmentCode = t.TreatmentCode
JOIN BLOCKCODE_ebb b ON t.BlockCode = b.BlockCode
WHERE t.TreatmentRate = (
    SELECT MAX(t2.TreatmentRate)
    FROM APPTDETAIL_ebb a2
    JOIN TREATMENT_ebb t2 ON a2.TreatmentCode = t2.TreatmentCode
    WHERE a2.ApptID = a.ApptID);

-- 5.
SELECT 
    t.TreatmentCode AS "TreatmentCode",
    t.TreatmentDesc AS "Description",
    COUNT(a.ApptID) AS "ApptCount"
FROM TREATMENT_ebb t
LEFT JOIN APPTDETAIL_ebb a ON t.TreatmentCode = a.TreatmentCode
GROUP BY t.TreatmentCode, t.TreatmentDesc;

-- 6.
SELECT 
    a.ApptID AS "ApptID",
    TO_CHAR(a.ApptDateTime, 'MM/DD/YY, HH:MIAM') AS "Date/Time",
    p.PatientFName || ' ' || p.PatientLName AS "Patient",
    '(' || SUBSTR(p.PatientPhone, 1, 3) || ') ' ||
         SUBSTR(p.PatientPhone, 4, 3) || '-' ||
         SUBSTR(p.PatientPhone, 7, 4) AS "Phone",
    pr.ProviderFName || ' ' || pr.ProviderLName AS "Provider"
FROM APPOINTMENT_ebb a
JOIN PATIENT_ebb p ON a.PatientID = p.PatientID
JOIN PROVIDER_ebb pr ON a.ProvID = pr.ProvID
ORDER BY a.ApptID;

-- 7.

SELECT 
    p.ProvID AS "Provider ID",
    p.ProviderFName AS "First Name",
    p.ProviderLName AS "Last Name",
    COUNT(a.ApptID) AS "Appt Count"
FROM PROVIDER_ebb p
LEFT JOIN APPOINTMENT_ebb a ON p.ProvID = a.ProvID
GROUP BY p.ProvID, p.ProviderFName, p.ProviderLName
ORDER BY COUNT(a.ApptID) DESC;

-- 8.

SELECT 
    p.ProvID AS "Provider ID",
    p.ProviderFName || ' ' || p.ProviderLName AS "Name",
    TO_CHAR(SUM(t.TreatmentRate), '$999,999.00') AS "Total Charges"
FROM PROVIDER_ebb p
JOIN APPOINTMENT_ebb a ON p.ProvID = a.ProvID
JOIN APPTDETAIL_ebb d ON a.ApptID = d.ApptID
JOIN TREATMENT_ebb t ON d.TreatmentCode = t.TreatmentCode
GROUP BY p.ProvID, p.ProviderFName, p.ProviderLName
ORDER BY SUM(t.TreatmentRate) DESC;

-- 9.
SELECT 
    a.ApptID AS "ApptID",
    TO_CHAR(a.ApptDateTime, 'MM/DD/YYYY HH:MIAM') AS "Date/Time",
    COUNT(d.TreatmentCode) AS "TreatmentCount",
    TO_CHAR(SUM(t.TreatmentRate), '$999,999.00') AS "TotalCharge"
FROM APPOINTMENT_ebb a
JOIN APPTDETAIL_ebb d ON a.ApptID = d.ApptID
JOIN TREATMENT_ebb t ON d.TreatmentCode = t.TreatmentCode
GROUP BY a.ApptID, a.ApptDateTime
ORDER BY SUM(t.TreatmentRate) DESC, a.ApptID DESC;

-- 10.
SELECT 
    t.BlockCode AS "Block_Code",
    t.TreatmentCode AS "Treatment_Code",
    t.TreatmentDesc AS "Treatment_Desc",
    TO_CHAR(t.TreatmentRate, '$999,999.00') AS "Rate"
FROM TREATMENT_ebb t
ORDER BY t.BlockCode ASC,
    	 t.TreatmentCode ASC;

-- 11.
SELECT 
    p.PatientID AS "Patient ID",
    p.PatientLName AS "Last Name",
    a.ApptID AS "Appt ID",
    TO_CHAR(a.ApptDateTime, 'MM/DD/YYYY') AS "Appt Date",
    pr.ProviderLName AS "Provider"
FROM APPOINTMENT_ebb a
JOIN PATIENT_ebb p ON a.PatientID = p.PatientID
JOIN PROVIDER_ebb pr ON a.ProvID = pr.ProvID
ORDER BY p.PatientID ASC;

-- 12.
SELECT 
    a.ApptID AS "Appt ID",
    TO_CHAR(a.ApptDateTime, 'MM/DD/YYYY HH:MI AM') AS "Date/Time",
    TO_CHAR(SUM(t.TreatmentRate), '$999,999.00') AS "Amt Paid"
FROM APPOINTMENT_ebb a
JOIN APPTDETAIL_ebb d ON a.ApptID = d.ApptID
JOIN TREATMENT_ebb t ON d.TreatmentCode = t.TreatmentCode
WHERE a.PmtStatus = 'PD'
GROUP BY a.ApptID, a.ApptDateTime
ORDER BY SUM(t.TreatmentRate) DESC;

-- 13.
SELECT 
    TO_CHAR((COUNT(InsCoID) * 100.0 / COUNT(*)), '990.9') || '%' AS "Percentage with Insurance"
FROM APPOINTMENT_ebb;

-- 14.
SELECT 
    TO_CHAR(AVG(TreatmentRate), '$999,999.00') AS "Avg_Rate"
FROM TREATMENT_ebb;

-- 15.
SELECT 
    a.ApptID AS "ApptID",
    TO_CHAR(a.ApptDateTime, 'MM/DD/YYYY') AS "Date",
    p.PatientLName AS "Patient",
    SUM(b.BlockMinutes) || ' Minutes' AS "Duration"
FROM APPOINTMENT_ebb a
JOIN PATIENT_ebb p ON a.PatientID = p.PatientID
JOIN APPTDETAIL_ebb d ON a.ApptID = d.ApptID
JOIN TREATMENT_ebb t ON d.TreatmentCode = t.TreatmentCode
JOIN BLOCKCODE_ebb b ON t.BlockCode = b.BlockCode
GROUP BY a.ApptID, a.ApptDateTime, p.PatientLName
ORDER BY a.ApptDateTime;

-- 16.
SELECT 
    a.ApptID AS "ApptID",
    t.TreatmentCode AS "TreatmentCode",
    t.TreatmentDesc AS "Description",
    b.BlockMinutes AS "Minutes",
    TO_CHAR(t.TreatmentRate, '$999,999.00') AS "Rate"
FROM APPTDETAIL_ebb a
JOIN TREATMENT_ebb t ON a.TreatmentCode = t.TreatmentCode
JOIN BLOCKCODE_ebb b ON t.BlockCode = b.BlockCode
WHERE t.TreatmentRate = (
        SELECT MIN(t2.TreatmentRate)
        FROM APPTDETAIL_ebb a2
        JOIN TREATMENT_ebb t2 ON a2.TreatmentCode = t2.TreatmentCode
        WHERE a2.ApptID = a.ApptID );

-- 17.
SELECT 
    t.TreatmentCode AS "Treatment Code",
    t.TreatmentDesc AS "Description",
    b.BlockMinutes AS "Minutes",
    TO_CHAR(t.TreatmentRate, '$999,999.00') AS "Rate"
FROM TREATMENT_ebb t
JOIN BLOCKCODE_ebb b ON t.BlockCode = b.BlockCode
WHERE t.TreatmentRate > (SELECT AVG(TreatmentRate) FROM TREATMENT_ebb);

-- 18.
SELECT 
    a.ApptID AS "ApptID",
    TO_CHAR(a.ApptDateTime, 'MM-DD-YYYY') AS "Date",
    p.PatientID AS "PatientID",
    p.PatientLName AS "Name",
    SUBSTR(p.PatientPhone, 1, 3) || '-' || 
    SUBSTR(p.PatientPhone, 4, 3) || '-' || 
    SUBSTR(p.PatientPhone, 7, 4) AS "Phone"
FROM APPOINTMENT_ebb a
JOIN PATIENT_ebb p ON a.PatientID = p.PatientID
WHERE a.ApptDateTime <= TO_DATE('02/20/2024', 'MM/DD/YYYY')
ORDER BY a.ApptDateTime ASC, p.PatientID ASC;

-- 19.
SELECT 
    p.PatientID AS "PatientID",
    p.PatientFName AS "First Name",
    p.PatientLName AS "Last Name",
    SUBSTR(p.PatientPhone, 1, 3) || '-' || 
    SUBSTR(p.PatientPhone, 4, 3) || '-' || 
    SUBSTR(p.PatientPhone, 7, 4) AS "Phone"
FROM PATIENT_ebb p
WHERE p.PatientFName LIKE 'J%' OR p.PatientLName LIKE 'J%'
ORDER BY p.PatientID ASC;

-- 20.
SELECT 
    s.ApptStatusCode AS "Status Code",
    s.ApptStatusDesc AS "Description",
    COUNT(a.ApptID) AS "Appt Count"
FROM APPTSTATUS_ebb s
LEFT JOIN APPOINTMENT_ebb a ON s.ApptStatusCode = a.ApptStatusCode
GROUP BY s.ApptStatusCode, s.ApptStatusDesc
ORDER BY COUNT(a.ApptID) DESC;

COMMIT;
-- stop logging to the out file 
spool off

set echo off