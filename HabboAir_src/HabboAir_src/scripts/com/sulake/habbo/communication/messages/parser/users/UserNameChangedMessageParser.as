package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserNameChangedMessageParser implements IMessageParser
   {
      private var _webId:int;
      
      private var _id:int;
      
      private var _newName:String;
      
      public function UserNameChangedMessageParser()
      {
         super();
      }
      
      public function get webId() : int
      {
         return _webId;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get newName() : String
      {
         return _newName;
      }
      
      public function flush() : Boolean
      {
         _webId = -1;
         _id = -1;
         _newName = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _webId = param1.readInteger();
         _id = param1.readInteger();
         _newName = param1.readString();
         return true;
      }
   }
}

