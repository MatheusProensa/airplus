package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveConfirmMessageParser implements IMessageParser
   {
      private var _category:int;
      
      private var _id:int;
      
      private var _confirmTitle:String;
      
      private var _confirmBody:String;
      
      public function ObjectRemoveConfirmMessageParser()
      {
         super();
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get confirmTitle() : String
      {
         return _confirmTitle;
      }
      
      public function get confirmBody() : String
      {
         return _confirmBody;
      }
      
      public function flush() : Boolean
      {
         _category = 0;
         _id = 0;
         _confirmBody = null;
         _confirmTitle = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _category = param1.readInteger() == 1 ? 20 : 10;
         _id = param1.readInteger();
         _confirmTitle = param1.readString();
         _confirmBody = param1.readString();
         return true;
      }
   }
}

