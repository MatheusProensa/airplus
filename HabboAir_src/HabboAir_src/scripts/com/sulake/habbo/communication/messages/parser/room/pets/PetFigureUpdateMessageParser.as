package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
   
   [SecureSWF(rename="true")]
   public class PetFigureUpdateMessageParser implements IMessageParser
   {
      private var _roomIndex:int;
      
      private var _petId:int;
      
      private var _figureData:PetFigureData;
      
      private var _hasSaddle:Boolean;
      
      private var _isRiding:Boolean;
      
      public function PetFigureUpdateMessageParser()
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
      
      public function get figureData() : PetFigureData
      {
         return _figureData;
      }
      
      public function get hasSaddle() : Boolean
      {
         return _hasSaddle;
      }
      
      public function get isRiding() : Boolean
      {
         return _isRiding;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomIndex = param1.readInteger();
         _petId = param1.readInteger();
         _figureData = new PetFigureData(param1);
         _hasSaddle = param1.readBoolean();
         _isRiding = param1.readBoolean();
         return true;
      }
   }
}

