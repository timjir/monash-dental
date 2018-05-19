spool ./md_insert_output.txt

-- INSERT VALUES INTO THE SERVICE TABLE --
INSERT INTO service
   VALUES (9875, 'Check up', 54.82);
INSERT INTO service
   VALUES (2348, 'Extraction', 134.08);
INSERT INTO service
   VALUES (1207, 'Filling', 109.70);
INSERT INTO service
   VALUES (1091, 'Scale and clean', 86.50);


-- INSERT VALUES INTO THE PROVIDER TYPE TABLE --
INSERT INTO provider_type
  VALUES (1, 'General Dentist');
INSERT INTO provider_type
  VALUES (2, 'Orthodontist');
INSERT INTO provider_type
  VALUES (3, 'Periodontist');
INSERT INTO provider_type
  VALUES (4, 'Prosthodontist');

-- INSERT VALUES INTO THE PROVIDER TABLE --
INSERT into provider
  VALUES ('SIM001', 'Homer', 'Simpson', NULL, 9132.88, 121000.28, 1);
INSERT into provider
  VALUES ('SIM002', 'Lisa', 'Simpson', 104, 12453.26, 138795.21, 3);
INSERT into provider
  VALUES ('BRO001', 'Kent', 'Brockman', 202, 21389.74, 215207.28, 2);
INSERT into provider
  VALUES ('CAR001', 'Carl', 'Carlson', 103 , 12765.12, 98642.95, 1);

-- INSERT VALUES INTO THE PROVIDER SERVICE TABLE -- 
INSERT INTO provider_service
  VALUES ('SIM001', 9875, 59.15);
INSERT INTO provider_service
  VALUES ('SIM001', 2348, NULL);
INSERT INTO provider_service
  VALUES ('SIM001', 1207, 156.80);
INSERT INTO provider_service
  VALUES ('SIM001', 1091, 101.40);
INSERT INTO provider_service
  VALUES ('SIM002', 9875, 62.65);
INSERT INTO provider_service
  VALUES ('SIM002', 2348, NULL);
INSERT INTO provider_service
  VALUES ('SIM002', 1207, 145.60);
INSERT INTO provider_service
  VALUES ('BRO001', 1207, NULL);
INSERT INTO provider_service
  VALUES ('BRO001', 1091, 91.20);
INSERT INTO provider_service
  VALUES ('CAR001', 9875, NULL);
INSERT INTO provider_service
  VALUES ('CAR001', 2348, 164.90);
INSERT INTO provider_service
  VALUES ('CAR001', 1091, NULL);


-- INSERT VALUES INTO THE NURSE TABLE --
INSERT INTO nurse
  VALUES (NURSE_NURSE_NUMBER_SEQ.NEXTVAL, 'Disco', 'Stu', '0419960114');
INSERT INTO nurse
  VALUES (NURSE_NURSE_NUMBER_SEQ.NEXTVAL, 'Lunchlady', 'Doris', '0419911107');
INSERT INTO nurse
  VALUES (NURSE_NURSE_NUMBER_SEQ.NEXTVAL, 'Fat', 'Tony', '0419911010');
INSERT INTO nurse
  VALUES (NURSE_NURSE_NUMBER_SEQ.NEXTVAL, 'Maude', 'Flanders', '0419901115');
  
  
-- INSERT INTO SPEC TABLE --
INSERT INTO spec
  VALUES ('ANA001', 'Local Anaesthetic');
INSERT INTO spec
  VALUES ('ANA002', 'General Anaesthetic');
INSERT INTO spec
  VALUES ('RAD001', 'Radiology');
INSERT INTO spec
  VALUES ('DIA001', 'Diagnostic - Saliva Screening');
INSERT INTO spec
  VALUES ('DIA002', 'Pulp Test');

-- INSERT INTO NURSE_SPEC LINKING TABLE --
INSERT INTO nurse_spec
  VALUES(NURSE_NURSE_NUMBER_SEQ.CURRVAL - 3, 'DIA001');
INSERT INTO nurse_spec
  VALUES(NURSE_NURSE_NUMBER_SEQ.CURRVAL - 3, 'DIA002');
INSERT INTO nurse_spec
  VALUES(NURSE_NURSE_NUMBER_SEQ.CURRVAL - 3, 'ANA001');
  INSERT INTO nurse_spec
  VALUES(NURSE_NURSE_NUMBER_SEQ.CURRVAL - 3, 'ANA002');
INSERT INTO nurse_spec
  VALUES(NURSE_NURSE_NUMBER_SEQ.CURRVAL - 2, 'RAD001');
INSERT INTO nurse_spec
  VALUES(NURSE_NURSE_NUMBER_SEQ.CURRVAL - 2, 'DIA001');
INSERT INTO nurse_spec
  VALUES(NURSE_NURSE_NUMBER_SEQ.CURRVAL - 1, 'ANA001');
INSERT INTO nurse_spec
  VALUES(NURSE_NURSE_NUMBER_SEQ.CURRVAL - 1, 'RAD001');
INSERT INTO nurse_spec
  VALUES(NURSE_NURSE_NUMBER_SEQ.CURRVAL, 'RAD001');
  
-- INSERT VALUES INTO INSURER --
INSERT INTO insurer
  VALUES ('BUP001', 'Bupa Australia', '33 Exhibition St, Melbourne VIC 3000', '134135', 0, 0);
INSERT INTO insurer
  VALUES ('AUF001', 'Australian Unity Health', '114 Albert Road. South Melbourne, VIC 3205', '132939', 0, 0);
INSERT INTO insurer
  VALUES ('NIB001', 'NIB Health', '1/356 Collins St, Melbourne VIC 3000', '1300345300', 0, 0);
INSERT INTO insurer
  VALUES ('NTF001', 'Teachers Health', '52 Bridge Rd, Richmond VIC 3121', '0384120200', 0, 0);

-- INSERT VALUES INTO THE PATIENT TABLE --
INSERT INTO patient
  VALUES (PATIENT_PATIENT_NUM_SEQ.NEXTVAL, 'Patty', 'Bouvier', TO_DATE('19/07/1973', 'dd/mm/yyyy'), '123 Evergreen Terrace, Springfield', '0419891217', 0, 0, 'BUP001');
INSERT INTO patient
  VALUES (PATIENT_PATIENT_NUM_SEQ.NEXTVAL, 'Todd', 'Flanders', TO_DATE('26/08/2006', 'dd/mm/yyyy'), '125 Evergreen Terrace, Springfield', '0414343373', 0, 0, 'AUF001');
INSERT INTO patient
  VALUES (PATIENT_PATIENT_NUM_SEQ.NEXTVAL, 'Maggie', 'Bouvier', TO_DATE('22/02/2015', 'dd/mm/yyyy'), '127 Evergreen Terrace, Springfield', '0454844234', 0, 0, 'NTF001');
INSERT INTO patient
  VALUES (PATIENT_PATIENT_NUM_SEQ.NEXTVAL, 'Gil', 'Gunderson', TO_DATE('05/01/1965', 'dd/mm/yyyy'), '129 Evergreen Terrace, Springfield', '0495389466', 0, 0, 'NTF001');

-- INSERT VALUES INTO THE APMT TABLE --
INSERT INTO APMT
  VALUES (APMT_APP_NUM_SEQ.NEXTVAL, PATIENT_PATIENT_NUM_SEQ.CURRVAL, 'BRO001', NURSE_NURSE_NUMBER_SEQ.CURRVAL - 1, TO_DATE('20/10/2016 1430', 'dd/mm/yyyy HH24:MI'), '102', 'long', NULL);
INSERT INTO APMT
  VALUES (APMT_APP_NUM_SEQ.NEXTVAL, PATIENT_PATIENT_NUM_SEQ.CURRVAL - 2, 'SIM001', NURSE_NURSE_NUMBER_SEQ.CURRVAL - 2, TO_DATE('10/07/2016 1020', 'dd/mm/yyyy HH24:MI'), '101', 'short', NULL);
INSERT INTO APMT
  VALUES (APMT_APP_NUM_SEQ.NEXTVAL, PATIENT_PATIENT_NUM_SEQ.CURRVAL - 1, 'SIM001', NURSE_NURSE_NUMBER_SEQ.CURRVAL - 3, TO_DATE('22/04/2016 1250', 'dd/mm/yyyy HH24:MI'), '102', 'short', NULL);
INSERT INTO APMT
  VALUES (APMT_APP_NUM_SEQ.NEXTVAL, PATIENT_PATIENT_NUM_SEQ.CURRVAL - 3, 'SIM002', NURSE_NURSE_NUMBER_SEQ.CURRVAL - 1, TO_DATE('28/08/2016 1615', 'dd/mm/yyyy HH24:MI'), '104', 'standard', NULL);
INSERT INTO APMT
  VALUES (APMT_APP_NUM_SEQ.NEXTVAL, PATIENT_PATIENT_NUM_SEQ.CURRVAL - 2, 'SIM002', NURSE_NURSE_NUMBER_SEQ.CURRVAL - 3, TO_DATE('11/10/2016 0910', 'dd/mm/yyyy HH24:MI'), '202', 'standard', NULL);
INSERT INTO APMT
  VALUES (APMT_APP_NUM_SEQ.NEXTVAL, PATIENT_PATIENT_NUM_SEQ.CURRVAL - 1, 'CAR001', NURSE_NURSE_NUMBER_SEQ.CURRVAL, TO_DATE('17/12/2016 1050', 'dd/mm/yyyy HH24:MI'), '201', 'long', NULL);
INSERT INTO APMT
  VALUES (APMT_APP_NUM_SEQ.NEXTVAL, PATIENT_PATIENT_NUM_SEQ.CURRVAL - 3, 'CAR001', NURSE_NURSE_NUMBER_SEQ.CURRVAL - 1, TO_DATE('18/08/2016 1325', 'dd/mm/yyyy HH24:MI'), '104', 'standard', NULL);
INSERT INTO APMT
  VALUES (APMT_APP_NUM_SEQ.NEXTVAL, PATIENT_PATIENT_NUM_SEQ.CURRVAL - 2, 'BRO001', NURSE_NURSE_NUMBER_SEQ.CURRVAL - 3, TO_DATE('06/10/2016 1520', 'dd/mm/yyyy HH24:MI'), '202', 'standard', NULL);
INSERT INTO APMT
  VALUES (APMT_APP_NUM_SEQ.NEXTVAL, PATIENT_PATIENT_NUM_SEQ.CURRVAL - 1, 'BRO001', NURSE_NURSE_NUMBER_SEQ.CURRVAL, TO_DATE('02/10/2016 1430', 'dd/mm/yyyy HH24:MI'), '201', 'long', NULL);


-- INSERT VALUES INTO THE APP_SERVICE TABLE --
INSERT INTO app_service
  VALUES (1008, 1091, (SELECT service_fee FROM provider_service, APMT where provider_service.service_code = 1091 and APMT.app_num = 1008  and provider_service.provider_code = APMT.provider_code));
INSERT INTO app_service
  VALUES (1008, 1207, 86.50);
INSERT INTO app_service
  VALUES (1006, 2348, (SELECT service_fee FROM provider_service, APMT where provider_service.service_code = 2348 and APMT.app_num = 1006  and provider_service.provider_code = APMT.provider_code));
INSERT INTO app_service
  VALUES (1006, 1207, 86.50);
INSERT INTO app_service
  VALUES (1003, 9875, (SELECT service_fee FROM provider_service, APMT where provider_service.service_code = 9875 and APMT.app_num = 1003  and provider_service.provider_code = APMT.provider_code));
INSERT INTO app_service
  VALUES (1003, 1207, (SELECT service_fee FROM provider_service, APMT where provider_service.service_code = 1207 and APMT.app_num = 1003  and provider_service.provider_code = APMT.provider_code));
INSERT INTO app_service
  VALUES (1003, 2348, 86.50);
   
-- INSERT VALUES INTO INVOICE TABLE --
INSERT INTO invoice
  VALUES(100000, 1008, 'INSURER', 106.62);
INSERT INTO invoice
  VALUES(100001, 1008, 'PATIENT', 71.08);
INSERT INTO invoice
  VALUES(100002, 1006, 'INSURER', 35.42);
INSERT INTO invoice
  VALUES(100003, 1006, 'PATIENT', 155.98);
INSERT INTO invoice
  VALUES(100004, 1003, 'INSURER', 88.43);
INSERT INTO invoice
  VALUES(100005, 1003, 'PATIENT', 106.32);
UPDATE invoice
  SET amount_paid = 206.32
  WHERE INVOICE_NUM = 100005;
UPDATE invoice
  SET amount_paid = 175.98
  WHERE INVOICE_NUM = 100003;
UPDATE invoice
  SET amount_paid = 75.42
  WHERE INVOICE_NUM = 100002;
DELETE FROM invoice
  WHERE INVOICE_NUM = 100001;
DELETE FROM invoice
  WHERE INVOICE_NUM = 100000;
INSERT INTO invoice
  VALUES(100006, 1008, 'PATIENT', 71.08);
INSERT INTO invoice
  VALUES(100007, 1008, 'INSURER', 106.62);

   

COMMIT;

spool off