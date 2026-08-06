package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorActionResultMessageParser implements IMessageParser
   {
      private var _userId:int;
      
      private var _success:Boolean;
      
      public function ModeratorActionResultMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         _success = param1.readBoolean();
         return true;
      }
   }
}

