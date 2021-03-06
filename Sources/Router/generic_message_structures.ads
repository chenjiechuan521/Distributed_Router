--
--  Framework: Uwe R. Zimmer, Australia, 2015
--

with Ada.Strings.Bounded;           use Ada.Strings.Bounded;
with Generic_Routers_Configuration;

generic
   with package Routers_Configuration is new Generic_Routers_Configuration (<>);

package Generic_Message_Structures is

   use Routers_Configuration;

   package Message_Strings is new Generic_Bounded_Length (Max => 80);
   use Message_Strings;

   subtype The_Core_Message is Bounded_String;

   type Messages_Client is record
      Destination : Router_Range;
      The_Message : The_Core_Message;
   end record;

   type Messages_Mailbox is record
      Sender      : Router_Range     := Router_Range'Invalid_Value;
      The_Message : The_Core_Message := Message_Strings.To_Bounded_String ("");
      Hop_Counter : Natural          := 0;
   end record;
   type Modified is array (1 .. Positive (Router_Range'Last)) of Natural;
   type Table is array (1 .. Positive (Router_Range'Last), 1 .. Positive (Router_Range'Last)) of Natural;
   type Heart_Beat is record
      Last : Router_Range := Router_Range'Invalid_Value;
      Origin : Router_Range := Router_Range'Invalid_Value;
      The_Message : The_Core_Message;
      Destination : Router_Range := Router_Range'Invalid_Value;
      Hop_Counter : Natural := 0;
      Next : Router_Range := Router_Range'Invalid_Value;
      Courier : Boolean := False;
      Md : Modified := (others => 0);
      Tb : Table := (others => (others => Natural (Router_Range'Last + 1)));
   end record;
   -- Leave anything above this line as it will be used by the testing framework
   -- to communicate with your router.

   --  Add one or multiple more messages formats here ..

end Generic_Message_Structures;
