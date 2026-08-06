package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MaintenanceStatusMessageParser implements IMessageParser
   {
      private var _isInMaintenance:Boolean;
      
      private var _minutesUntilMaintenance:int;
      
      private var _duration:int = 15;
      
      public function MaintenanceStatusMessageParser()
      {
         super();
      }
      
      public function get isInMaintenance() : Boolean
      {
         return _isInMaintenance;
      }
      
      public function get minutesUntilMaintenance() : int
      {
         return _minutesUntilMaintenance;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isInMaintenance = param1.readBoolean();
         _minutesUntilMaintenance = param1.readInteger();
         if(param1.bytesAvailable)
         {
            _duration = param1.readInteger();
         }
         return true;
      }
   }
}

