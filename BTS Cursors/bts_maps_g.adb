with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body BTS_Maps_G is
	package ATIO renames Ada.Text_IO;

	procedure Get(M: Map; 
		Key: in Key_Type; 
		Value: out Value_Type; 
		Success: out Boolean) is
	begin
		if M = null then
			Success := False;
		elsif Key = M.Key then
			Value := M.Value;
			Success := True;
		elsif Key > M.Key then
			Get(M.Right, Key, Value, Success);
		else
			Get(M.Left, Key, Value, Success);
		end if;
	end Get;
	
	procedure Put_Aux(M: in out Map; 
		Key: in Key_Type; 
		Value: in Value_Type; 
		Up: in Map) is
	begin
		if M = null then
			M := new Tree_Node'(Up, Key, Value, null, null);
		elsif Key = M.Key then
			M.Value := Value;
		elsif Key > M.Key then
			Put_Aux(M.Right, Key, Value, M);
		else
			Put_Aux(M.Left, Key, Value, M);
		end if;
	end Put_Aux;

	procedure Put(M: in out Map; 
		Key: in Key_Type; 
		Value: in Value_Type) is
	begin
		Put_Aux(M, Key, Value, null);
	end Put;

	procedure Min(M: in Map; 
		Key: out Key_Type; 
		Value: out Value_Type; 
		Success: out Boolean) is
	begin
		if M = null then
			Success := False;
		else
			if M.Left = null then
				Success := True;
				Key := M.Key;
				Value := M.Value;
			else
				Min(M.Left, Key, Value, Success);
			end if;
		end if;
	end Min;
	
	procedure Max(M: in Map; 
		Key: out Key_Type; 
		Value: out Value_Type; 
		Success: out Boolean) is
	begin
		if M = null then
			Success := False;
		else
			if M.Right = null then
				Success := True;
				Key := M.Key;
				Value := M.Value;
			else
				Max(M.Right, Key, Value, Success);
			end if;
		end if;
	end Max;
	
	procedure Free is new Ada.Unchecked_Deallocation(Tree_Node, Map);
	
	procedure Delete(M: in out Map; 
		Key: in Key_Type; 
		Success: out Boolean) is
		P_Aux: Map;
		Min_Key: Key_Type;
		Min_Value: Value_Type;
		Min_Success: Boolean;
	begin
		if M = null then
			Success := False;
		elsif Key = M.Key then
			Success := True;
			if M.Left = null then
				if M.Right /= null then
					M.Right.Up := M.Up;
				end if;
				P_Aux := M.Right;
				Free(M);
				M := P_Aux;
			elsif M.Right = null then
				M.Left.Up := M.Up;
				P_Aux := M.Left;
				Free(M);
				M := P_Aux;
			else
				Min(M.Right, Min_Key, Min_Value, Min_Success);
				if Min_Success then
					M.Key := Min_Key;
					M.Value := Min_Value;
					Delete(M.Right, Min_Key, Success);
				end if;
			end if;
		elsif Key > M.Key then
			Delete(M.Right, Key, Success);
		else
			Delete(M.Left, Key, Success);
		end if;
	end Delete;

	function Length(M: in Map) return Natural is
	begin
		if M = null then
			return 0;
		else
			return 1 + Length(M.Left) + Length(M.Right);
		end if;
	end Length;
	
	procedure Print(M: in Map) is
	begin
		if M /= null then
			if M.Left /= null then
				Print(M.Left);
			end if;
			
			ATIO.Put("(" & 
				Key_To_String(M.Key) & ", " &
				Value_To_String(M.Value) &
				") -> [");
			if M.Up /= null then				
				ATIO.Put(Key_To_String(M.Up.Key) & ", " & Value_To_String(M.Up.Value));
			end if;
			ATIO.Put_Line("]");
			
			if M.Right /= null then
				Print(M.Right);
			end if;
		end if;
	end Print;
	
	--
	procedure Add_Key(Visited: in out List; Key: in Key_Type) is
	begin
		Visited := new Cell'(Key, Visited);
	end Add_Key;
	
	function Contains_Key(Visited: in List; Key: in Key_Type) return Boolean is
		Found: Boolean;
		P_Aux: List;
	begin
		Found := False;
		P_Aux := Visited;
		while not Found and P_Aux /= null loop
			Found := Key = P_Aux.Key;
			P_Aux := P_Aux.Next;
		end loop;
		
		return Found;
	end Contains_Key;
	--
	
	function First(M: Map) return Cursor is
		C: Cursor;
    begin
		if M /= null then
			C := (M, null);
			while C.Current.Left /= null loop
				C.Current := C.Current.Left;
			end loop;
		end if;
		
		return C;
    end First;

    procedure Next(C: in out Cursor) is
    begin
		if C.Current /= null Then
			Add_Key(C.Visited, C.Current.Key);
		
			if C.Current.Right /= null then
				C.Current := C.Current.Right;
				while C.Current.Left /= null loop
					C.Current := C.Current.Left;
				end loop;
			else
				C.Current := C.Current.Up;
				while C.Current /= null and then Contains_Key(C.Visited, C.Current.Key) loop
					C.Current := C.Current.Up;
				end loop;
			end if;
		end if;
    end Next;

    function Element(C: Cursor) return Element_Type is
    begin
		if C.Current /= null then
			return (Key => C.Current.Key, Value => C.Current.Value);
		else
			raise No_Element;
		end if;
    end Element;

    function Has_Element(C: Cursor) return Boolean is
    begin
		return C.Current /= null;
	end Has_Element;
end BTS_Maps_G;
