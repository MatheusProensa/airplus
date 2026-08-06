package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UniqueMachineIDParser implements IMessageParser
   {
      private var _machineID:String;
      
      public function UniqueMachineIDParser()
      {
         super();
         _machineID = "";
      }
      
      public function flush() : Boolean
      {
         _machineID = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _machineID = param1.readString();
         return true;
      }
      
      public function get machineID() : String
      {
         return _machineID;
      }
   }
}

