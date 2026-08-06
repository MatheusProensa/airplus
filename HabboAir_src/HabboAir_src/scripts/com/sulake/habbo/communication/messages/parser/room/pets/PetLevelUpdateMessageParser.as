package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetLevelUpdateMessageParser implements IMessageParser
   {
      private var _roomIndex:int;
      
      private var _petId:int;
      
      private var _level:int;
      
      public function PetLevelUpdateMessageParser()
      {
         super();
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomIndex = param1.readInteger();
         _petId = param1.readInteger();
         _level = param1.readInteger();
         return true;
      }
   }
}

