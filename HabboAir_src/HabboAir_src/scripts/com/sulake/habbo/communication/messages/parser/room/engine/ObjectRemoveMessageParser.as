package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveMessageParser implements IMessageParser
   {
      private var _id:int;
      
      private var _isExpired:Boolean;
      
      private var _pickerId:int;
      
      private var _delay:int;
      
      public function ObjectRemoveMessageParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get isExpired() : Boolean
      {
         return _isExpired;
      }
      
      public function get pickerId() : int
      {
         return _pickerId;
      }
      
      public function get delay() : int
      {
         return _delay;
      }
      
      public function flush() : Boolean
      {
         _id = 0;
         _delay = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _id = int(param1.readString());
         _isExpired = param1.readBoolean();
         _pickerId = param1.readInteger();
         _delay = param1.readInteger();
         return true;
      }
   }
}

