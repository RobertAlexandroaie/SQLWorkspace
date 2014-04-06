set serveroutput on;
----PROCEDURI----
create or replace package pachet_elevi as
  procedure init_list;
  procedure add_to_list (p_matricola in elevi.matricola%type, p_nume in elevi.nume%type, p_an in elevi.an%type);
  function get_count return integer;
  procedure get_from_list (p_to_get in integer, p_matricola out elevi.matricola%type, p_nume out elevi.nume%type, p_an out elevi.an%type);
end pachet_elevi;
/

create or replace package body pachet_elevi as
  v_list_index   integer;  
 
  type elevi_rec is record ( 
    matricola elevi.matricola%TYPE,
    nume  elevi.nume%type,
    an  elevi.an%type
  );
  
  type elevi_list as table of elevi_rec INDEX BY NUMBER;

  lista_elevi   elevi_list;
  
  PROCEDURE init_list is
  begin
   v_list_index := 0;
  end;
  
  PROCEDURE add_to_list (p_matricola IN elevi.matricola%TYPE, p_nume IN elevi.nume%TYPE, p_an IN elevi.an%type) IS
  BEGIN
   --increment the list index and save the primary key values.
   v_list_index := v_list_index + 1;
   lista_elevi(v_list_index).matricola := p_matricola;
   lista_elevi(v_list_index).nume := p_nume;
   lista_elevi(v_list_index).an := p_an;
  END;
  
  FUNCTION get_count RETURN integer IS
  BEGIN
   --return the integer of entries in the list.
   RETURN v_list_index;
  END;
  
  PROCEDURE get_from_list (p_to_get IN integer, p_matricola OUT elevi.matricola%TYPE, p_nume OUT elevi.nume%TYPE, p_an OUT elevi.an%TYPE) IS
  begin
   p_matricola := lista_elevi(p_to_get).matricola;
   p_nume := lista_elevi(p_to_get).nume;
   p_an := lista_elevi(p_to_get).an;
  END;
END pachet_elevi;
/
--------END pachet-------------

---------TRIGGERE-----------------
CREATE OR REPLACE TRIGGER trigger1
before update on elevi
begin
  pachet_elevi.init_list;
end;
/
 
create or replace trigger trigger2
BEFORE UPDATE ON elevi
FOR EACH ROW
begin
  pachet_elevi.add_to_list(:NEW.matricola, :NEW.nume, :NEW.an);
END;
/

create or replace trigger trigger3
after update on elevi
declare
  v_matricola elevi.matricola%type;
  v_nume  elevi.nume%type;
  v_an  elevi.an%type;
  v_list_index  integer;
  v_list_size  integer;  
  v_count_elevi  integer;
  
begin
  v_list_size := pachet_elevi.get_count;
  
  for v_list_index in 1..v_list_size 
  loop
    pachet_elevi.get_from_list(v_list_index, v_matricola, v_nume, v_an);
  
    select count(*) into v_count_elevi
    from elevi
    where an like v_an;
    
    if v_count_elevi < 10 then
       RAISE_APPLICATION_ERROR(-20000,'Nu aveti voie sa modificati anul acestui elev!');
    end if;
    
  end loop;
end;
 /