set serveroutput on;

declare
  v_name emp.ename%type;
  e_name exception;
  
  pragma exception_init (e_name, -20999);
  v_last_name emp.ename%TYPE := 'SMIT';
begin
  select e.ename into v_name
  from emp e
  where upper(e.ename) like 'MI%';
  dbms_output.put_line(v_name);
  
  DELETE FROM emp WHERE ename = v_last_name;
  if sql%rowcount =0
    then raise_application_error(-20999,'Invalid last name');
    else dbms_output.put_line(v_last_name||' deleted');
  end if;
  
  exception
    when e_name then
      dbms_output.put_line ('Valid last names are: ');
      for c1 in (
                  select distinct ename
                  from emp
                )
      loop
         dbms_output.put_line(c1.ename);
      end loop;
    
    when no_data_found then
      dbms_output.put_line('Nu exista numele in tabela.');
    when too_many_rows then
      dbms_output.put_line('Prea multe linii.');      
END;