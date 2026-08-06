package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ObjectIdAndValuePair
   {
      private var _objectId:int;
      
      private var _value:int;
      
      public function ObjectIdAndValuePair(param1:IMessageDataWrapper)
      {
         super();
         _objectId = param1.readInteger();
         _value = param1.readInteger();
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get value() : int
      {
         return _value;
      }
   }
}

