
CREATE OR REPLACE TRIGGER trg_pet_care_log_set_info
BEFORE INSERT ON pet_care_log
FOR EACH ROW
BEGIN
    :NEW.last_update_datetime := SYSDATE;
    :NEW.created_by_user := USER;

EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Error inserting into PET_CARE_LOG: ' || SQLERRM
        );
END;
/

CREATE OR REPLACE TRIGGER trg_pet_care_log_check_update_user
BEFORE UPDATE ON pet_care_log
FOR EACH ROW
BEGIN
    IF USER <> :OLD.created_by_user THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'You can only update records that you created.'
        );
    END IF;

    :NEW.last_update_datetime := SYSDATE;
    :NEW.created_by_user := :OLD.created_by_user;

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE NOT IN (-20002) THEN
            RAISE_APPLICATION_ERROR(
                -20003,
                'Error updating PET_CARE_LOG: ' || SQLERRM
            );
        ELSE
            RAISE;
        END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_pet_care_log_manager_delete
BEFORE DELETE ON pet_care_log
FOR EACH ROW
BEGIN
    IF USER <> 'JOEMANAGER' THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'Only JOEMANAGER can delete records from PET_CARE_LOG.'
        );
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE NOT IN (-20004) THEN
            RAISE_APPLICATION_ERROR(
                -20005,
                'Error deleting from PET_CARE_LOG: ' || SQLERRM
            );
        ELSE
            RAISE;
        END IF;
END;
/