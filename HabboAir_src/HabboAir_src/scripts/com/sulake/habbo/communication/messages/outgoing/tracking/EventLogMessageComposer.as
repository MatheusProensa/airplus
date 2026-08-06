package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class EventLogMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromEventLogMessageComposer_String_1:String;
      
      private var UnknownVarFromEventLogMessageComposer_String_2:String;
      
      private var _action:String;
      
      private var _extraString:String;
      
      private var UnknownVarFromEventLogMessageComposer_Int_1:int;
      
      public function EventLogMessageComposer(param1:String, param2:String, param3:String, param4:String = "", param5:int = 0)
      {
         super();
         UnknownVarFromEventLogMessageComposer_String_1 = !!param1 ? param1 : "";
         UnknownVarFromEventLogMessageComposer_String_2 = !!param2 ? param2 : "";
         _action = !!param3 ? param3 : "";
         _extraString = !!param4 ? param4 : "";
         UnknownVarFromEventLogMessageComposer_Int_1 = !!param5 ? param5 : 0;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromEventLogMessageComposer_String_1,UnknownVarFromEventLogMessageComposer_String_2,_action,_extraString,UnknownVarFromEventLogMessageComposer_Int_1];
      }
   }
}

