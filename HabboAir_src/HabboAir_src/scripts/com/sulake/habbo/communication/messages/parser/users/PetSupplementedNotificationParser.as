package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetSupplementedNotificationParser implements IMessageParser
   {
      private var _petId:int;
      
      private var _userId:int;
      
      private var _supplementType:int;
      
      public function PetSupplementedNotificationParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _petId = param1.readInteger();
         _userId = param1.readInteger();
         _supplementType = param1.readInteger();
         return true;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get supplementType() : int
      {
         return _supplementType;
      }
   }
}

