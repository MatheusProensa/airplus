package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class CollectiblesProductItem
   {
      private var _itemTypeId:int;
      
      private var _startTime:int;
      
      private var _endTime:int;
      
      private var _regionLocked:Boolean;
      
      private var _price:int;
      
      private var _limitedEdition:Boolean;
      
      private var _itemType:String;
      
      public function CollectiblesProductItem(param1:IMessageDataWrapper)
      {
         super();
         _itemTypeId = param1.readInteger();
         _startTime = param1.readInteger();
         _endTime = param1.readInteger();
         _regionLocked = param1.readBoolean();
         _price = param1.readInteger();
         _limitedEdition = param1.readBoolean();
         var _loc2_:int = param1.readShort();
         switch(_loc2_)
         {
            case 0:
               _itemType = "s";
               break;
            case 1:
               _itemType = "i";
               break;
            case 2:
               _itemType = "cl";
               break;
            default:
               _itemType = "s";
         }
      }
      
      public function get itemTypeId() : int
      {
         return _itemTypeId;
      }
      
      public function get startTime() : int
      {
         return _startTime;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
      
      public function get regionLocked() : Boolean
      {
         return _regionLocked;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function get limitedEdition() : Boolean
      {
         return _limitedEdition;
      }
      
      public function get itemType() : String
      {
         return _itemType;
      }
   }
}

