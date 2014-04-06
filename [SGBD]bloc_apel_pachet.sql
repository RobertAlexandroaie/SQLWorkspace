declare
  v_job emp.job%type;
  v_empno emp.empno%type;
  
  cursor cursor_job is
    select job
    from emp;
    
  cursor fetch_cursor(p_job) is
    package1.fetch_emps(p_job);
    
begin
  open cursor_job;
  loop
    fetch cursor_job into v_job;
    
    open fetch_cursor(v_job);
    loop
      fetch 
    end loop;
    
    exit when cursor_job%notfound;
  end loop;
  close cursor_job;
end;