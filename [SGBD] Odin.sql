/*
	The foreign key in table pontaje is defined with "ON DELETE CASCADE"
	to not complicate the solution; a supplemental index by table could
	be used to keep the child records from pontaje
*/

CREATE OR REPLACE PACKAGE emp_pack
AS
	PROCEDURE Init;
	PROCEDURE Add_to_List( p_coda NUMBER, p_sal NUMBER, p_codd NUMBER );
	PROCEDURE Get_from_List( 
		p_ind NUMBER, p_coda OUT NUMBER, p_sal OUT NUMBER, p_codd OUT NUMBER );
	FUNCTION Get_Number_of RETURN NUMBER;
	FUNCTION Code_in( p_coda NUMBER ) RETURN BOOLEAN;
END emp_pack;
/