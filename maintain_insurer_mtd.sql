create or replace TRIGGER MAINTAIN_INSURER_MTD 
BEFORE DELETE OR INSERT OR UPDATE OF AMOUNT_PAID,APP_NUM,INVOICE_NUM,PAYMENT_FROM ON INVOICE 
FOR EACH ROW 
DECLARE
   var_patient_num number(4,0);
   var_insurer_code varchar(6);
   
BEGIN
  IF INSERTING AND :NEW.payment_from = 'INSURER' THEN
    SELECT patient_num INTO var_patient_num FROM apmt where apmt.app_num = :NEW.app_num;
    SELECT insurer_code INTO var_insurer_code FROM patient where patient.patient_num = var_patient_num;
    UPDATE INSURER
      SET insurer_mtd = insurer_mtd + :new.amount_paid
      WHERE INSURER.insurer_code = var_insurer_code;
    DBMS_OUTPUT.PUT_LINE('New row with INSURER as payer inserted to invoice table, '||:new.amount_paid||' added to '||var_insurer_code);
    UPDATE PATIENT
      SET insurer_mtd = insurer_mtd + :new.amount_paid
      WHERE PATIENT.patient_num = var_patient_num;
    
    ELSE IF DELETING AND :OLD.payment_from = 'INSURER' THEN
      SELECT patient_num INTO var_patient_num FROM apmt where apmt.app_num = :OLD.app_num;
      SELECT insurer_code INTO var_insurer_code FROM patient where patient.patient_num = var_patient_num;
      UPDATE INSURER
        SET insurer_mtd = insurer_mtd - :OLD.amount_paid
        WHERE INSURER.insurer_code = var_insurer_code;
      DBMS_OUTPUT.PUT_LINE('Row with INSURER as payer deleted from invoice table, '||:old.amount_paid||' subtracted from '||var_insurer_code);
      
      UPDATE PATIENT
        SET insurer_mtd = insurer_mtd - :OLD.amount_paid
        WHERE PATIENT.patient_num = var_patient_num;
   
      -- Updating is broken into two IF statements for the case when an update changes the payment from value between PAITENT and INSURER --
      ELSE IF UPDATING THEN
        IF :NEW.payment_from = 'INSURER' THEN
          SELECT patient_num INTO var_patient_num FROM apmt where apmt.app_num = :OLD.app_num;
          SELECT insurer_code INTO var_insurer_code FROM patient where patient.patient_num = var_patient_num;
          UPDATE INSURER
            SET insurer_mtd = insurer_mtd + :NEW.amount_paid
            WHERE INSURER.insurer_code = var_insurer_code;
            DBMS_OUTPUT.PUT_LINE('Update made to row with (new:) payer as INSURER in invoice table, '||:new.amount_paid||' added to '||var_insurer_code);
          UPDATE PATIENT
            SET insurer_mtd = insurer_mtd + :NEW.amount_paid
            WHERE PATIENT.patient_num = var_patient_num;
        END IF;
        IF :OLD.payment_from = 'INSURER' THEN
            SELECT patient_num INTO var_patient_num FROM apmt where apmt.app_num = :OLD.app_num;
            SELECT insurer_code INTO var_insurer_code FROM patient where patient.patient_num = var_patient_num;
            UPDATE INSURER
              SET insurer_mtd = insurer_mtd - :OLD.amount_paid
              WHERE INSURER.insurer_code = var_insurer_code;
            DBMS_OUTPUT.PUT_LINE('Update made to row with (old:) payer as INSURER in invoice table, '||:old.amount_paid||' subtracted from '||var_insurer_code);

            UPDATE PATIENT
              SET insurer_mtd = insurer_mtd - :OLD.amount_paid
              WHERE PATIENT.patient_num = var_patient_num;
          END IF;
        END IF;      
      END IF;

  
  END IF;

END;