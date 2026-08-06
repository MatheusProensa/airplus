package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObjectTileCursorUpdateMessage extends RoomObjectUpdateMessage
   {
      private var _height:Number;
      
      private var _sourceEventId:String;
      
      private var _visible:Boolean;
      
      private var _toggleVisibility:Boolean;
      
      public function RoomObjectTileCursorUpdateMessage(param1:Vector3d, param2:Number, param3:Boolean, param4:String, param5:Boolean = false)
      {
         super(param1,null);
         _height = param2;
         _visible = param3;
         _sourceEventId = param4;
         _toggleVisibility = param5;
      }
      
      public function get height() : Number
      {
         return _height;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function get sourceEventId() : String
      {
         return _sourceEventId;
      }
      
      public function get toggleVisibility() : Boolean
      {
         return _toggleVisibility;
      }
   }
}

