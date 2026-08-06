package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PresentOpenedMessageParser implements IMessageParser
   {
      private var _itemType:String;
      
      private var _classId:int;
      
      private var _productCode:String;
      
      private var _placedItemId:int;
      
      private var _placedItemType:String;
      
      private var _placedInRoom:Boolean;
      
      private var _petFigureString:String;
      
      public function PresentOpenedMessageParser()
      {
         super();
      }
      
      public function get itemType() : String
      {
         return _itemType;
      }
      
      public function get classId() : int
      {
         return _classId;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get placedItemId() : int
      {
         return _placedItemId;
      }
      
      public function get placedItemType() : String
      {
         return _placedItemType;
      }
      
      public function get placedInRoom() : Boolean
      {
         return _placedInRoom;
      }
      
      public function get petFigureString() : String
      {
         return _petFigureString;
      }
      
      public function flush() : Boolean
      {
         _itemType = "";
         _classId = 0;
         _productCode = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _itemType = param1.readString();
         _classId = param1.readInteger();
         _productCode = param1.readString();
         _placedItemId = param1.readInteger();
         _placedItemType = param1.readString();
         _placedInRoom = param1.readBoolean();
         _petFigureString = param1.readString();
         return true;
      }
   }
}

