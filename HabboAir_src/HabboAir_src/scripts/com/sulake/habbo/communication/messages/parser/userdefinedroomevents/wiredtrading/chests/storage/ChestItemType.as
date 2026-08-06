package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ChestItemType
   {
      private var _isWallItem:Boolean;
      
      private var _typeId:int;
      
      private var UnknownVarFromChestItemType_String_1:String;
      
      public function ChestItemType(param1:Boolean, param2:int, param3:String)
      {
         super();
         _isWallItem = param1;
         _typeId = param2;
         UnknownVarFromChestItemType_String_1 = param3;
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : ChestItemType
      {
         var _loc3_:Boolean = param1.readBoolean();
         var _loc4_:int = param1.readInteger();
         var _loc2_:String = param1.readString();
         return new ChestItemType(_loc3_,_loc4_,_loc2_ == "" ? null : _loc2_);
      }
      
      public function get isWallItem() : Boolean
      {
         return _isWallItem;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
      
      public function get legacyPosterId() : String
      {
         return UnknownVarFromChestItemType_String_1 == null ? "" : UnknownVarFromChestItemType_String_1;
      }
      
      public function addToComposer(param1:Array) : void
      {
         param1.push(_isWallItem);
         param1.push(_typeId);
         param1.push(legacyPosterId);
      }
   }
}

