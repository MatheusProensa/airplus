package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
   
   [SecureSWF(rename="true")]
   public class OpenPetPackageRequestedMessageParser implements IMessageParser
   {
      private var _objectId:int = -1;
      
      private var _figureData:PetFigureData;
      
      public function OpenPetPackageRequestedMessageParser()
      {
         super();
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get figureData() : PetFigureData
      {
         return _figureData;
      }
      
      public function flush() : Boolean
      {
         _objectId = -1;
         _figureData = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _objectId = param1.readInteger();
         if(!param1.bytesAvailable)
         {
            return true;
         }
         _figureData = new PetFigureData(param1);
         return true;
      }
   }
}

