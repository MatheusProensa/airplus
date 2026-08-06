package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
   
   [SecureSWF(rename="true")]
   public class FlatControllersMessageParser implements IMessageParser
   {
      private var _roomId:int;
      
      private var _controllers:Array;
      
      public function FlatControllersMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _roomId = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _controllers.push(new FlatControllerData(param1));
            _loc2_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _controllers = [];
         return true;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get controllers() : Array
      {
         return _controllers;
      }
   }
}

