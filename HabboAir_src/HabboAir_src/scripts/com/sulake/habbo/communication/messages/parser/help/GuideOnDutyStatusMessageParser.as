package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideOnDutyStatusMessageParser implements IMessageParser
   {
      private var _onDuty:Boolean;
      
      private var _guidesOnDuty:int;
      
      private var _helpersOnDuty:int;
      
      private var _guardiansOnDuty:int;
      
      public function GuideOnDutyStatusMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _onDuty = param1.readBoolean();
         _guidesOnDuty = param1.readInteger();
         _helpersOnDuty = param1.readInteger();
         _guardiansOnDuty = param1.readInteger();
         return true;
      }
      
      public function get onDuty() : Boolean
      {
         return _onDuty;
      }
      
      public function get helpersOnDuty() : int
      {
         return _helpersOnDuty;
      }
      
      public function get guardiansOnDuty() : int
      {
         return _guardiansOnDuty;
      }
      
      public function get guidesOnDuty() : int
      {
         return _guidesOnDuty;
      }
   }
}

