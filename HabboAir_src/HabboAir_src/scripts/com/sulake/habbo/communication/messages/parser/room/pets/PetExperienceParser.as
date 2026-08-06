package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetExperienceParser implements IMessageParser
   {
      private var _petId:int = -1;
      
      private var _petRoomIndex:int = -1;
      
      private var _gainedExperience:int = 0;
      
      public function PetExperienceParser()
      {
         super();
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get petRoomIndex() : int
      {
         return _petRoomIndex;
      }
      
      public function get gainedExperience() : int
      {
         return _gainedExperience;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _petId = param1.readInteger();
         _petRoomIndex = param1.readInteger();
         _gainedExperience = param1.readInteger();
         return true;
      }
   }
}

