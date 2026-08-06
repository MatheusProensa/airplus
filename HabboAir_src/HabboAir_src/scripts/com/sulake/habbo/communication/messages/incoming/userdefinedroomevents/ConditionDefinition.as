package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ConditionDefinition extends Triggerable
   {
      private var _quantifierCode:int;
      
      private var _quantifierType:int;
      
      private var _isInvert:Boolean;
      
      public function ConditionDefinition(param1:IMessageDataWrapper)
      {
         super(param1);
      }
      
      override protected function readDefinitionSpecifics(param1:IMessageDataWrapper) : void
      {
         _quantifierCode = param1.readInteger();
      }
      
      override protected function readTypeSpecifics(param1:IMessageDataWrapper) : void
      {
         _quantifierType = param1.readByte();
         _isInvert = param1.readBoolean();
      }
      
      public function get quantifierCode() : int
      {
         return _quantifierCode;
      }
      
      public function set quantifierCode(param1:int) : void
      {
         _quantifierCode = param1;
      }
      
      public function get quantifierType() : int
      {
         return _quantifierType;
      }
      
      public function get isInvert() : Boolean
      {
         return _isInvert;
      }
      
      override public function get usingCustomInputSources() : Boolean
      {
         return super.usingCustomInputSources || quantifierCode != 0;
      }
   }
}

