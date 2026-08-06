package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageData;
   
   [SecureSWF(rename="true")]
   public class RoomDimmerPresetsMessageParser implements IMessageParser
   {
      private var _selectedPresetId:int = 0;
      
      private var UnknownVarFromRoomDimmerPresetsMessageParser_Array_1:Array = [];
      
      private var _itemId:int = 0;
      
      private var _isOn:Boolean = false;
      
      public function RoomDimmerPresetsMessageParser()
      {
         super();
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function get presetCount() : int
      {
         return UnknownVarFromRoomDimmerPresetsMessageParser_Array_1.length;
      }
      
      public function get selectedPresetId() : int
      {
         return _selectedPresetId;
      }
      
      public function getPreset(param1:int) : RoomDimmerPresetsMessageData
      {
         if(param1 < 0 || param1 >= presetCount)
         {
            return null;
         }
         return UnknownVarFromRoomDimmerPresetsMessageParser_Array_1[param1];
      }
      
      public function get isOn() : Boolean
      {
         return _isOn;
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromRoomDimmerPresetsMessageParser_Array_1 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:RoomDimmerPresetsMessageData = null;
         var _loc4_:int = param1.readInteger();
         _selectedPresetId = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readInteger();
            _loc9_ = param1.readInteger();
            _loc6_ = param1.readString();
            _loc2_ = parseInt(_loc6_.substr(1),16);
            _loc3_ = param1.readInteger();
            _loc8_ = new RoomDimmerPresetsMessageData(_loc7_);
            _loc8_.type = _loc9_;
            _loc8_.color = _loc2_;
            _loc8_.light = _loc3_;
            _loc8_.setReadOnly();
            UnknownVarFromRoomDimmerPresetsMessageParser_Array_1.push(_loc8_);
            _loc5_++;
         }
         _isOn = param1.readBoolean();
         _itemId = param1.readInteger();
         return true;
      }
   }
}

