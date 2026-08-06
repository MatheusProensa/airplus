package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
   
   [SecureSWF(rename="true")]
   public class PetLevelNotificationParser implements IMessageParser
   {
      private var _petId:int;
      
      private var _petName:String;
      
      private var _level:int;
      
      private var _figureData:PetFigureData;
      
      public function PetLevelNotificationParser()
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
         _petName = param1.readString();
         _level = param1.readInteger();
         _figureData = new PetFigureData(param1);
         return true;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get petName() : String
      {
         return _petName;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get figureData() : PetFigureData
      {
         return _figureData;
      }
   }
}

