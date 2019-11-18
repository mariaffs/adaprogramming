generic
	type Key_Type is private;
	type Value_Type is private;
	with function "=" (K1, K2: Key_Type) return Boolean;
	with function "<" (K1, K2: Key_Type) return Boolean;
	with function ">" (K1, K2: Key_Type) return Boolean;
	with function Key_To_String (K: Key_Type) return String;
	with function Value_To_String (K: Value_Type) return String;
package BTS_Maps_G is
	type Map is limited private;

	procedure Get(M: Map; 
		Key: in Key_Type; Value: out Value_Type; 
		Success: out Boolean);

	procedure Put(M: in out Map; 
		Key: in Key_Type; 
		Value: in Value_Type);

	procedure Delete(M: in out Map; 
		Key: in Key_Type; 
		Success: out Boolean);

	function Length(M: in Map) return Natural;

	procedure Print(M: in Map);
	
	type Cursor is limited private;
	function First(M: Map) return Cursor;
	procedure Next(C: in out Cursor);
	function Has_Element(C: Cursor) return Boolean;
	type Element_Type is record
		Key: Key_Type;
		Value: Value_Type;
	end record;
	No_Element: exception;

	-- Raises No_Element if Has_Element(C) = False;
	function Element(C: Cursor) return Element_Type;
private
	type Tree_Node;
	type Map is access Tree_Node;
	type Tree_Node is record
		Up: Map; -- Father
		Key: Key_Type;
		Value: Value_Type;
		Left: Map;
		Right: Map;
	end record;
	
	type Cell;
	type List is access Cell;
	type Cell is record
		Key: Key_Type;
		Next: List;
	end record;
	
	type Cursor is record
		Current: Map; -- Current Tree Node
		Visited: List; -- Visited Keys
	end record;
end BTS_Maps_G;
