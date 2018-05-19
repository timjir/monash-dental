-- Generated by Oracle SQL Developer Data Modeler 4.1.3.901
--   at:        2016-10-21 14:30:52 AEDT
--   by:        tric0003
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g

spool ./FIT9132Output.txt

DROP SEQUENCE APMT_APP_NUM_SEQ;

DROP SEQUENCE INVOICE_INVOICE_NUM_SEQ;

DROP SEQUENCE NURSE_NURSE_NUMBER_SEQ;

DROP SEQUENCE PATIENT_PATIENT_NUM_SEQ;

DROP SEQUENCE PAYMENT_AUDIT_ENTRY_NUM_SEQ;

DROP
  TABLE APMT CASCADE CONSTRAINTS ;

DROP
  TABLE APP_SERVICE CASCADE CONSTRAINTS ;

DROP
  TABLE INSURER CASCADE CONSTRAINTS ;

DROP
  TABLE INVOICE CASCADE CONSTRAINTS ;

DROP
  TABLE NURSE CASCADE CONSTRAINTS ;

DROP
  TABLE NURSE_SPEC CASCADE CONSTRAINTS ;

DROP
  TABLE PATIENT CASCADE CONSTRAINTS ;

DROP
  TABLE PAYMENT_AUDIT CASCADE CONSTRAINTS ;

DROP
  TABLE PROVIDER CASCADE CONSTRAINTS ;

DROP
  TABLE PROVIDER_SERVICE CASCADE CONSTRAINTS ;

DROP
  TABLE PROVIDER_TYPE CASCADE CONSTRAINTS ;

DROP
  TABLE SERVICE CASCADE CONSTRAINTS ;

DROP
  TABLE SPEC CASCADE CONSTRAINTS ;

CREATE
  TABLE APMT
  (
    APP_NUM       NUMBER (4) NOT NULL ,
    PATIENT_NUM   NUMBER (4) NOT NULL ,
    PROVIDER_CODE VARCHAR2 (6) NOT NULL ,
    NURSE_NUMBER  NUMBER (4) NOT NULL ,
    APP_DATETIME  DATE NOT NULL ,
    APP_ROOM      NUMBER (3) NOT NULL ,
    APP_LEN       VARCHAR2 (10) NOT NULL ,
    FOLLOW_UP_APP NUMBER (4)
  ) ;
ALTER TABLE APMT ADD CHECK ( APP_ROOM                         IN (101, 102, 103, 104, 105, 201, 202)) ;
ALTER TABLE APMT ADD CONSTRAINT CHECK_APP_LEN CHECK ( APP_LEN IN ('long',
'short', 'standard')) ;
COMMENT ON COLUMN APMT.APP_NUM
IS
  'Appointment number. 4 digit number. Primary key for the APPOINTMENT table.'
  ;
  COMMENT ON COLUMN APMT.PATIENT_NUM
IS
  'Patient number. 4 digit number. Primary key for PATIENT table. Auto increment from 1000.'
  ;
  COMMENT ON COLUMN APMT.PROVIDER_CODE
IS
  '6 character code to uniquely identify the provider, made up of 3 letters followed by 3 numbers.'
  ;
  COMMENT ON COLUMN APMT.NURSE_NUMBER
IS
  'Nurse number. 4 digit number. Primary key for NURSE table.' ;
  COMMENT ON COLUMN APMT.APP_DATETIME
IS
  'Appointment date and time. Cannot be NULL.' ;
  COMMENT ON COLUMN APMT.APP_ROOM
IS
  'Room number for the appointment. 3 digit. Cannot be Null. Constrained to rooms at the surgery.'
  ;
  COMMENT ON COLUMN APMT.APP_LEN
IS
  'Appointment length. 10 character limit. Cannot be NULL. Constrained to short, standard or long.'
  ;
  COMMENT ON COLUMN APMT.FOLLOW_UP_APP
IS
  'Appointment number. 4 digit number. Primary key for the APPOINTMENT table.'
  ;
CREATE UNIQUE INDEX APPOINTMENT__IDX ON APMT ( FOLLOW_UP_APP ASC ) ;
ALTER TABLE APMT ADD CONSTRAINT APPOINTMENT_PK PRIMARY KEY ( APP_NUM ) ;


CREATE
  TABLE APP_SERVICE
  (
    APP_NUM      NUMBER (4) NOT NULL ,
    SERVICE_CODE NUMBER (4) NOT NULL ,
    CHARGED_FEE  NUMBER (7,2) NOT NULL
  ) ;
COMMENT ON COLUMN APP_SERVICE.APP_NUM
IS
  'Appointment number. 4 digit number. Primary key for the APPOINTMENT table.'
  ;
  COMMENT ON COLUMN APP_SERVICE.SERVICE_CODE
IS
  '4 digit code - code is only made of numbers so numeric value chosen. Primary key for SERVICE table'
  ;
  COMMENT ON COLUMN APP_SERVICE.CHARGED_FEE
IS
  'Fee charged for the service. 7 digit number with 2 decimal places. Cannot be NULL.'
  ;
ALTER TABLE APP_SERVICE ADD CONSTRAINT APPOINTMENT_SERVICE_PK PRIMARY KEY (
SERVICE_CODE, APP_NUM ) ;


CREATE
  TABLE INSURER
  (
    INSURER_CODE    VARCHAR2 (6) NOT NULL ,
    INSURER_NAME    VARCHAR2 (100.) NOT NULL ,
    INSURER_ADDRESS VARCHAR2 (150) NOT NULL ,
    INSURER_PHONE   VARCHAR2 (15) NOT NULL ,
    INSURER_MTD     NUMBER (9,2) ,
    INSURER_YTD     NUMBER (9,2)
  ) ;
ALTER TABLE INSURER ADD CONSTRAINT CHECK_INSURER_CODE CHECK ( REGEXP_LIKE(
INSURER_CODE,'[[:alpha:]]{3}[[:digit:]]{3}')) ;
COMMENT ON COLUMN INSURER.INSURER_CODE
IS
  'Insurer code. 5 character code. Primary key for the INSURER table.' ;
  COMMENT ON COLUMN INSURER.INSURER_NAME
IS
  'Insurer name. 100 character limit. Cannot be NULL.' ;
  COMMENT ON COLUMN INSURER.INSURER_ADDRESS
IS
  'Insurer address. 150 character limit. Cannot be NULL.' ;
  COMMENT ON COLUMN INSURER.INSURER_PHONE
IS
  'Insurance company phone contact. 15 character limit. Cannot be NULL.' ;
  COMMENT ON COLUMN INSURER.INSURER_MTD
IS
  'Payments made by the insurance company month to date. 9 digit number with 2 decimal places. Can be NULL.'
  ;
  COMMENT ON COLUMN INSURER.INSURER_YTD
IS
  'Payments made by the insurance company year to date. 9 digit number with 2 decimal places. Can be NULL.'
  ;
ALTER TABLE INSURER ADD CONSTRAINT INSURER_PK PRIMARY KEY ( INSURER_CODE ) ;


CREATE
  TABLE INVOICE
  (
    INVOICE_NUM  NUMBER (6) NOT NULL ,
    APP_NUM      NUMBER (4) NOT NULL ,
    PAYMENT_FROM VARCHAR2 (10) NOT NULL ,
    AMOUNT_PAID  NUMBER (7,2) NOT NULL
  ) ;
ALTER TABLE INVOICE ADD CONSTRAINT CHEC_INVOICE_NUMBER CHECK ( INVOICE_NUM
BETWEEN 10000 AND 999999) ;
ALTER TABLE INVOICE ADD CONSTRAINT CHECK_PAYMENT_FROM CHECK ( PAYMENT_FROM IN (
'INSURER', 'PATIENT')) ;
COMMENT ON COLUMN INVOICE.INVOICE_NUM
IS
  '6 digit invoice number. Primary key for INVOICE table.' ;
  COMMENT ON COLUMN INVOICE.APP_NUM
IS
  'Appointment number. 4 digit number. Primary key for the APPOINTMENT table.'
  ;
  COMMENT ON COLUMN INVOICE.PAYMENT_FROM
IS
  'Payment from insurer or patient. Cannot be NULL. Constrained to patient or insurer..'
  ;
  COMMENT ON COLUMN INVOICE.AMOUNT_PAID
IS
  'Amount paid. 7 digit number. Canno tbe NULL.' ;
ALTER TABLE INVOICE ADD CONSTRAINT INVOICE_PK PRIMARY KEY ( INVOICE_NUM ) ;


CREATE
  TABLE NURSE
  (
    NURSE_NUMBER   NUMBER (4) NOT NULL ,
    NURSE_FNAME    VARCHAR2 (50) NOT NULL ,
    "NURSE_LNAME." VARCHAR2 (50) NOT NULL ,
    NURSE_PHONE    VARCHAR2 (15) NOT NULL
  ) ;
COMMENT ON COLUMN NURSE.NURSE_NUMBER
IS
  'Nurse number. 4 digit number. Primary key for NURSE table.' ;
  COMMENT ON COLUMN NURSE.NURSE_FNAME
IS
  'Nurse first name. 50 character limit. Cannot be NULL.' ;
  COMMENT ON COLUMN NURSE."NURSE_LNAME."
IS
  'Nurse last  name. 50 character limit. Cannot be NULL.' ;
  COMMENT ON COLUMN NURSE.NURSE_PHONE
IS
  'Nurse contact phone number. 15 character limit. Cannot be NULL.' ;
ALTER TABLE NURSE ADD CONSTRAINT NURSE_PK PRIMARY KEY ( NURSE_NUMBER ) ;


CREATE
  TABLE NURSE_SPEC
  (
    NURSE_NUMBER NUMBER (4) NOT NULL ,
    SPEC_CODE    VARCHAR2 (6) NOT NULL
  ) ;
COMMENT ON COLUMN NURSE_SPEC.NURSE_NUMBER
IS
  'Nurse number. 4 digit number. Primary key for NURSE table.' ;
  COMMENT ON COLUMN NURSE_SPEC.SPEC_CODE
IS
  'Nurse specialisation code.6 charcter code three letters followed by three numbers ABC123. Primary key for SPECIALISATION table.'
  ;
ALTER TABLE NURSE_SPEC ADD CONSTRAINT NURSE_SPECIALISATION_PK PRIMARY KEY (
NURSE_NUMBER, SPEC_CODE ) ;


CREATE
  TABLE PATIENT
  (
    PATIENT_NUM  NUMBER (4) NOT NULL ,
    PAT_FNAME    VARCHAR2 (50) NOT NULL ,
    PAT_LNAME    VARCHAR2 (50) NOT NULL ,
    PAT_DOB      DATE NOT NULL ,
    PAT_ADDRESS  VARCHAR2 (150) NOT NULL ,
    PAT_PHONE    VARCHAR2 (15) NOT NULL ,
    INSURER_MTD  NUMBER (9,2) ,
    INSURER_YTD  NUMBER (9,2) ,
    INSURER_CODE VARCHAR2 (6)
  ) ;
COMMENT ON COLUMN PATIENT.PATIENT_NUM
IS
  'Patient number. 4 digit number. Primary key for PATIENT table. Auto increment from 1000.'
  ;
  COMMENT ON COLUMN PATIENT.PAT_FNAME
IS
  'Patient first name. 50 Character limit. Cannot be NULL.' ;
  COMMENT ON COLUMN PATIENT.PAT_LNAME
IS
  'Patient last name. 50 character limit. Cannot be NULL.' ;
  COMMENT ON COLUMN PATIENT.PAT_DOB
IS
  'Patients date of birth. Cannot be NULL.' ;
  COMMENT ON COLUMN PATIENT.PAT_ADDRESS
IS
  'Patient address. Canno tbe NULL. 150 character limit.' ;
  COMMENT ON COLUMN PATIENT.PAT_PHONE
IS
  'Patients contact phone number. 15 character limit. Cannot be NULL.' ;
  COMMENT ON COLUMN PATIENT.INSURER_MTD
IS
  'Insurance payment month to date for the patient. 9 digit number, two decimal places. Can be NULL.'
  ;
  COMMENT ON COLUMN PATIENT.INSURER_YTD
IS
  'Insurance payments year to date for the patient. 9 digit number with 2 decimal places. Can be NULL.'
  ;
  COMMENT ON COLUMN PATIENT.INSURER_CODE
IS
  'Insurer code. 5 character code. Primary key for the INSURER table.' ;
ALTER TABLE PATIENT ADD CONSTRAINT PATIENT_PK PRIMARY KEY ( PATIENT_NUM ) ;


CREATE
  TABLE PAYMENT_AUDIT
  (
    ENTRY_NUM    NUMBER (9) NOT NULL ,
    PAT_NUM      NUMBER (6) NOT NULL ,
    APP_NUM      NUMBER (4) NOT NULL ,
    "USER"       VARCHAR2 (20) NOT NULL ,
    LOG_DATETIME DATE NOT NULL ,
    PAYMENT_FROM VARCHAR2 (10) NOT NULL ,
    ACTION       VARCHAR2 (10) NOT NULL
  ) ;
ALTER TABLE PAYMENT_AUDIT ADD CHECK ( ACTION IN ('DELETE', 'INSERT', 'UPDATE'))
;
COMMENT ON COLUMN PAYMENT_AUDIT.ENTRY_NUM
IS
  'Audit entry number. 9 digit number. Primary key for AUDIT table.' ;
  COMMENT ON COLUMN PAYMENT_AUDIT.PAT_NUM
IS
  'Patient number. 5 dgit number. Cannot be NULL.' ;
  COMMENT ON COLUMN PAYMENT_AUDIT.APP_NUM
IS
  'Appointment number. 5 digit number. Cannot be NULL.' ;
  COMMENT ON COLUMN PAYMENT_AUDIT."USER"
IS
  'Logged in Oracle user at the time payment was made. Cannot be NULL.' ;
  COMMENT ON COLUMN PAYMENT_AUDIT.LOG_DATETIME
IS
  'Date and time for the log entry. Cannot be NULL.' ;
  COMMENT ON COLUMN PAYMENT_AUDIT.PAYMENT_FROM
IS
  'Origin of payent, either from PATIENT or INSURER. Cannot be NULL.' ;
  COMMENT ON COLUMN PAYMENT_AUDIT.ACTION
IS
  'Record if the change was an insert, update or delete.' ;
ALTER TABLE PAYMENT_AUDIT ADD CONSTRAINT AUDIT_PK PRIMARY KEY ( ENTRY_NUM ) ;


CREATE
  TABLE PROVIDER
  (
    PROVIDER_CODE    VARCHAR2 (6) NOT NULL ,
    PROVIDER_FNAME   VARCHAR2 (50) NOT NULL ,
    PROVIDER_LNAME   VARCHAR2 (50) NOT NULL ,
    ROOM_NUM         NUMBER (3) ,
    CHARGE_MTD       NUMBER (7,2) ,
    CHARGE_YTD       NUMBER (9,2) ,
    PROVIDER_TYPE_ID NUMBER (5) NOT NULL
  ) ;
ALTER TABLE PROVIDER ADD CONSTRAINT CHECK_PROVIDER_CODE CHECK ( REGEXP_LIKE(
PROVIDER_CODE,'[[:alpha:]]{3}[[:digit:]]{3}')) ;
ALTER TABLE PROVIDER ADD CONSTRAINT CHECK_ROOM_NUMBER CHECK ( ROOM_NUM IN (101,
102, 103, 104, 201, 202)) ;
COMMENT ON COLUMN PROVIDER.PROVIDER_CODE
IS
  '6 character code to uniquely identify the provider, made up of 3 letters followed by 3 numbers.'
  ;
  COMMENT ON COLUMN PROVIDER.PROVIDER_FNAME
IS
  'Providers first name (50 character limit). Cannot be null.' ;
  COMMENT ON COLUMN PROVIDER.PROVIDER_LNAME
IS
  'Providers last name, 50 character limit. Cannot be null.' ;
  COMMENT ON COLUMN PROVIDER.ROOM_NUM
IS
  '3 digit number for the normal room of the provider. Is not mandantory. Constrained to rooms at surgery.'
  ;
  COMMENT ON COLUMN PROVIDER.CHARGE_MTD
IS
  '7 digit number (2 decimals). Total charges of the provider for the current month. '
  ;
  COMMENT ON COLUMN PROVIDER.CHARGE_YTD
IS
  'Total provider charges for the year to date. 9 digit number (2 decimal places).'
  ;
  COMMENT ON COLUMN PROVIDER.PROVIDER_TYPE_ID
IS
  'Provider type code. 2 digit number. Primary key for PROVIDER TYPE.' ;
ALTER TABLE PROVIDER ADD CONSTRAINT PROVIDER_PK PRIMARY KEY ( PROVIDER_CODE ) ;


CREATE
  TABLE PROVIDER_SERVICE
  (
    PROVIDER_CODE VARCHAR2 (6) NOT NULL ,
    SERVICE_CODE  NUMBER (4) NOT NULL ,
    SERVICE_FEE   NUMBER (7,2)
  ) ;
COMMENT ON COLUMN PROVIDER_SERVICE.PROVIDER_CODE
IS
  '6 character code to uniquely identify the provider, made up of 3 letters followed by 3 numbers.'
  ;
  COMMENT ON COLUMN PROVIDER_SERVICE.SERVICE_CODE
IS
  '4 digit code - code is only made of numbers so numeric value chosen. Primary key for SERVICE table'
  ;
  COMMENT ON COLUMN PROVIDER_SERVICE.SERVICE_FEE
IS
  'Fee specific for the service provider combination. 7 digit number with 2 decimal places. Can be NULL.'
  ;
ALTER TABLE PROVIDER_SERVICE ADD CONSTRAINT PROVIDER_SERVICE_PK PRIMARY KEY (
SERVICE_CODE, PROVIDER_CODE ) ;


CREATE
  TABLE PROVIDER_TYPE
  (
    PROVIDER_TYPE_ID   NUMBER (5) NOT NULL ,
    PROVIDER_TYPE_NAME VARCHAR2 (50) NOT NULL
  ) ;
COMMENT ON COLUMN PROVIDER_TYPE.PROVIDER_TYPE_ID
IS
  'Provider type code. 2 digit number. Primary key for PROVIDER TYPE.' ;
  COMMENT ON COLUMN PROVIDER_TYPE.PROVIDER_TYPE_NAME
IS
  'Provider type name. 50 character limite. Cannot be NULL.' ;
ALTER TABLE PROVIDER_TYPE ADD CONSTRAINT PROVIDER_TYPE_PK PRIMARY KEY (
PROVIDER_TYPE_ID ) ;


CREATE
  TABLE SERVICE
  (
    SERVICE_CODE NUMBER (4) NOT NULL ,
    SERVICE_DESC VARCHAR2 (50) NOT NULL ,
    STD_FEE      NUMBER (7,2) NOT NULL
  ) ;
ALTER TABLE SERVICE ADD CONSTRAINT CHECK_SERVICE_CODE CHECK ( SERVICE_CODE
BETWEEN 1000 AND 9999) ;
COMMENT ON COLUMN SERVICE.SERVICE_CODE
IS
  '4 digit code - code is only made of numbers so numeric value chosen. Primary key for SERVICE table'
  ;
  COMMENT ON COLUMN SERVICE.SERVICE_DESC
IS
  'Description of the service. 50 character limit. Cannot be NULL.' ;
  COMMENT ON COLUMN SERVICE.STD_FEE
IS
  'Standard fee charged for the service. 7 digit number with 2 decimal places. Cannot be NULL.'
  ;
ALTER TABLE SERVICE ADD CONSTRAINT SERVICE_PK PRIMARY KEY ( SERVICE_CODE ) ;


CREATE
  TABLE SPEC
  (
    SPEC_CODE VARCHAR2 (6) NOT NULL ,
    SPEC_DESC VARCHAR2 (50) NOT NULL
  ) ;
ALTER TABLE SPEC ADD CONSTRAINT CHECK_SPEC_CODE CHECK ( REGEXP_LIKE(SPEC_CODE,
'[[:alpha:]]{3}[[:digit:]]{3}')) ;
COMMENT ON COLUMN SPEC.SPEC_CODE
IS
  'Nurse specialisation code.6 charcter code three letters followed by three numbers ABC123. Primary key for SPECIALISATION table.'
  ;
  COMMENT ON COLUMN SPEC.SPEC_DESC
IS
  'Specialisation description. 50 character limit. Cannot be NULL.' ;
ALTER TABLE SPEC ADD CONSTRAINT SPECIALISATION_PK PRIMARY KEY ( SPEC_CODE ) ;


ALTER TABLE APMT ADD CONSTRAINT RELATION_13 FOREIGN KEY ( FOLLOW_UP_APP )
REFERENCES APMT ( APP_NUM ) ;

ALTER TABLE APP_SERVICE ADD CONSTRAINT APMT_APP_SERVICE FOREIGN KEY ( APP_NUM )
REFERENCES APMT ( APP_NUM ) ;

ALTER TABLE INVOICE ADD CONSTRAINT APPOINTMENT_INVOICE FOREIGN KEY ( APP_NUM )
REFERENCES APMT ( APP_NUM ) ;

ALTER TABLE PATIENT ADD CONSTRAINT INSURER_PATIENT FOREIGN KEY ( INSURER_CODE )
REFERENCES INSURER ( INSURER_CODE ) ;

ALTER TABLE APMT ADD CONSTRAINT NURSE_APPOINTMENT FOREIGN KEY ( NURSE_NUMBER )
REFERENCES NURSE ( NURSE_NUMBER ) ;

ALTER TABLE NURSE_SPEC ADD CONSTRAINT NURSE_NURSE_SPECIALISATION FOREIGN KEY (
NURSE_NUMBER ) REFERENCES NURSE ( NURSE_NUMBER ) ;

ALTER TABLE APMT ADD CONSTRAINT PATIENT_APPOINTMENT FOREIGN KEY ( PATIENT_NUM )
REFERENCES PATIENT ( PATIENT_NUM ) ;

ALTER TABLE PROVIDER_SERVICE ADD CONSTRAINT PROVDER_PROVIDER_SERVICE FOREIGN
KEY ( PROVIDER_CODE ) REFERENCES PROVIDER ( PROVIDER_CODE ) ;

ALTER TABLE APMT ADD CONSTRAINT PROVIDER_APP FOREIGN KEY ( PROVIDER_CODE )
REFERENCES PROVIDER ( PROVIDER_CODE ) ;

ALTER TABLE PROVIDER ADD CONSTRAINT PROVIDER_PROVIDER_TYPE FOREIGN KEY (
PROVIDER_TYPE_ID ) REFERENCES PROVIDER_TYPE ( PROVIDER_TYPE_ID ) ;

ALTER TABLE APP_SERVICE ADD CONSTRAINT SERVICE_APP_SERVICE FOREIGN KEY (
SERVICE_CODE ) REFERENCES SERVICE ( SERVICE_CODE ) ;

ALTER TABLE PROVIDER_SERVICE ADD CONSTRAINT SERVICE_PROVIDER_SERVICE FOREIGN
KEY ( SERVICE_CODE ) REFERENCES SERVICE ( SERVICE_CODE ) ;

ALTER TABLE NURSE_SPEC ADD CONSTRAINT SPEC_NURSE_SPEC FOREIGN KEY ( SPEC_CODE )
REFERENCES SPEC ( SPEC_CODE ) ;

CREATE SEQUENCE APMT_APP_NUM_SEQ START WITH 1000 NOCACHE ORDER ;

CREATE SEQUENCE INVOICE_INVOICE_NUM_SEQ START WITH 100000 NOCACHE ORDER ;

CREATE SEQUENCE NURSE_NURSE_NUMBER_SEQ START WITH 1000 NOCACHE ORDER ;

CREATE SEQUENCE PATIENT_PATIENT_NUM_SEQ START WITH 1000 NOCACHE ORDER ;

CREATE SEQUENCE PAYMENT_AUDIT_ENTRY_NUM_SEQ START WITH 100000000 NOCACHE ORDER
  ;


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             1
-- ALTER TABLE                             36
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          5
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

spool off