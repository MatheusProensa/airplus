package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SelectorDefinition extends Triggerable
   {
      private var _isFilter:Boolean;
      
      private var _isInvert:Boolean;
      
      public function SelectorDefinition(param1:IMessageDataWrapper)
      {
         super(param1);
      }
      
      override protected function readDefinitionSpecifics(param1:IMessageDataWrapper) : void
      {
         _isFilter = param1.readBoolean();
         _isInvert = param1.readBoolean();
      }
      
      public function set isFilter(param1:Boolean) : void
      {
         _isFilter = param1;
      }
      
      public function set isInvert(param1:Boolean) : void
      {
         _isInvert = param1;
      }
      
      public function get isFilter() : Boolean
      {
         return _isFilter;
      }
      
      public function get isInvert() : Boolean
      {
         return _isInvert;
      }
   }
}

