set SERVEROUTPUT on;
--procedimiento
CREATE OR REPLACE PROCEDURE get_RFC_P(p_parental_last_name VARCHAR2)
IS
    last_name varchar2(100):= initcap(p_parental_last_name);
    --first_letter VARCHAR2(1);
    --second_letter VARCHAR2(1);
    rfc VARCHAR2(2);
BEGIN
    --first_letter := upper(substr(last_name,1,1));
    --second_letter := upper(substr(last_name,  (regexp_instr(last_name, '[aeiou]') ),1));
    rfc := upper(substr(last_name,1,1)) || upper(substr(last_name, (regexp_instr(last_name, '[aeiou]')),1));
    dbms_output.put_line('The RFC from last name ' || upper(last_name) || ' is: ' || rfc);
    --dbms_output.put_line(rfc);
END;
/
--llamada del procedimiento
call get_rfc_P('agUIleRA');