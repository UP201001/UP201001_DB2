--funcion
CREATE OR REPLACE FUNCTION get_RFC_F(p_parental_last_name VARCHAR2)
    return varchar2
IS
    last_name varchar2(999):= initcap(p_parental_last_name);
    rfc VARCHAR2(2);
BEGIN
    
	rfc := upper(substr(last_name,1,1)) || upper(substr(last_name, (regexp_instr(last_name, '[aeiou]')),1));
    return rfc;
END;
/
--ejecucion de funcion
select last_name, get_RFC_F(last_name) rfc from employees;
