package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IAreaHideInfo;
   
   public class AreaHideMessageData implements IAreaHideInfo
   {
      private var _furniId:int;
      
      private var _on:Boolean;
      
      private var _rootX:int;
      
      private var _rootY:int;
      
      private var _width:int;
      
      private var _length:int;
      
      private var _invert:Boolean;
      
      public function AreaHideMessageData(param1:IMessageDataWrapper)
      {
         super();
         _furniId = param1.readInteger();
         _on = param1.readBoolean();
         _rootX = param1.readInteger();
         _rootY = param1.readInteger();
         _width = param1.readInteger();
         _length = param1.readInteger();
         _invert = param1.readBoolean();
      }
      
      public function get furniId() : int
      {
         return _furniId;
      }
      
      public function get on() : Boolean
      {
         return _on;
      }
      
      public function get rootX() : int
      {
         return _rootX;
      }
      
      public function get rootY() : int
      {
         return _rootY;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get length() : int
      {
         return _length;
      }
      
      public function get invert() : Boolean
      {
         return _invert;
      }
   }
}

