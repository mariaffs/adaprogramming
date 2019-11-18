with Ada.Text_IO;
With Ada.Strings.Unbounded;
with BTS_Maps_G;

procedure BTS_Maps_G_Test is
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

	Value: ASU.Unbounded_String;
	Success: Boolean;
	A_Map: BTS_Maps.Map;
begin
	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);

	BTS_Maps.Put(A_Map, ASU.To_Unbounded_String("facebook.com"), 
		ASU.To_Unbounded_String("69.63.189.16"));

	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);

	ATIO.New_Line;
	BTS_Maps.Get(A_Map, ASU.To_Unbounded_String("www.urjc.es"), Value, Success);
	if Success then
		ATIO.Put_Line("Get: Dirección IP de www.urjc.es: " & ASU.To_String(Value));
	else
		ATIO.Put_Line("Get: NO hay una entrada para la clave www.urjc.es");
	end if;

	BTS_Maps.Put(A_Map, ASU.To_Unbounded_String("google.com"), 
		ASU.To_Unbounded_String("66.249.92.104"));

	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);

	BTS_Maps.Put(A_Map, ASU.To_Unbounded_String("www.urjc.es"), 
		ASU.To_Unbounded_String("212.128.240.25"));

	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);
	
	BTS_Maps.Put(A_Map, ASU.To_Unbounded_String("microsoft.com"), 
		ASU.To_Unbounded_String("40.76.4.15"));

	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);
	
	BTS_Maps.Put(A_Map, ASU.To_Unbounded_String("apple.com"), 
		ASU.To_Unbounded_String("17.172.224.47"));

	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);
	
	ATIO.New_Line(2);
	
	Cursor_Print(A_Map);

	BTS_Maps.Put(A_Map, 
		ASU.To_Unbounded_String("facebook.com"), 
		ASU.To_Unbounded_String("69.63.189.11"));

	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);

	ATIO.New_Line;
	BTS_Maps.Get (A_Map, ASU.To_Unbounded_String("www.urjc.es"), Value, Success);
	if Success then
		ATIO.Put_Line("Get: Dirección IP de www.urjc.es: " &
			ASU.To_String(Value));
	else
		ATIO.Put_Line("Get: NO hay una entrada para la clave www.urjc.es");
	end if;

	ATIO.New_Line;
	BTS_Maps.Delete(A_Map, ASU.To_Unbounded_String("google.com"), Success);
	if Success then
		ATIO.Put_Line("Delete: BORRADO google.com");
	else
		ATIO.Put_Line("Delete: google.com no encontrado");
	end if;

	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);

	ATIO.New_Line;
	BTS_Maps.Delete(A_Map, ASU.To_Unbounded_String("www.urjc.es"), Success);
	if Success then
		ATIO.Put_Line("Delete: BORRADO www.urjc.es");
	else
		ATIO.Put_Line("Delete: www.urjc.es no encontrado");
	end if;

	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);

	ATIO.New_Line;
	BTS_Maps.Delete(A_Map, ASU.To_Unbounded_String("bbb.bbb.bbb"), Success);
	if Success then
		ATIO.Put_Line("Delete: BORRADO bbb.bbb.bbb");
	else
		ATIO.Put_Line("Delete: bbb.bbb.bbb no encontrado");
	end if;

	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);
	
	ATIO.New_Line;
	BTS_Maps.Delete(A_Map, ASU.To_Unbounded_String("facebook.com"), Success);
	if Success then
		ATIO.Put_Line("Delete: BORRADO facebook.com");
	else
		ATIO.Put_Line("Delete: facebook.com no encontrado");
	end if;
	
	ATIO.New_Line;
	ATIO.Put_Line("Longitud de la tabla de símbolos: " & 
		Integer'Image(BTS_Maps.Length(A_Map)));
	BTS_Maps.Print(A_Map);
	
	ATIO.New_Line(2);
	
	Cursor_Print(A_Map);
	
	ATIO.New_Line(2);
	
	BTS_Maps.Delete(A_Map, ASU.To_Unbounded_String("apple.com"), Success);
	if Success then
		ATIO.Put_Line("Delete: BORRADO apple.com");
	else
		ATIO.Put_Line("Delete: apple.com no encontrado");
	end if;
	
	ATIO.New_Line(2);
	
	Cursor_Print(A_Map);
	
	ATIO.New_Line(2);
	
	BTS_Maps.Delete(A_Map, ASU.To_Unbounded_String("microsoft.com"), Success);
	if Success then
		ATIO.Put_Line("Delete: BORRADO microsoft.com");
	else
		ATIO.Put_Line("Delete: microsoft.com no encontrado");
	end if;
	
	ATIO.New_Line(2);
	
	Cursor_Print(A_Map);
end BTS_Maps_G_Test;
