CREATE OR REPLACE TRIGGER WRITE_AUDIT_TRIGGER 
BEFORE DELETE OR INSERT OR UPDATE OF AMOUNT_PAID,APP_NUM,INVOICE_NUM,PAYMENT_FROM ON INVOICE 
FOR EACH ROW 
DECLARE
   patitent_num number(4,0);

BEGIN
  IF INSERTING THEN
    SELECT patient_num INTO patitent_num FROM apmt where apmt.app_num = :NEW.app_num;

    INSERT INTO payment_audit 
    VALUES (PAYMENT_AUDIT_ENTRY_NUM_SEQ.NEXTVAL, patitent_num, :new.app_num, user, sysdate, :new.payment_from, 'INSERT');
    DBMS_OUTPUT.PUT_LINE('New row inserted into INVOICE table, log entry added to payment_audit table.');
    
  ELSE
    IF DELETING THEN
      SELECT patient_num INTO patitent_num FROM apmt where apmt.app_num = :OLD.app_num;
      
      INSERT INTO payment_audit 
        VALUES (PAYMENT_AUDIT_ENTRY_NUM_SEQ.NEXTVAL, patitent_num, :old.app_num, user, sysdate, :old.payment_from, 'DELETE');
      DBMS_OUTPUT.PUT_LINE('Row deleted from INVOICE table, log entry added to payment_audit table.');
    ELSE
      IF UPDATING THEN
         SELECT patient_num INTO patitent_num FROM apmt where apmt.app_num = :NEW.app_num;

        INSERT INTO payment_audit 
          VALUES (PAYMENT_AUDIT_ENTRY_NUM_SEQ.NEXTVAL, patitent_num, :new.app_num, user, sysdate, :new.payment_from, 'UPDATE');
        DBMS_OUTPUT.PUT_LINE('Row updated in INVOICE table, log entry added to payment_audit table.');
      END IF;
    END IF;
  END IF;
        

END;