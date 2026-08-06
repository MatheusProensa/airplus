package com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views
{
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class ChestItemTypeRenderableWrapper implements IProductDisplayInfo
   {
      private var _chestItemType:ChestItemType;
      
      public function ChestItemTypeRenderableWrapper(param1:ChestItemType)
      {
         super();
         _chestItemType = param1;
      }
      
      public function get productTypeId() : int
      {
         return _chestItemType.isWallItem ? 0 : 1;
      }
      
      public function get itemTypeId() : String
      {
         return String(_chestItemType.typeId);
      }
      
      public function get extraData() : String
      {
         return _chestItemType.legacyPosterId;
      }
      
      public function get petFigureString() : String
      {
         return "";
      }
      
      public function get botFigureString() : String
      {
         return "";
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return null;
      }
   }
}

