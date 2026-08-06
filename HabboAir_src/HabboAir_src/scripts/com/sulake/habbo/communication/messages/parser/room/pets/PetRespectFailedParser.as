package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetRespectFailedParser implements IMessageParser
   {
      private var _requiredDays:int;
      
      private var _avatarAgeInDays:int;
      
      public function PetRespectFailedParser()
      {
         super();
      }
      
      public function get requiredDays() : int
      {
         return _requiredDays;
      }
      
      public function get avatarAgeInDays() : int
      {
         return _avatarAgeInDays;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _requiredDays = param1.readInteger();
         _avatarAgeInDays = param1.readInteger();
         return true;
      }
   }
}

