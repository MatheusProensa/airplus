package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ActionDefinition extends Triggerable
   {
      private var _delayInPulses:int;
      
      public function ActionDefinition(param1:IMessageDataWrapper)
      {
         super(param1);
      }
      
      override protected function readDefinitionSpecifics(param1:IMessageDataWrapper) : void
      {
         _delayInPulses = param1.readInteger();
      }
      
      public function get delayInPulses() : int
      {
         return _delayInPulses;
      }
      
      public function set delayInPulses(param1:int) : void
      {
         _delayInPulses = param1;
      }
   }
}

