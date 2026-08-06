package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetCommandsMessageParser implements IMessageParser
   {
      private var _petId:int;
      
      private var _allCommands:Array;
      
      private var _enabledCommands:Array;
      
      public function PetCommandsMessageParser()
      {
         super();
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get allCommands() : Array
      {
         return _allCommands;
      }
      
      public function get enabledCommands() : Array
      {
         return _enabledCommands;
      }
      
      public function flush() : Boolean
      {
         _petId = -1;
         _allCommands = null;
         _enabledCommands = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _petId = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _allCommands = [];
         while(_loc3_-- > 0)
         {
            _allCommands.push(param1.readInteger());
         }
         var _loc2_:int = param1.readInteger();
         _enabledCommands = [];
         while(_loc2_-- > 0)
         {
            _enabledCommands.push(param1.readInteger());
         }
         return true;
      }
   }
}

