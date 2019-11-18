with Ada.Text_IO;
With Ada.Strings.Unbounded;
with BTS_Maps_G;

procedure BTS_Maps_G_Test_V2 is
	package ATIO renames Ada.Text_IO;
	package ASU renames Ada.Strings.Unbounded;

	package BTS_Maps is new BTS_Maps_G(Key_Type => ASU.Unbounded_String, 
		Value_Type => ASU.Unbounded_String, 
		"=" => ASU."=", 
		"<" => ASU."<", 
		">" => ASU.">", 
		Key_To_String => ASU.To_String, 
		Value_To_String => ASU.To_String);
		
	procedure Cursor_Print(M: BTS_Maps.Map) is
		C: BTS_Maps.Cursor := BTS_Maps.First(M);
	begin
		ATIO.Put_Line("Cursor_Print");
		ATIO.Put_Line("============");

		while BTS_Maps.Has_Element(C) loop
			ATIO.Put_Line(ASU.To_String(BTS_Maps.Element(C).Key) & " " & 
				ASU.To_String(BTS_Maps.Element(C).Value));
			BTS_Maps.Next(C);
		end loop;
		ATIO.Put_Line("============");
	end Cursor_Print;

	C: Character;
	Key: ASU.Unbounded_String;
	Value: ASU.Unbounded_String;
	A_Map: BTS_Maps.Map;
begin
	loop
		ATIO.Put("¿Quieres insertar una pareja clave-valor? (y/n)");
		ATIO.Get_Immediate(C);
		ATIO.New_Line;
		if C = 'Y' or C = 'y'  then
			ATIO.Put("Clave: ");
			Key := ASU.To_Unbounded_String(ATIO.Get_Line);
			ATIO.Put("Valor: ");
			Value := ASU.To_Unbounded_String(ATIO.Get_Line);
			BTS_Maps.Put(A_Map, Key, Value);
			
			ATIO.New_Line;
			
			BTS_Maps.Print(A_Map);
		elsif C = 'N' or C = 'n' then
			ATIO.Put_Line("¡Hasta la próxima!");
		else
			ATIO.Put_Line("ERROR: Debes introducir Y/y/N/n");
		end if;
		ATIO.New_Line;
	exit when C = 'N' or C = 'n';
	end loop;
	
	ATIO.New_Line;
	
	Cursor_Print(A_Map);
end BTS_Maps_G_Test_V2;
