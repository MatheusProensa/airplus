package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.events.RoomObjectFurniIconAssetEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectFurniIconUpdateMessage;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import flash.utils.getTimer;
   
   public class FurnitureFurniChestLogic extends FurnitureChestLogic
   {
      private static const LOADING_ICON_PLACEHOLDER:String = "loading_icon";
      
      private static const VISUALS_KEY:String = "visuals";
      
      private static const STATE_KEY:String = "state";
      
      private var UnknownVarFromFurnitureFurniChestLogic_String_1:String = "";
      
      private var _assetNamesForVisuals:Map = new Map();
      
      public function FurnitureFurniChestLogic()
      {
         super();
      }
      
      private static function itemTypeToString(param1:Boolean, param2:int, param3:String) : String
      {
         var _loc4_:String = "";
         _loc4_ = _loc4_ + (param1 + ",");
         _loc4_ = _loc4_ + param2;
         if(param3 != "")
         {
            _loc4_ += "," + param3;
         }
         return _loc4_;
      }
      
      private static function stringToItemType(param1:String) : Object
      {
         var _loc4_:Array = param1.split(",");
         var _loc3_:* = _loc4_[0] == "true";
         var _loc5_:int = int(_loc4_[1]);
         var _loc2_:String = _loc4_.length > 2 ? _loc4_[2] : "";
         return {
            "isWallItem":_loc3_,
            "typeId":_loc5_,
            "extra":_loc2_
         };
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROFIAE_LOAD_FURNI_ICON"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:MapStuffData = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         super.processUpdateMessage(param1);
         var _loc5_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc5_ != null)
         {
            _loc3_ = _loc5_.data as MapStuffData;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.getValue("visuals");
               if(_loc5_.state % 2 != 1)
               {
                  _loc4_ = "";
               }
               if(_loc4_ != null && _loc4_ != UnknownVarFromFurnitureFurniChestLogic_String_1)
               {
                  UnknownVarFromFurnitureFurniChestLogic_String_1 = _loc4_;
                  onVisualsChange();
                  object.getModelController().setString("furniture_furni_chest_shown_asset_names",shownAssetsString);
                  this.update(getTimer());
               }
            }
         }
         var _loc2_:RoomObjectFurniIconUpdateMessage = param1 as RoomObjectFurniIconUpdateMessage;
         if(_loc2_ != null)
         {
            if(_loc2_.assetName != "loading_icon")
            {
               _loc6_ = itemTypeToString(_loc2_.wallItem,_loc2_.typeId,_loc2_.extra);
               if(_assetNamesForVisuals.hasKey(_loc6_) && _assetNamesForVisuals.getValue(_loc6_) == "loading_icon")
               {
                  _assetNamesForVisuals.replace(_loc6_,_loc2_.assetName);
                  object.getModelController().setString("furniture_furni_chest_shown_asset_names",shownAssetsString);
                  this.update(getTimer());
               }
            }
         }
      }
      
      private function onVisualsChange() : void
      {
         var _loc1_:Object = null;
         _assetNamesForVisuals = new Map();
         var _loc2_:Array = UnknownVarFromFurnitureFurniChestLogic_String_1.split(";");
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_ != "")
            {
               _assetNamesForVisuals.add(_loc3_,"loading_icon");
               _loc1_ = stringToItemType(_loc3_);
               eventDispatcher.dispatchEvent(new RoomObjectFurniIconAssetEvent("ROFIAE_LOAD_FURNI_ICON",object,_loc1_.isWallItem,_loc1_.typeId,_loc1_.extra));
            }
         }
      }
      
      private function get shownAssetsString() : String
      {
         var _loc1_:Array = [];
         var _loc2_:Array = UnknownVarFromFurnitureFurniChestLogic_String_1.split(";");
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_ != "")
            {
               _loc1_.push(_assetNamesForVisuals.getValue(_loc3_));
            }
         }
         return _loc1_.join(",");
      }
   }
}

